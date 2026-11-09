package io.github.raeperd.realworld.application.article;

import io.github.raeperd.realworld.domain.article.Article;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * {@code articlesCount} is the total number of matching articles, not the size of this page:
 * the frontend uses it to compute the number of pages.
 */
record MultipleArticlesResponse(List<ArticleDTO> articles, long articlesCount) {

    static MultipleArticlesResponse fromArticles(Page<Article> articles) {
        final var articlesCollected = articles.map(ArticleDTO::fromArticle)
                .stream().toList();
        return new MultipleArticlesResponse(articlesCollected, articles.getTotalElements());
    }
}
