package io.github.raeperd.realworld.application.article.comment;

import io.github.raeperd.realworld.application.user.ProfileDTO;
import io.github.raeperd.realworld.domain.article.comment.Comment;

import java.time.ZoneId;
import java.time.ZonedDateTime;

record CommentDTO(
        long id,
        String body,
        ZonedDateTime createdAt,
        ZonedDateTime updatedAt,
        ProfileDTO author) {

    static CommentDTO fromComment(Comment comment) {
        return new CommentDTO(comment.getId(),
                comment.getBody(),
                comment.getCreatedAt().atZone(ZoneId.of("Asia/Seoul")),
                comment.getUpdatedAt().atZone(ZoneId.of("Asia/Seoul")),
                ProfileDTO.fromProfile(comment.getAuthor().getProfile()));
    }
}
