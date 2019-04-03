# Function help

# I want to write a function that will plot a specific kind of chart that I make a lot.
# But I cannot work out my error.


library(tidyverse)

t <- readr::read_csv("data/t1.csv")



# This is the chart I want to make:
t %>%
  group_by(ID) %>%
  count (ID, lemma, sort = TRUE) %>%
  ungroup() %>%
  mutate (total = sum(n)) %>%
  bind_tf_idf (., lemma, ID, n) %>%
  arrange(desc (tf_idf)) %>%
  mutate (word = factor(lemma, levels = rev(unique(lemma)))) %>%
  group_by (ID) %>%
  top_n(5, tf_idf) %>%
  ungroup() %>%
  ggplot(aes(word, tf_idf, fill = ID)) +
  geom_col(show.legend = FALSE) +
  labs (x = NULL, y = "Term Frequency - Inverse Document Frequency") +
  facet_wrap(~ID, scales = "free") +
  theme_classic() +
  coord_flip()

# This is my attempt at a function

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
    mutate (word = factor(!!t, levels = rev(unique(!!t)))) %>%
    group_by (!!qgv) %>%
    top_n(5, tf_idf) %>%
    ungroup() %>%
    ggplot(aes(x = word, y = tf_idf, fill = !!qgv)) +
    geom_col(show.legend = FALSE) +
    labs (x = NULL, y = "Term Frequency - Inverse Document Frequency") +
    facet_wrap(~!!qgv, scales = "free") +
    theme_classic() +
    coord_flip()
}


quicktfplot(t, "lemma", "ID")







# I don't get the same error with mpg for example:

mpg %>%
  arrange (desc(cty)) %>%
  mutate(newx = factor(class, levels = rev(unique(class)))) %>%
  group_by(newx) %>%
  top_n(3,cty) %>%
  ungroup() %>%
  ggplot (aes(newx, cty, fill = class)) +
  geom_col(show.legend = FALSE) +
  labs (title = "boxplot") +
  theme_classic() +
  coord_flip()



qg <- function (data, x, y) {
  x <- enquo(x)
  y <- enquo(y)
  data %>%
    arrange (desc(!!y)) %>%
    mutate(newx = factor(!!x, levels = rev(unique(!!x)))) %>%
    group_by(newx) %>%
    top_n(3, cty) %>%
    ungroup() %>%
    ggplot(aes(newx, !!y)) +
    geom_col() +
    labs(title = "boxplot") +
    theme_classic()+
    coord_flip()

}

qg(mpg, class, cty)
