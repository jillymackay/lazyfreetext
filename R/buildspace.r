# # This is just a file for all my testing/building
# library(tidytext)
#
# # Free text with one group (ID)
# ft1 <- readxl::read_excel("data/testdata.xlsx",
#                   sheet = "ft1")
#
# # Free text with one ID and one grouping factor
# ft2<-readxl::read_excel("data/testdata.xlsx",
#                         sheet = "ft2")
#
# # Free text with one ID and two grouping factors
# ft3 <- readxl::read_excel("data/testdata.xlsx",
#                  sheet = "ft3")
#
#
# extrastops <- dplyr::tibble(lexicon = c("mine", "mine"), word = c("chapter", "chief"))
# extrastops <- rbind(stop_words, extrastops)
#
#
# t1 <- lazyfreetext(ft1, Text)
#
# quicktfplot(t1, lemma, ID, 3)
#
#
#
# t2 <- lazyfreetext(ft2, Text, stops = extrastops)
#
# quicktfplot(t2, lemma, Grp1, 5)
#
#
#
# t3 <- lazyfreetext(ft3, Text, stops = extrastops)
#
# quicktfplot(t3, lemma, Grp2, 5)
