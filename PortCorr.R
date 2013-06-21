# Thanks to: R-Guide: Covariance and Correlation and Economist at Large Blog for 
# original code and color scheme
# June 9, 2013 Risk Assets


library(reshape2)
library(ggplot2)
library(stockPortfolio) #Install the package and dependencies first (one-time only)
library(corrplot)

# Color Scheme
ealred <- "#7D110C"
ealtan <- "#CDC4B6"
eallighttan <- "#F7F6F0"
ealdark <- "#423C30"

# goes to desktop and grabs ticker list from XL file named tickerList.csv
symbols <- read.csv("/myDesktop/tickerList.csv", sep = " ", stringsAsFactors=FALSE)
tickers <- as.matrix(symbols)
startDate <- readline("Starting from what date (YYYY/MM/DD)?")
returns <- getReturns(tickers, freq="daily", start = startDate)

# Print summary of the returns
summary(returns)

# Create simple covariance table
cov(returns$R)
# Create new symbol and assign the Kendall cov table to it
cov.matrix <- cov(returns$R, method="kendall")
# Convert the Kendall cov table into a correlation table
cor.matrix <- cov2cor(cov.matrix)

# Create color palette
col1 <- colorRampPalette(c(ealtan, ealred))

# plots correlation matrix on the screen
corrplot(cor.matrix, method="color", title="Daily Return Correlation Matrix (Percent)", bg=eallighttan, addCoef.col="white", addCoefasPercent=TRUE, tl.col=ealdark, tl.srt=45, col=col1(4), mar = c(0,0,5,0), tl.offset=.3, tl.cex=.75, type="full", order="alphabet")

# Create the correlation table and a summary tabel and writes the Files to excel and places it on Desktop
setwd("/myDesktop")
write.csv(cor.matrix, file="corrFile.csv")
write.csv(summary(cor.matrix), file="summaryCorr.csv")
setwd("/Ruby-R")

