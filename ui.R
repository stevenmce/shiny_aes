# R-Shiny plotting test script
# Based on Shiny tutorial - http://rstudio.github.com/shiny/tutorial
# Author: Steve McEachern, Australian Data Archive

library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("AES2010 - ADA Study 01228"),
  
  # Sidebar - select relevant variables
  # Want here to be able to read variable labels from DDI
  sidebarPanel(
    selectInput("xvariable", "X Variable:",
                list("A1. Interest in politics" = "a1",
                     "A2. Followed election news in the newspapers" = "a2",
                     "A3. Followed election news on TV" = "a3p1",
                     "A3. Followed election news on the radio" = "a3p2",
                     "A3. Followed election news on the internet" = "a3p3",
                     "A4. Interest in election campaign" = "a4",
                     "A9. Should voting be compulsory" = "a9",
                     "B1. Party identification" = "b1", 
                     "B8. Own left-right position" = "b8own",
                     "B9. Vote in House of Representatives" = "b9reps",
                     "B14. Vote in House of Representatives in 2007" = "b14",
                     "B19. Feelings about Liberal Party" = "b19lib",
                     "B19. Feelings about Labor Party" = "b19alp",
                     "B19. Feelings about National Party" = "b19nat", 
                     "B19. Feelings about Greens" = "b19grn",
                     "C3. Feelings about Julia Gillard" = "c3julia",
                     "C3. Feelings about Tony Abbott" = "c3abbott",
                     "H1. Sex" = "h1",
                     "Age (derived)" = "age",
                     "H7. Marital status" = "h7",
                     "H14. Live rural or urban" = "h14",
                     "State mapping variable" = "statemap",
                     "AEC_2010 Commonwealth Electoral Division mapping variable" = "elecdiv",
                     "ALP Two-Party Preferred Vote - 2 party preferred (vs LNP)" = "alp.2pp",
                     "LNP Two-Party Preferred Vote - 2 party preferred (vs ALP)" = "lnp.2pp",
                     "Turnout percentage - turnout as a percentage of enrolled voters" = "turnoutp"
                     )),
    
    selectInput("yvariable", "Y Variable:",
                list("A1. Interest in politics" = "a1",
                     "A2. Followed election news in the newspapers" = "a2",
                     "A3. Followed election news on TV" = "a3p1",
                     "A3. Followed election news on the radio" = "a3p2",
                     "A3. Followed election news on the internet" = "a3p3",
                     "A4. Interest in election campaign" = "a4",
                     "A9. Should voting be compulsory" = "a9",
                     "B1. Party identification" = "b1", 
                     "B8. Own left-right position" = "b8own",
                     "B9. Vote in House of Representatives" = "b9reps",
                     "B14. Vote in House of Representatives in 2007" = "b14",
                     "B19. Feelings about Liberal Party" = "b19lib",
                     "B19. Feelings about Labor Party" = "b19alp",
                     "B19. Feelings about National Party" = "b19nat", 
                     "B19. Feelings about Greens" = "b19grn",
                     "C3. Feelings about Julia Gillard" = "c3julia",
                     "C3. Feelings about Tony Abbott" = "c3abbott",
                     "H1. Sex" = "h1",
                     "Age (derived)" = "age",
                     "H7. Marital status" = "h7",
                     "H14. Live rural or urban" = "h14",
                     "State mapping variable" = "statemap",
                     "AEC_2010 Commonwealth Electoral Division mapping variable" = "elecdiv",
                     "ALP Two-Party Preferred Vote - 2 party preferred (vs LNP)" = "alp.2pp",
                     "LNP Two-Party Preferred Vote - 2 party preferred (vs ALP)" = "lnp.2pp",
                     "Turnout percentage - turnout as a percentage of enrolled voters" = "turnoutp"
                     )),
    
    selectInput(inputId = "chart_type",
                label = "Chart type",
                choices = c("Boxplot" = "boxplot",
                            "Scatterplot" = "scatter",
                            "Bar plot - Simple" = "barplot-simple",
                            "Bar plot - Grouped" = "barplot-grouped",
                            "Line" = "line",
                            "Scatterplot - ggplot" = "scatter-gg")
    ),
    
    checkboxInput("outliers", "Show outliers", FALSE)
  ),
  
  mainPanel(
    # Show the caption and plot of the requested x and y variables
    mainPanel(
      h3(textOutput("caption")),
      
      # plotOutput("boxPlot")
      plotOutput("chart_type")
      )
)))