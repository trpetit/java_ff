package io.github.raeperd.realworld.application.article;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import static org.springframework.data.domain.Sort.Order.desc;

/**
 * The {@code offset} and {@code limit} query parameters of the RealWorld spec.
 * <p>
 * {@code offset} is a number of articles to skip, while a Spring Data {@link Pageable} expects a page
 * number, so it is converted here. The frontend always sends an offset that is a multiple of the limit;
 * any other offset is rounded down to the start of its page.
 */
record OffsetLimitRequest(@Min(0) Integer offset, @Min(1) @Max(100) Integer limit) {

    private static final int DEFAULT_OFFSET = 0;
    private static final int DEFAULT_LIMIT = 20;
    private static final Sort MOST_RECENT_FIRST = Sort.by(desc("createdAt"), desc("id"));

    Pageable toPageable() {
        final int pageSize = limit == null ? DEFAULT_LIMIT : limit;
        final int skipped = offset == null ? DEFAULT_OFFSET : offset;
        return PageRequest.of(skipped / pageSize, pageSize, MOST_RECENT_FIRST);
    }
}
