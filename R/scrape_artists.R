# install.packages("rvest")
library(rvest)

links <- c("http://www.acclaimedmusic.net/061024/1948-09art.htm",
           "http://www.acclaimedmusic.net/061024/1948-09art2.htm",
           "http://www.acclaimedmusic.net/061024/1948-09art3.htm",
           "http://www.acclaimedmusic.net/061024/1948-09art4.htm",
           "http://www.acclaimedmusic.net/061024/1948-09art5.htm")

artists <- NULL

for(i in 1:length(links)){
    a <- read_html(links[i])
    a <- html_text(html_nodes(a, "a"))
    artists <- c(artists, a)
}

rm_text <- c("(1-200)", "(201-400)", "(401-600)", "(601-800)", 
             "(801-1000)", "Albums", "Songs", "1900-49", "50s", "60s", "70s",
             "80s", "90s", "00s")

artists <- artists[! artists %in% rm_text]

writeLines(artists, "../artists.txt")


