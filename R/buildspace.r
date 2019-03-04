# This is just a file for all my testing/building


# Free text with one group (ID)
ft1 <- readxl::read_excel("data/testdata.xlsx",
                  sheet = "ft1")

# Free text with one ID and one grouping factor
ft2<-readxl::read_excel("data/testdata.xlsx",
                        sheet = "ft2")

# Free text with one ID and two grouping factors
ft3 <- readxl::read_excel("data/testdata.xlsx",
                 sheet = "ft3")



t1 <- lazyfreetext(ft1, Text)


extrastops <- tibble(lexicon = c("mine", "mine"), word = c("chapter", "chief"))
extrastops <- rbind(stop_words, extrastops)

t2 <- lazyfreetext(ft1, Text, stops = extrastops)


t3 <- lazytf(t1, lemma, ID)


# Here is where we are currently at
t4 <- quicktfplot(t1, lemma, ID)




t1 %>%
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



quicktfplot <- function (data, token, grouping_factor) {
  qgv <- enquo(grouping_factor)
  t <- enquo(token)
  l <- data %>%
    group_by(!!qgv) %>%
    count (!!qgv, !!t, sort = TRUE) %>%
    ungroup() %>%
    mutate (total = sum(n)) %>%
    bind_tf_idf (., !!t, !!qgv, n) %>%
    arrange(desc (tf_idf)) %>%
    mutate (word = factor(!!t, levels = rev(unique(!!t)))) %>%
    group_by (!!qgv) %>%
    top_n(5, tf_idf) %>%
    ungroup()

  l %>%
    ggplot(aes(x = word, y = tf_idf)) +
    geom_col(show.legend = FALSE) +
    labs (x = NULL, y = "Term Frequency - Inverse Document Frequency") +
    facet_wrap(~!!qgv, scales = "free") +
    theme_classic() +
    coord_flip()
}


