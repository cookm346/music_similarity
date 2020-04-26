artists <- readLines("../artists.txt")

# install.packages("spotifyr", dependencies = TRUE)
library(spotifyr)

Sys.setenv(SPOTIFY_CLIENT_ID = "")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "")

access_token <- get_spotify_access_token()

for(i in 1:400){
    data <- get_artist_audio_features(artists[i])
    data$album_images <- NULL
    data$artists <- NULL
    data$available_markets <- NULL
    artist_name <- gsub(" ", "_", artists[i]); artist_name <- gsub("/", "-", artists[i])
    write.csv(data, paste0("../data/", artist_name, ".csv"), row.names = FALSE)
    
    Sys.sleep(10)
    
    print(i)
}

