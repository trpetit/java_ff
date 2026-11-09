package io.github.raeperd.realworld.application.article;

import tools.jackson.databind.ObjectMapper;
import io.github.raeperd.realworld.application.security.WithMockJWTUser;
import io.github.raeperd.realworld.domain.article.ArticleService;
import io.github.raeperd.realworld.domain.jwt.JWTDeserializer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.stream.Stream;

import static java.util.Collections.emptyList;

import static java.util.Collections.emptySet;
import static org.hamcrest.Matchers.is;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.then;
import static org.springframework.data.domain.Sort.Direction.DESC;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WithMockJWTUser
@WebMvcTest(ArticleRestController.class)
class ArticleRestControllerTest {

    @MockitoBean
    private ArticleService articleService;
    @MockitoBean
    private JWTDeserializer jwtDeserializer;

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private ObjectMapper objectMapper;


    @MethodSource("provideInvalidPostDTO")
    @ParameterizedTest
    void when_post_article_with_invalid_body_expect_status_badRequest(ArticlePostRequestDTO invalidDTO) throws Exception {
        mockMvc.perform(post("/articles")
                .contentType(APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(invalidDTO)))
                .andExpect(status().isBadRequest());
    }

    private static Stream<Arguments> provideInvalidPostDTO() {
        return Stream.of(
                Arguments.of(new ArticlePostRequestDTO(null, "description", "body", emptySet())),
                Arguments.of(new ArticlePostRequestDTO("title", null, "body", emptySet())),
                Arguments.of(new ArticlePostRequestDTO("title", "description", null, emptySet())),
                Arguments.of(new ArticlePostRequestDTO("title", "description", "body", null)),
                Arguments.of(new ArticlePostRequestDTO(" ", "description", "body", emptySet())),
                Arguments.of(new ArticlePostRequestDTO("title", " ", "body", emptySet())),
                Arguments.of(new ArticlePostRequestDTO("title", "description", " ", emptySet())));
    }

    @Test
    void when_get_articles_with_offset_and_limit_expect_page_of_most_recent_articles() throws Exception {
        given(articleService.getArticles(any())).willReturn(new PageImpl<>(emptyList()));

        mockMvc.perform(get("/articles?offset=20&limit=10"))
                .andExpect(status().isOk());

        then(articleService).should().getArticles(PageRequest.of(2, 10, DESC, "createdAt", "id"));
    }

    @Test
    void when_get_articles_without_offset_and_limit_expect_first_20_articles() throws Exception {
        given(articleService.getArticles(any())).willReturn(new PageImpl<>(emptyList()));

        mockMvc.perform(get("/articles"))
                .andExpect(status().isOk());

        then(articleService).should().getArticles(PageRequest.of(0, 20, DESC, "createdAt", "id"));
    }

    @ValueSource(strings = {"offset=-1", "limit=0", "limit=101"})
    @ParameterizedTest
    void when_get_articles_with_invalid_offset_or_limit_expect_status_badRequest(String query) throws Exception {
        mockMvc.perform(get("/articles?" + query))
                .andExpect(status().isBadRequest());
    }

    @Test
    void when_get_articles_expect_articlesCount_is_total_count() throws Exception {
        final Pageable secondPage = PageRequest.of(1, 10);
        given(articleService.getArticles(any())).willReturn(new PageImpl<>(emptyList(), secondPage, 42));

        mockMvc.perform(get("/articles?offset=10&limit=10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("articlesCount", is(42)));
    }
}
