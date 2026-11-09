package io.github.raeperd.realworld.application.user;

import io.github.raeperd.realworld.domain.user.Profile;

import static java.lang.String.valueOf;

public record ProfileDTO(String username, String bio, String image, boolean following) {

    public static ProfileDTO fromProfile(Profile profile) {
        return new ProfileDTO(valueOf(profile.getUserName()),
                profile.getBio(),
                valueOf(profile.getImage()),
                profile.isFollowing());
    }
}
