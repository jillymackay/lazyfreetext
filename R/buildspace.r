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






