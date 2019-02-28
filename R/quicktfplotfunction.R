library (tidyverse)
library (tidytext)
library (textstem)

# This isnae working yet!!!
# prob need to pass a bunch of other things through this
# like the top_n val
# and probably some other shit

quicktfplot <- function (data, token, grouping_factor) {
  qgv <- enquo(grouping_factor)
  t <- enquo(token)
   data %>%
     group_by(!!qgv) %>%
     count (!!qgv, !!t, sort = TRUE) %>%
     ungroup() %>%
     mutate (total = sum(n)) %>%
     bind_tf_idf (., !!t, !!qgv, n) %>%
     arrange(desc (tf_idf)) %>%
     mutate(t = factor(!!t), levels = rev(unique(!!t))) %>%
     group_by (!!qgv) %>%
     top_n(5, tf_idf) %>%
     ungroup() %>%
     ggplot(aes(t, tf_idf, fill = !!qgv)) +
     geom_col(show.legend = FALSE) +
     labs (x = NULL, y = "Term Frequency - Inverse Document Frequency") +
     facet_wrap(~!!qgv, scales = "free") +
     theme_classic() +
     coord_flip()

  }
