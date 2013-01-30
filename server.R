# Set required pacakges - should be REQUIRE, not LIBRARY
require(shiny)
require(datasets)
require(foreign)
require(Hmisc)
require(memisc)
require(ggplot2)

# Set options for number of digits in numeric output
options(digits=3)

#############################################
## READ DATA - Australian Election Study 2010
#############################################

# This data import option uses Hmisc spss.get, which allows storage of variable labels
# Note: the "use.value.labels=TRUE" option uses the value labels
# to convert these variables to FACTORS in R
# For a brief descripton of factors, see:
#  - http://www.statmethods.net/input/datatypes.html 
#  - http://statistics.ats.ucla.edu/stat/r/modules/factor_variables.htm
mpgdata <- spss.get("./aes_subset/aes2010_subset.sav",
                    use.value.labels=TRUE, to.data.frame=TRUE)


############################################
############################################
# The remainder of this code is developed by extending on the Shiny tutorial example

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive function since it is 
  # shared by the output$caption and output$mpgPlot functions
  formulaText <- reactive(function() {
    paste(input$yvariable, " ~ ", input$xvariable)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- reactiveText(function() {
    formulaText()
  })
  
  # Generate a plot (based on "chart_type")
  # of the requested y variable against requested x variable and only 
  # include outliers if requested
  # Graph examples taken from Quick-R: http://www.statmethods.net/graphs/index.html
  output$chart_type <- reactivePlot(function() {
    # Boxplot
    if(input$chart_type == "boxplot") {
    boxplot(as.formula(formulaText()), 
            data = mpgdata,
            outline = input$outliers,
            xlab=label(mpgdata[input$xvariable]),
            ylab=label(mpgdata[input$yvariable]))
    }

    # Scatterplot
    # Need to figure out how to remove NAs introduced by coercion
    if(input$chart_type == "scatter") {
      xy <- cbind(mpgdata[input$xvariable],mpgdata[input$yvariable])
#       plot(as.numeric(input$xvariable), as.numeric(input$yvariable), main=output$caption, 
#            xlab=label(mpgdata[input$xvariable]),
#            ylab=label(mpgdata[input$yvariable]),
#            xlim=c(min(na.omit(mpgdata[input$xvariable])),
#                   max(na.omit(mpgdata[input$xvariable]))),
#            ylim=c(min(na.omit(mpgdata[input$yvariable])),
#                   max(na.omit(mpgdata[input$yvariable]))),
#            pch=19           
      plot(as.numeric(xy[,1]),as.numeric(xy[,2]), main=output$caption, 
           xlab=label(mpgdata[input$xvariable]),
           ylab=label(mpgdata[input$yvariable]),
           pch=19
      )
    }
    
    # Barplot - simple
    if(input$chart_type == "barplot-simple") {
#       counts <- table(input$xvariable)
#       barplot(counts, main=formulaText(), 
#               xlab=label(mpgdata[input$xvariable]))
      summary(mpgdata$a1)
      barplot(table(mpgdata[input$xvariable]),
                main=summary(mpgdata$a1),
                xlab=label(mpgdata[input$xvariable]),
                ylab="Count")
    }
    
    # Barplot - grouped
    # Currently producing a solid blue box??
    if(input$chart_type == "barplot-grouped") {
      xy <- cbind(mpgdata[input$xvariable],mpgdata[input$yvariable])
      counts <- table(xy[,1], xy[,2])
      barplot(counts, main=formulaText(),
              xlab=label(mpgdata[input$xvariable]), 
              col=c("darkblue","red"),
              legend = rownames(counts), beside=TRUE)
#      boxplot(as.formula(formulaText()), 
#              data = mpgdata,
#              outline = input$outliers,
#              xlab=label(mpgdata[input$xvariable]),
#              ylab=label(mpgdata[input$yvariable]))
    }
    
    # Line plot
    if(input$chart_type == "line") {
           xy <- cbind(mpgdata[input$xvariable],mpgdata[input$yvariable])
           par(pch=22, col="blue") # plotting symbol and color 
           opts = c("p","l","o","b","c","s","S","h") 
#           plot(range(input$xvariable), range(input$yvariable), main=output$caption) 
#           lines(input$xvariable, input$yvariable, type="l") 
           plot(range(as.numeric(xy[,1])), range(as.numeric(xy[,2])), main=output$caption, 
                xlab=label(mpgdata[input$xvariable]),
                ylab=label(mpgdata[input$yvariable])) 
           lines(as.numeric(xy[,1]), as.numeric(xy[,2]), type="l")
    }
      
    # Scatterplot - ggplot
    if(input$chart_type == "scatter-gg") {
      # Push selected variables to the xy dataframe
      # ggplot doesnt seem to want to use mpgdata directly
      xy <- cbind(mpgdata[input$xvariable],mpgdata[input$yvariable])
      p <- qplot(xy[,1], 
                 xy[,2], 
                 data=xy,
                 na.rm=TRUE
                )
      # Add labels
      p <- p + labs(title = paste(formulaText(),
                   "Spearman Correlation: ",
                    cor(as.numeric(xy[,1]), as.numeric(xy[,2]), 
                        method = "spearman", use="complete")))
      p <- p + labs(x = label(mpgdata[input$xvariable]))
      p <- p + labs(y = label(mpgdata[input$yvariable]))
      # Jitter points around origin
      p <- p + geom_point(position=position_jitter(width=.2,height=.2))
      print(p)
    }
  })
})