package io.github.raeperd.realworld.application.article;

import io.github.raeperd.realworld.domain.article.Article;

/**
 * JSON envelope {@code {"article": {...}}} required by the RealWorld spec.
 * <p>
 * The envelope is an explicit record, not {@code @JsonTypeInfo(include = WRAPPER_OBJECT)} like
 * {@code UserResponse}: that annotation wraps the type everywhere it is serialized, and
 * {@link ArticleDTO} is also serialized without the envelope, in {@link MultipleArticlesResponse}.
 */
record ArticleResponse(ArticleDTO article) {

    static ArticleResponse fromArticle(Article article) {
        return new ArticleResponse(ArticleDTO.fromArticle(article));
    }
}
