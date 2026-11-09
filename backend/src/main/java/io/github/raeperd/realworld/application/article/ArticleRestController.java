package io.github.raeperd.realworld.application.article;

import io.github.raeperd.realworld.domain.article.ArticleService;
import io.github.raeperd.realworld.domain.user.UserName;
import io.github.raeperd.realworld.infrastructure.jwt.UserJWTPayload;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

import static org.springframework.http.HttpStatus.NO_CONTENT;
import static org.springframework.http.ResponseEntity.of;

@RestController
class ArticleRestController {

    private final ArticleService articleService;

    ArticleRestController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @PostMapping("/articles")
    public ArticleResponse postArticle(@AuthenticationPrincipal UserJWTPayload jwtPayload,
                                    @Valid @RequestBody ArticlePostRequestDTO dto) {
        var articleCreated = articleService.createNewArticle(jwtPayload.getUserId(), dto.toArticleContents());
        return ArticleResponse.fromArticle(articleCreated);
    }

    @GetMapping("/articles")
    public MultipleArticlesResponse getArticles(@Valid OffsetLimitRequest page) {
        final var articles = articleService.getArticles(page.toPageable());
        return MultipleArticlesResponse.fromArticles(articles);
    }

    @GetMapping(value = "/articles", params = {"author"})
    public MultipleArticlesResponse getArticlesByAuthor(@RequestParam String author, @Valid OffsetLimitRequest page) {
        final var articles = articleService.getArticlesByAuthorName(author, page.toPageable());
        return MultipleArticlesResponse.fromArticles(articles);
    }

    @GetMapping(value = "/articles", params = {"tag"})
    public MultipleArticlesResponse getArticlesByTag(@RequestParam String tag, @Valid OffsetLimitRequest page) {
        final var articles = articleService.getArticlesByTag(tag, page.toPageable());
        return MultipleArticlesResponse.fromArticles(articles);
    }

    @GetMapping(value = "/articles", params = {"favorited"})
    public MultipleArticlesResponse getArticleByFavoritedUsername(@RequestParam UserName favorited, @Valid OffsetLimitRequest page) {
        final var articles = articleService.getArticleFavoritedByUsername(favorited, page.toPageable());
        return MultipleArticlesResponse.fromArticles(articles);
    }

    @GetMapping("/articles/feed")
    public MultipleArticlesResponse getFeed(@AuthenticationPrincipal UserJWTPayload jwtPayload, @Valid OffsetLimitRequest page) {
        final var articles = articleService.getFeedByUserId(jwtPayload.getUserId(), page.toPageable());
        return MultipleArticlesResponse.fromArticles(articles);
    }

    @GetMapping("/articles/{slug}")
    public ResponseEntity<ArticleResponse> getArticleBySlug(@PathVariable String slug) {
        return of(articleService.getArticleBySlug(slug)
                .map(ArticleResponse::fromArticle));
    }

    @PutMapping("/articles/{slug}")
    public ArticleResponse putArticleBySlug(@AuthenticationPrincipal UserJWTPayload jwtPayload,
                                         @PathVariable String slug,
                                         @RequestBody ArticlePutRequestDTO dto) {
        final var articleUpdated = articleService.updateArticle(jwtPayload.getUserId(), slug, dto.toUpdateRequest());
        return ArticleResponse.fromArticle(articleUpdated);
    }

    @PostMapping("/articles/{slug}/favorite")
    public ArticleResponse favoriteArticleBySlug(@AuthenticationPrincipal UserJWTPayload jwtPayload,
                                              @PathVariable String slug) {
        var articleFavorited = articleService.favoriteArticle(jwtPayload.getUserId(), slug);
        return ArticleResponse.fromArticle(articleFavorited);
    }

    @DeleteMapping("/articles/{slug}/favorite")
    public ArticleResponse unfavoriteArticleBySlug(@AuthenticationPrincipal UserJWTPayload jwtPayload,
                                                @PathVariable String slug) {
        var articleUnfavored = articleService.unfavoriteArticle(jwtPayload.getUserId(), slug);
        return ArticleResponse.fromArticle(articleUnfavored);
    }

    @ResponseStatus(NO_CONTENT)
    @DeleteMapping("/articles/{slug}")
    public void deleteArticleBySlug(@AuthenticationPrincipal UserJWTPayload jwtPayload,
                                    @PathVariable String slug) {
        articleService.deleteArticleBySlug(jwtPayload.getUserId(), slug);
    }
}
