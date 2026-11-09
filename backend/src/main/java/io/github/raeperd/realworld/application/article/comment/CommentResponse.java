package io.github.raeperd.realworld.application.article.comment;

import io.github.raeperd.realworld.domain.article.comment.Comment;

/**
 * JSON envelope {@code {"comment": {...}}} required by the RealWorld spec.
 * <p>
 * An explicit record rather than {@code @JsonTypeInfo(include = WRAPPER_OBJECT)}, because
 * {@link CommentDTO} is also serialized without the envelope, in {@link MultipleCommentsResponse}.
 */
record CommentResponse(CommentDTO comment) {

    static CommentResponse fromComment(Comment comment) {
        return new CommentResponse(CommentDTO.fromComment(comment));
    }
}
