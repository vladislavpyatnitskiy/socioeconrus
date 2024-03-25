hist.plt.soc.age.gender <- function(x){ # Histogram by Age and Gender
  
  # Download CSV file from website
  f <- read.csv2(file = url(sprintf("https://www.populationpyramid.net/%s",x))) 
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  ages <- as.factor(df[,1]) # Change data type of first column to factor
  
  for (n in 2:3){ df[,n] <- as.numeric(df[,n]) } # make columns numeric
  
  df.plt <- NULL  
  
  for (n in 1:nrow(df)){ # Optimise for ggplot2 format
    
    df.plt <- rbind.data.frame(df.plt, rbind(c(sprintf("%s %s", df[n,1],
                                                       colnames(df)[2]),
                                               as.numeric(df[n,2])),
                                             c(sprintf("%s %s", df[n,1],
                                                       colnames(df)[3]),
                                               as.numeric(df[n,3])))) }
  age.groups <- df.plt[,1] # names for groups
  
  df.bar <- as.numeric(df.plt[,2]) # Make numeric format
  
  m <- round(max(df.bar), 0) + 1 # Set Maximum value for y - axis
  
  df.bar <- df.bar / (10 ^ (nchar(m) - 1)) # Divide by million
  
  s.min <- min(df.bar) # Minimum value
  s.max <- max(df.bar) # Maximum value
  
  hist(df.bar, freq=T, xlab="Population in millions", border="white", las = 1, 
       col = "steelblue", main = "Population's Distribution by Age & Gender",
       breaks = round(length(df.bar), -1), xlim = c(s.min,round(s.max, 0) + 1))
  
  abline(h = 0, col = "black") # Add vertical line at y = 0
  axis(side = 2, at = seq(1, 100, 1), las = 2) # Set y-axis values
  axis(side = 4, at = seq(0, 100, 1), las = 2) # Set y-axis values
  
  par(mar = c(4, 4, 4, 4)) # Define borders of the plot
  
  for (n in seq(1, 100, 1)){ abline(v = n, col = "grey", lty = 3)  # y-axis
   abline(h = n, col = "grey", lty = 3) } 
  
  # Add Normal Distribution
  lines(seq(round(s.min, -1), s.max, by = 0.01),
        dnorm(seq(round(s.min, -1), s.max, by = 0.01),
              mean = mean(df.bar), sd = sd(df.bar)) * s.max * 2,
        col = "red3", lwd = 2)
  
  box()
}
hist.plt.soc.age.gender("api/pp/643/2020/?csv=true") # Test
