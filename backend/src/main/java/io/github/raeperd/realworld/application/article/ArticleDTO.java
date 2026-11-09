package io.github.raeperd.realworld.application.article;

import io.github.raeperd.realworld.application.user.ProfileDTO;
import io.github.raeperd.realworld.domain.article.Article;
import io.github.raeperd.realworld.domain.article.tag.Tag;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Set;

import static java.util.stream.Collectors.toSet;

record ArticleDTO(
        String slug,
        String title,
        String description,
        String body,
        Set<String> tagList,
        ZonedDateTime createdAt,
        ZonedDateTime updatedAt,
        boolean favorited,
        int favoritesCount,
        ProfileDTO author) {

    static ArticleDTO fromArticle(Article article) {
        final var contents = article.getContents();
        final var titleFromArticle = contents.getTitle();
        return new ArticleDTO(
                titleFromArticle.getSlug(), titleFromArticle.getTitle(),
                contents.getDescription(), contents.getBody(),
                contents.getTags().stream().map(Tag::toString).collect(toSet()),
                article.getCreatedAt().atZone(ZoneId.of("Asia/Seoul")),
                article.getUpdatedAt().atZone(ZoneId.of("Asia/Seoul")),
                article.isFavorited(), article.getFavoritedCount(),
                ProfileDTO.fromProfile(article.getAuthor().getProfile())
        );
    }
}
