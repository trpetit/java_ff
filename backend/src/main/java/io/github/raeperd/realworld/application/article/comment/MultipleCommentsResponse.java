package io.github.raeperd.realworld.application.article.comment;

import io.github.raeperd.realworld.domain.article.comment.Comment;

import java.util.List;
import java.util.Set;

record MultipleCommentsResponse(List<CommentDTO> comments) {

    static MultipleCommentsResponse fromComments(Set<Comment> comments) {
        final var commentsCollected = comments.stream().map(CommentDTO::fromComment)
                .toList();
        return new MultipleCommentsResponse(commentsCollected);
    }
}
