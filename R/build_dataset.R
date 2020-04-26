datasets <- list.files(path = "../data")

all_data <- NULL

for(i in 1:length(datasets)){
    data <- read.csv(paste0("../data/", datasets[i]))
    data <- data[ , c("artist_name", "danceability", "energy", 
                      "loudness", "speechiness", "acousticness", 
                      "instrumentalness", "liveness", "valence", 
                      "tempo", "time_signature", "duration_ms", "key_mode")]
    
    all_data <- rbind(all_data, data)
}

dummy <- model.matrix(~all_data$key_mode-1)
dummy <- dummy[ , -25]
all_data$key_mode <- NULL
all_data <- data.frame(all_data, dummy)

all_data <- all_data[complete.cases(all_data), ]


pca <- prcomp(all_data[ , -1], center = TRUE, scale. = TRUE)
pca <- pca$x[ , 1:3]

s <- split(as.data.frame(pca), all_data$artist_name)
avg_data <- t(sapply(s, function(x){
                colMeans(x)
            }))

plot(avg_data)
text(avg_data, labels = unique(all_data$artist_name))

avg_data <- data.frame(artist = unique(all_data$artist_name),
                       avg_data)

write.csv(avg_data, "../data/pca3_data.csv", row.names = FALSE)
