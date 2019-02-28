library (tidyverse)
library (tidytext)
library (textstem)


#' The lazyfreetext function
#'
#' This function tokenises and lemmatises the data in your tidy dataset
#' @param data name of your dataset (must be tidy)
#' @param freetext variable containing your freetext data
#' @examples no examples just yet - need to find some free text data in datasets!

lazyfreetext <- function (data, freetext){
  ft <- enquo(freetext)
  data %>%
    unnest_tokens(word, !!ft)  %>%
    mutate (lemma = (lemmatize_strings(word))) %>%
    anti_join(stop_words)
}


#' The lazytf function
#'
#' This function quickly provides a term frequency-inverse document frequency
#' by whatever grouping factors you have in your dataset
#' @param data name of your dataset (data must be tokenised, see lazyfreetext)
#' @param word name of your 'token' you are counting, defaults to 'lemma' from lazyfreetext
#' @param grouping_factor what group do you want your tf_idf to be created from
#' @examples no examples just yet!

lazytf <- function (data, word = "lemma", grouping_factor) {
  qgv <- enquo (grouping_factor)
  word <- enquo (word)
  data %>%
    group_by(!!qgv) %>%
    count (!!qgv, !!word, sort = TRUE) %>%
    ungroup() %>%
    mutate (total = sum(n)) %>%
    bind_tf_idf (., !!word, !!qgv, n)

}

