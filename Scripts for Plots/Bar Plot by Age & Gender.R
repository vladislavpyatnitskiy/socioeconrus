bar.plt.soc.age.gender <- function(x){ # Bar plot of gender age groups
    
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
  
  names(df.bar) <- age.groups # Put names for age and gender groups
  
  df.bar <- sort(df.bar, decreasing = T) # Sort in a descending way
  
  m <- round(max(df.bar), 0) + 1 # Set Maximum value for y - axis
  
  df.bar <- df.bar / (10 ^ (nchar(m) - 1)) # Divide by million
  
  col.df <- NULL # Create set of colours for bar plot
  
  for (n in 1:length(df.bar)){ if (isTRUE(grepl("F", names(df.bar)[n]))){
      
      col.df <- c(col.df, "magenta") } else { col.df <- c(col.df, "blue") } }
  
  bar.plt.script <- barplot(df.bar,
                            names.arg = names(df.bar),
                            las = 2,
                            col = col.df,
                            main = "Population by Age & Gender Groups",
                            ylab = "Number of People in millions", 
                            ylim = c(0, m / (10 ^ (nchar(m) - 1)) + 1), 
                            xpd = T)
  
  abline(v = bar.plt.script, col = "grey", lty = 3) # Vertical lines
  abline(h = seq(0, m, .5), col = "grey", lty = 3) # Horizontal lines
  abline(h = mean(df.bar), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(df.bar), col = "green", lwd = 3) # Median percentage line
  
  axis(side=2, at = seq(0.5, m / (10^(nchar(m) - 1)) + 1, 1), las=1) # Set axes
  axis(side=4, at = seq(0, m / (10^(nchar(m) - 1)) + 1, 0.5), las=1)
  
  par(mar = c(10, 5, 3, 5)) # Define borders of the plot
  
  legend(x = "bottom", inset = c(0, -0.7), cex = .85, bty = "n", horiz = T,
         legend = c((sprintf("Mean: %s", round(mean(df.bar), 2))),
                    sprintf("Median: %s", round(median(df.bar), 2))),
         col = c("red", "green"), xpd = T, pch = 15)
  
  box() # Box
}
bar.plt.soc.age.gender("api/pp/643/2020/?csv=true") # Test
