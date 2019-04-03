# Function problem


library (tidyverse)


ft1 <- readxl::read_excel("data/testdata.xlsx",
                          sheet = "ft1")

t1 <- lazyfreetext(ft1, Text)


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

