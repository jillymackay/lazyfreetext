library (tidyverse)
library (tidytext)
library (textstem)


#' The quicktfplot function
#' This function quickly calculates a term-frequency inverse-document-frequency plot for any grouped data
#' @param data name of your dataset (data must be tokenised, see lazyfreetext)
#' @param token name of your 'token' you are counting, defaults to 'lemma' from lazyfreetext
#' @param grouping_factor what group do you want your tf_idf to be created from
#' @param topn number passed to top_n
#' @examples none yet!

quicktfplot <- function (data, token = "lemma", grouping_factor, topn) {
  qgv <- enquo(grouping_factor)
  t <- enquo(token)

  data %>%
    group_by(!!qgv) %>%
    count (!!qgv, !!t, sort = TRUE) %>%
    ungroup() %>%
    mutate (total = sum(n)) %>%
    bind_tf_idf (., !!t, !!qgv, n) %>%
    arrange(desc (tf_idf)) %>%
    mutate (word = factor(!!t, levels = rev(unique(!!t)))) %>%
    group_by (!!qgv) %>%
    top_n(topn, tf_idf) %>%
    ungroup() %>%
    ggplot(aes(x = word, y = tf_idf, fill = !!qgv)) +
    geom_col(show.legend = FALSE) +
    labs (x = NULL, y = "Term Frequency - Inverse Document Frequency") +
    facet_wrap(facets = vars(!!qgv), scales = "free") +
    theme_classic() +
    coord_flip()
}
