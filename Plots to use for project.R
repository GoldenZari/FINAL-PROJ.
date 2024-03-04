library(dplyr)
library(ggplot2)
library(plotly)

update.packages(ask = FALSE, checkBuilt = TRUE)

spotify_songs_time_df <- read.csv("C:/Users/szyan/OneDrive/Desktop/INFO 201/Group Project Ver 2/spotify_songs_time_df.csv")

ggplot(spotify_songs_time_df, aes(x = Continent, y = Popularity, color = Continent)) +
  geom_bar(stat = "identity") +
  labs(title = "Song Popularity Based on Country", 
       x = "Continent", 
       y = "Popularity") +
  scale_fill_manual(values = rainbow(length(unique(spotify_songs_time_df$Continent))))

ggplot(spotify_songs_time_df, aes(x = Album.Date, y = Popularity, color = Continent)) +
  geom_line() +
  labs(title = "Average Popularity by Continent Over Time", x = "Album Date", y = "Popularity", color = "Continent")

filtered_df <- spotify_songs_time_df %>%
  filter(Continent %in% c("Asia", "North America"))

popularity_by_year <- filtered_df %>%
  group_by(Album.Date, Continent) %>%
  summarise(Avg_Popularity = round(mean(Popularity)))

ggplot(popularity_by_year, aes(x = Album.Date, y = Avg_Popularity, color = Continent)) +
  geom_line() +
  labs(title = "Average Popularity of Artists from Asia and US Over the Years",
       x = "Year",
       y = "Average Popularity",
       color = "Continent") +
  theme(legend.position = "top")
