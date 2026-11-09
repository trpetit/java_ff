package io.github.raeperd.realworld.application.user;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeName;
import io.github.raeperd.realworld.domain.user.User;

import static com.fasterxml.jackson.annotation.JsonTypeInfo.As.WRAPPER_OBJECT;
import static com.fasterxml.jackson.annotation.JsonTypeInfo.Id.NAME;
import static java.lang.String.valueOf;

/**
 * Serialized as {@code {"user": {...}}}, the envelope required by the RealWorld spec.
 * <p>
 * Unlike the article, comment and profile responses, the envelope comes from {@code @JsonTypeInfo}
 * rather than from a wrapping record. That annotation wraps the type everywhere it is serialized, which
 * is fine here because a user is never returned without the envelope. The request DTOs use the same style.
 */
@JsonTypeName("user")
@JsonTypeInfo(include = WRAPPER_OBJECT, use = NAME)
record UserResponse(String email, String username, String token, String bio, String image) {

    static UserResponse fromUserAndToken(User user, String token) {
        return new UserResponse(
                valueOf(user.getEmail()),
                valueOf(user.getName()),
                token,
                "",
                "");
    }
}
