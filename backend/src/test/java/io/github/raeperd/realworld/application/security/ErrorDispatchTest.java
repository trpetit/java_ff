package io.github.raeperd.realworld.application.security;

import io.github.raeperd.realworld.domain.jwt.JWTSerializer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import static io.github.raeperd.realworld.domain.user.UserTestUtils.databaseUser;
import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.RANDOM_PORT;
import static org.springframework.http.HttpHeaders.AUTHORIZATION;

/**
 * Uses a real server, because MockMvc does not perform the ERROR dispatch to {@code /error}.
 * <p>
 * This test starts its own application context, so it also needs its own in-memory database:
 * the seed data would be inserted twice in a shared one.
 */
@Import(ErrorDispatchTest.FailingController.class)
@SpringBootTest(webEnvironment = RANDOM_PORT,
        properties = "spring.datasource.url=jdbc:h2:mem:error-dispatch;DB_CLOSE_DELAY=-1;MODE=PostgreSQL;DATABASE_TO_LOWER=TRUE")
class ErrorDispatchTest {

    @LocalServerPort
    private int port;
    @Autowired
    private JWTSerializer jwtSerializer;

    private final HttpClient client = HttpClient.newHttpClient();

    @Test
    void when_authenticated_request_throws_unhandled_exception_expect_status_internalServerError() throws Exception {
        final var request = request("/failing")
                .header(AUTHORIZATION, "Token " + jwtSerializer.jwtFromUser(databaseUser()))
                .build();

        assertThat(send(request).statusCode()).isEqualTo(500);
    }

    @Test
    void when_anonymous_request_has_invalid_parameter_expect_status_badRequest() throws Exception {
        assertThat(send(request("/articles?limit=0").build()).statusCode()).isEqualTo(400);
    }

    private HttpRequest.Builder request(String path) {
        return HttpRequest.newBuilder(URI.create("http://localhost:" + port + "/api" + path));
    }

    private HttpResponse<String> send(HttpRequest request) throws IOException, InterruptedException {
        return client.send(request, HttpResponse.BodyHandlers.ofString());
    }

    @TestConfiguration
    @RestController
    static class FailingController {

        @GetMapping("/failing")
        String fail() {
            throw new IllegalStateException("unhandled");
        }
    }
}
