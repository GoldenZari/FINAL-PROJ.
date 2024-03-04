# libraries needed
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

spotify_songs_time_df <- read.csv("C:/Users/szyan/OneDrive/Desktop/INFO 201/Group Project Ver 2/spotify_songs_time_df.csv")

# server area
server <- function(input, output) {
  
  output$country_plot <- renderPlot({
    ggplot(spotify_songs_time_df %>%
             filter(Continent %in% input$viz1_option),  # Correct input ID here
           aes(x = Continent, y = Popularity, fill = Continent)) +
      geom_bar(stat = "identity") +
      labs(title = "Song Popularity Based on Country",
           x = "Continent",
           y = "Popularity")
  })
  
  output$time_plot <- renderPlot({
    ggplot(spotify_songs_time_df %>%
             filter(Continent %in% input$viz1_option),  # Correct input ID here
           aes(x = Album.Date, y = Popularity, color = Continent)) +
      geom_line() +
      labs(title = "Average Popularity by Continent Over Time",
           x = "Album Date",
           y = "Popularity",
           color = "Continent")
  })
  
  output$continent_plot <- renderPlot({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent %in% input$viz1_option)  # Correct input ID here
    
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
  })
}