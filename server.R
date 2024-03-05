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
      filter(Genres %in% input$viz2_option)
    
    gg2 <- ggplot(filtered_df, aes(x = Genres, y = Popularity, fill = Genres)) +
      geom_boxplot() +
      labs(title = "Popularity Distribution by Genre",
           x = "Genre",
           y = "Popularity") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
            axis.text.y = element_text(size = 8),
            legend.text = element_text(size = 8))
    
    ggsave("boxplot.png", height = 5, width = 8, dpi = 300)
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
      geom_line(aes(x = Album.Date,
                    y = Avg_Popularity,
                    color = Continent),
                size = 1.2) +
      labs(title = "Average Popularity of Artists from Selected Region(s) Over the Years",
           x = "Year",
           y = "Average Popularity",
           color = "Continent") +
      theme_minimal() +
      theme(legend.position = "top")
    print(gg3)
    return(ggplotly(gg3))
  })
}
