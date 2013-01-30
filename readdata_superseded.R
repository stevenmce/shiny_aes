## OLD (pre 26/1/2013) file to read and prepare data file for use ##
## In the current version, labelling is handled by the Hmisc spss.get() package
## importing labels into 


# We tweak the "a1" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application

# Read AES2010 subset data from shiny aes_subset subdirectory
# Data source: Australian Election Study, 2010
# Data description: http://www.ada.edu.au/ada/01228
# AES website: http://aes.anu.edu.au

# This option uses Hmisc spss.get, which allows storage of variable labels
# Note: the "use.value.labels=TRUE" option uses the value labels
# to convert these variables to FACTORS in R
# For a brief descripton of factors, see:
#  - http://www.statmethods.net/input/datatypes.html 
#  - http://statistics.ats.ucla.edu/stat/r/modules/factor_variables.htm
mpgdata <- spss.get("./aes_subset/aes2010_subset.sav",
                    use.value.labels=TRUE, to.data.frame=TRUE)

# # Second option - read.spss() from foreign
# # Note: doesn't allow variable labels
# mpgdata <- read.spss("./aes_subset/aes2010_subset.sav",
#                     use.value.labels=TRUE, to.data.frame=TRUE)

############################################
############################################
# If setting use.value.labels=FALSE, need to create factors yourself
# Examples below

# Convert variables to factors

# Convert variables to ordered factors
# Want here to be able to read value labels and variable type from DDI
# Not required with read.spss/use.value.labels=TRUE
# mpgdata$a1 <- ordered(mpgdata$a1,
#                       levels = c(1,2,3,4,-1),
#                       labels = c("A good deal", "Some", "Not much", "None", "Missing"),
#                       exclude=NA)
# 
# mpgdata$statemap <- ordered(mpgdata$statemap,
#                       levels = c(1,2,3,4,5,6,7,8),
#                       labels = c("NSW", "VIC", "QLD", "SA", "WA", "TAS", "NT", "ACT"),
#                       exclude=NA)
############################################
############################################

############################################
############################################
# Add variable labels using Hmisc pacakge label() function
# Note: we eventually want here to be able to read variable labels from DDI
# http://www.ddialliance.org

# label(mpgdata$a1) <- "A1. Interest in politics" 
# label(mpgdata$a2) <- "A2. Followed election news in the newspapers" 
# label(mpgdata$a3p1) <- "A3. Followed election news on TV" 
# label(mpgdata$a3p2) <- "A3. Followed election news on the radio" 
# label(mpgdata$a2p3) <- "A3. Followed election news on the internet" 
# label(mpgdata$a4) <- "A4. Interest in election campaign" 
# label(mpgdata$a9) <- "A9. Should voting be compulsory" 
# label(mpgdata$b1) <- "B1. Party identification" 
# label(mpgdata$b8own) <- "B8. Own left-right position" 
# label(mpgdata$b9reps) <- "B9. Vote in House of Representatives" 
# label(mpgdata$b14) <- "B14. Vote in House of Representatives in 2007" 
# label(mpgdata$b19lib) <- "B19. Feelings about Liberal Party" 
# label(mpgdata$b19alp) <- "B19. Feelings about Labor Party" 
# label(mpgdata$b19nat) <- "B19. Feelings about National Party" 
# label(mpgdata$b19grn) <- "B19. Feelings about Greens" 
# label(mpgdata$c3julia) <- "C3. Feelings about Julia Gillard" 
# label(mpgdata$c3abbott) <- "C3. Feelings about Tony Abbott" 
# label(mpgdata$h1) <- "H1. Sex" 
# label(mpgdata$age) <- "Age (derived)" 
# label(mpgdata$h7) <- "H7. Marital status" 
# label(mpgdata$n14) <- "H14. Live rural or urban" 
# label(mpgdata$statemap) <- "State mapping variable" 
# label(mpgdata$) <- "AEC_2010 Commonwealth Electoral Division mapping variable" 
# label(mpgdata$alp_2pp) <- "ALP Two-Party Preferred Vote - 2 party preferred (vs LNP)" 
# label(mpgdata$lnp_2pp) <- "LNP Two-Party Preferred Vote - 2 party preferred (vs ALP)" 
# label(mpgdata$turnoutp) <- "Turnout percentage - turnout as a percentage of enrolled voters" 
############################################
############################################
