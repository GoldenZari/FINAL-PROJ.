library(shiny)
library(plotly)

## OVERVIEW TAB INFO
overview_tab <- tabPanel("Spotify Music Analysis Charting Analysis",
                         h1("by. Group "),
                         p("Music is a common interest for everyone, and often
                           the tastes for everyone changes as time progresses.
                           Certain genres obtain popularity with certain
                           generations. For example, glam metal, eurobeats, rock,
                           and much more electronic sounding music started to be
                           more prevalent as the 80's and 90's passed."),
                           
                          p("Today, the music scene looks entirely different, where you
                           have new genres like dubstep in the 2010's era. Others are
                           a fusion of genres or inspired by other music."),
                           
                          p("The Western music industry has always dominated globally
                           whether they be from Europe or the Americas. However, post
                           2015, a new wave of artist based in Asia would blow up in
                           popularity. This is evident by the rise of Asian culture being
                           more prevalent in media. Things like KPop, anime, games, culture
                           and more are being rapidly introduced to the Western world."),
                           
                          p("We wanted to analyze the trends of things such as the popularity
                           in the music industry, and how trends change over time in such a
                           way that groups that weren't represented prior in such a Western
                           dominated industry.")
)

## VIZ 1 TAB INFO
viz_1_sidebar <- sidebarPanel(
  h2("Options for graph"),
  selectizeInput("viz1_option", "Select Option", choices = unique(spotify_songs_time_df$Continent),
                 multiple = TRUE
  )
)

viz_1_main_panel <- mainPanel(
  h2("Song Popularity Based on Country"),
  plotlyOutput(outputId = "viz1_output")
)

viz_1_tab <- tabPanel("Song Popularity Tab",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)

## VIZ 2 TAB INFO
viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  sliderInput("viz2_slider", "Select Value", min = 1, max = 10, value = 5)
)

viz_2_main_panel <- mainPanel(
  h2("Average Popularity by Continent Over Time"),
  plotlyOutput(outputId = "viz2_output")
)

viz_2_tab <- tabPanel("Average Popularity Over Time",
                      sidebarLayout(
                        viz_2_sidebar,
                        viz_2_main_panel
                      )
)

## VIZ 3 TAB INFO
viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  # TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Average Popularity of Artists from Asia and US Over the Years"),
  plotlyOutput(outputId = "viz3_output")
)

viz_3_tab <- tabPanel("Average Popularity of Artists Tab",
                      sidebarLayout(
                        viz_3_sidebar,
                        viz_3_main_panel
                      )
)

## CONCLUSIONS TAB INFO
conclusion_tab <- tabPanel("Spotify Music Charting Analysis Conclusion",
                           h1("Conclusions and Thoughts"),
                           p("some conclusions")
)

## Shiny App UI
ui <- navbarPage("Music Analysis App",
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)