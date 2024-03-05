library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

spotify_songs_time_df <- read.csv("C:/Users/szyan/OneDrive/Desktop/INFO 201/Group Project Ver 3/spotify_songs_time_df.csv")

server <- function(input, output) {
  
  ## Visualization 1
  output$viz1_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent %in% input$viz1_option)
    
    
    gg1 <- ggplot(filtered_df %>% na.omit()) +
      geom_bar(stat = "identity",
               aes(x = Continent,
                   y = Popularity,
                   color = Continent)) +
      labs(title = "Song Popularity Based on Country", 
           x = "Continent", 
           y = "Popularity") +
      scale_fill_manual(values = rainbow(length(unique(filtered_df$Continent))))
    print(gg1)
    return(ggplotly(gg1))
  })
  
  ## Visualization 2
  output$viz2_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent %in% input$viz2_option)
    
    gg2 <- ggplot(spotify_songs_time_df) +
        geom_line(na.rm = TRUE,
                  aes(x = Album.Date,
                      y = Popularity,
                      color = Continent)) +
        labs(title = "Average Popularity by Continent Over Time",
             x = "Album Date",
             y = "Popularity",
             color = "Continent")
    print(gg2)
    return(ggplotly(gg2))
  })
  
  ## Visualization 3
  output$viz3_output <- renderPlotly({
    filtered_df <- spotify_songs_time_df %>%
      filter(Continent %in% input$viz3_option)
    
    popularity_by_year <- filtered_df %>%
      group_by(Album.Date, Continent) %>%
      summarise(Avg_Popularity = round(mean(Popularity)), .groups = 'drop')
    
    
    gg3 <- ggplot(popularity_by_year) +
           geom_line(na.rm = TRUE,
                     aes(x = Album.Date,
                         y = Avg_Popularity,
                         color = Continent)) +
           labs(title = "Average Popularity of Artists from Asia vs. US Over the Years",
                x = "Year",
                y = "Average Popularity",
                color = "Continent") +
                theme(legend.position = "top")
    print(gg3)
    return(ggplotly(gg3))
  })
}