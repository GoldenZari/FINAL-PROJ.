# Data Wrangling: Final Project
# By: Sofia Yano, Sofia Caledron, and Lydia Cha

# dplyr to help join tables

library(dplyr)

# dataframes

spotify2023_df <- read.csv("C:/Users/szyan/Downloads/spotify-2023.csv")
top_songs_df <- read.csv("C:/Users/szyan/Downloads/ATop 1990-2022.csv")

# joining the dataframe

songs_over_time_df <-
  inner_join(spotify2023_df, top_songs_df, by = c("track_name" = "Song", "Artist" = "Artist"), relationship = "many-to-many")

# thresholds

popular_song <- 1000000000
min_spotify_chart <- 60

# mutating the df
# ifelse use from: https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/ifelse 

# creating categorical popularity column

songs_over_time_df <- songs_over_time_df %>%
  mutate(popularity = ifelse(
    streams > popular_song & in_spotify_charts > min_spotify_chart, "High Popularity",
    ifelse(streams > popular_song, "Moderate Popularity",
           ifelse(in_spotify_charts > popular_song, "Charting but Moderate Streams", "Low Popularity")
    )
  ))

# creating continuous chart data average column

songs_over_time_df$average_charting <-
  round(rowMeans(songs_over_time_df[, c("in_spotify_charts", "in_apple_charts", "in_deezer_charts")], na.rm = TRUE))

# creating a summary table

song_popularity_summ <-
  songs_over_time_df %>%
  group_by(popularity) %>%
  summarise(
    avg_chart_rank = round(mean(in_spotify_charts, na.rm = TRUE)),
    max_stream_song = track_name[which.max(streams)],
  )

# writing as a new csv file

write.csv(songs_over_time_df, "C:/Users/szyan/OneDrive/Desktop/INFO 201/Group Project/songs_over_time_df.csv", row.names = FALSE)
