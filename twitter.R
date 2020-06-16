#install.packages("rtweet")
#install.packages("dplyr")
#install.packages("tidyr")

library("rtweet")
library("dplyr")
library("tidyr")

keyword <- "Pandemi OR Koronavirus OR di OR Indonesia"
jumlah_tweet <- 1000
type <- "recent"
language <- "id"

retweet <- FALSE

token <- create_token(
  app  = "xxxx",
  consumer_key = "xxxx",
  consumer_secret = "xxxx",
  access_token = "xxxx",
  access_secret = "xxxx"
)

scraping <- search_tweets(
  keyword, n = jumlah_tweet, include_rts = retweet, type = type, lang = language, retryonratelimit = FALSE
)

View(scraping)
write_as_csv(scraping, "data_mentah_(Pandemi OR Koronavirus OR di OR Indonesia).csv", prepend_ids = TRUE, na = "",fileEncoding = "UTF-8")

selected <- filter(scraping, followers_count > 100)

edge_list <- select(selected, screen_name, mentions_screen_name)

edge_list <- edge_list %>% unnest(mentions_screen_name)

edge_list <- na.exclude(edge_list)

write.table(
  edge_list, file = "data_edge_node_(Pandemi OR Koronavirus OR di OR Indonesia).csv", quote = FALSE, sep = ",", col.names = FALSE, row.names = FALSE
)


