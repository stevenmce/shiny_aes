# Analysis of AES2010 in R

# Read file
library(foreign)
aes2010 <- read.spss("/Users/stevenmceachern/Documents/Steve/ASSDA\ Data/AES/AES 2010/au.edu.anu.ada.ddi.01228_spss/aes2010_01228_F1.sav",
                     reencode = NA, use.value.labels=FALSE, to.data.frame=TRUE)

# Select file using dialogue box
library(foreign)
aes2010 <- read.spss(file.choose(),
                     reencode = NA, use.value.labels=FALSE, to.data.frame=TRUE)

# Convert a1 to a factor
aes2010$a1 <- ordered(aes2010$a1,
                     levels = c(1,2,3,4,-1),
                     labels = c("A good deal", "Some", "Not much", "None", "Missing"),
                     exclude=NA)
levels(aes2010$a1)
str(aes2010$a1)

# Plot a1
require(ggplot2)
plot(aes2010$a1)
qplot(aes2010$a1)
tabulate(aes2010$a1)
with(aes2010, table(a1))
