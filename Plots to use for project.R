library(dplyr)
library(ggplot2)
library(plotly)

spotify_songs_time_df <- read.csv("spotify_songs_time_df.csv")

ggplot(spotify_songs_time_df, aes(x = Continent, y = Popularity, color = Continent)) +
  geom_bar(stat = "identity") +
  labs(title = "Song Popularity Based on Country", 
       x = "Continent", 
       y = "Popularity") +
  scale_fill_manual(values = rainbow(length(unique(spotify_songs_time_df$Continent))))

filtered_df <- spotify_songs_time_df %>%
  filter(Continent %in% c("Asia", "North America"))

popularity_by_year <- filtered_df %>%
  group_by(Album.Date, Continent) %>%
  summarise(Avg_Popularity = round(mean(Popularity)), .groups = 'drop')

ggplot(popularity_by_year, aes(x = Album.Date, y = Avg_Popularity, color = Continent)) +
  geom_line() +
  labs(title = "Average Popularity of Artists from Asia and US Over the Years",
       x = "Year",
       y = "Average Popularity",
       color = "Continent") +
  theme(legend.position = "top")

ggplot(filtered_df, aes(x = Continent, y = Popularity, fill = Continent)) +
  geom_boxplot() +
  labs(title = "Popularity Distribution by Continent", x = "Continent", y = "Popularity") +
  theme(legend.position = "none")

popularity_by_genre_year <- spotify_songs_time_df %>%
  group_by(Album.Date, Parent.Genres) %>%
  summarise(Avg_Popularity = mean(Popularity))

ggplot(popularity_by_genre_year) +
  geom_line(aes(x = Album.Date, 
                y = Avg_Popularity, 
                color = Parent.Genres), 
            size = 1.2) +
  labs(title = "Average Popularity of Selected Genres Over the Years",
       x = "Year",
       y = "Average Popularity",
       color = "Parent.Genres") +
  theme_minimal() +
  theme(legend.position = "top")
