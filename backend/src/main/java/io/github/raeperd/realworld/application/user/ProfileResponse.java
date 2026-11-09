package io.github.raeperd.realworld.application.user;

import io.github.raeperd.realworld.domain.user.Profile;

/**
 * JSON envelope {@code {"profile": {...}}} required by the RealWorld spec.
 * <p>
 * An explicit record rather than {@code @JsonTypeInfo(include = WRAPPER_OBJECT)}, because
 * {@link ProfileDTO} is also serialized without the envelope, as the author of articles and comments.
 */
public record ProfileResponse(ProfileDTO profile) {

    public static ProfileResponse fromProfile(Profile profile) {
        return new ProfileResponse(ProfileDTO.fromProfile(profile));
    }
}
