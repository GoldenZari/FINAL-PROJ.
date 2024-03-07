library(shiny)
library(plotly)
library(ggplot2)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Spotify Music Analysis Charting Analysis",
                         h1("By Group BF1"),
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
  selectInput("viz1_option", "Select Option",
              choices = unique(spotify_songs_time_df$Continent),
              multiple = TRUE)
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
  selectInput("viz2_option", "Select Genres",
              choices = unique(spotify_songs_time_df$Parent.Genres),
              multiple = TRUE)
)

viz_2_main_panel <- mainPanel(
  h2("Popularity Distribution by Genres"),
  plotlyOutput(outputId = "viz2_output")
)

viz_2_tab <- tabPanel("Distribution by Genres",
                      sidebarLayout(
                        viz_2_sidebar,
                        viz_2_main_panel
                      )
)

## VIZ 3 TAB INFO
viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  selectInput("viz3_option", "Select Region(s)",
              choices = unique(spotify_songs_time_df$Continent),
              multiple = TRUE)
)

viz_3_main_panel <- mainPanel(
  h2("Average Popularity of Artists from Various Regions Over the Years"),
  plotlyOutput(outputId = "viz3_output")
)

viz_3_tab <- tabPanel("Average Popularity of Artists",
                      sidebarLayout(
                        viz_3_sidebar,
                        viz_3_main_panel
                      )
)
                      

## CONCLUSIONS TAB INFO
conclusion_tab <- tabPanel(
  ("Charting Analysis Conclusions"),
  h1("Have Tastes Changed Over Time?"),
  p("As we stated in the first page, we wanted to analyze how trends change over 
    time in such way that groups that were not represented prior in such a Western
    dominated industry."),
  p("1) In the first graph, we've seen that Europe dominates in terms of popular songs.
    This may be due to how their industry is advertised, and in recent years,
    Eurovision (their most popular song contest across Europe and other participating countries)
    has risen in popularity. However, we must also look at how colonialism and globalization
    has affected the world. Despite Asia and Africa making up most of the population on Earth,
    it seems that the level of popularity of songs overall only reach so high compared to Europe."),
  p("2) If we also look at the genres, of course popular music will always dominate the charts.
    But what truly defines a genre as popular? Genres that were popular a decade ago aren't
    as popular among Spotify listeners these days. We also need to consider the mix of genres
    for songs since many songs will be inspired by multiple elements and not just one particular genre."),
  p("3) What causes the rise of certain music genres? Perhaps we can look to the events that surround
    them over a timeline. In the first half of the line graph looking at artists, there's a steady
    decline in most regions with the exception of Europe and Australia. But if we take a look at
    the year of 2016, there's a sudden spike in the trend, especially for Asia. One point that I would
    have to make about this is the introduction of KPop to the West. Back in 2012, Gangnam Style
    was released by Korean Artist PSY, which had become the most viewed video at the time
    and shattered world records. However, another group by the name of BTS in 2016 had also recently won
    the top social artist at the BBMA's that year, causing a surge of popularity for the Asian music
    industry overall. How have trends changed since then? We've seen rise in Asian cultures being
    spotlighted more in media, pushing not only music, but food, culture and more."),
  p("Over time, we have seen that what really determines the 
    popularity of music (the trend setter if you will) is determined mostly by Europe, 
    followed by Asia. In the next page, we can see that ....Moving on to the third chart,
    we can see that Australia, Africa, and Asia are the 
    top continents play a huge role in the popularity worldwide!")
)

## Shiny App UI
ui <- navbarPage("Music Analysis Over Time",
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)
