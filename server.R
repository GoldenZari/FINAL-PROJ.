# libraries needed
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

spotify_songs_time_df <- read.csv("C:/Users/szyan/OneDrive/Desktop/INFO 201/Group Project Ver 2/spotify_songs_time_df.csv")

# server area
server <- function(input, output, session) {
  
  ## VIZ 1
  output$viz1_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent == input$viz1_option)
    
    plot_ly(data = filtered_df, x = ~Continent, y = ~Popularity, type = "bar", color = ~Continent) %>%
      layout(barmode = "group")
  })
  
  ## VIZ 2
  output$viz2_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      group_by(Album.Date, Continent) %>%
      summarise(Avg_Popularity = round(mean(Popularity)))
    
    plot_ly(data = filtered_df, x = ~Album.Date, y = ~Avg_Popularity, type = "scatter", mode = "lines", color = ~Continent)
    })
  }
  
  ## VIZ 3
  output$viz3_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent %in% c("Asia", "North America"))
    
    popularity_by_year <- filtered_df %>%
      group_by(Album.Date, Continent) %>%
      summarise(Avg_Popularity = round(mean(Popularity)))
    
    plot_ly(popularity_by_year, aes(x = ~Album.Date, y = ~Avg_Popularity, color = ~Continent)) +
      geom_line() +
      labs(title = "Average Popularity of Artists from Asia and US Over the Years",
           x = "Year",
           y = "Average Popularity",
           color = "Continent") +
      theme(legend.position = "top")
  })
