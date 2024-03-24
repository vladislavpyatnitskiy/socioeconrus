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
  
  df.plt <- as.numeric(df.plt[,2]) # Make numeric format
  
  names(df.plt) <- age.groups # Put names for age and gender groups
  
  df.plt <- sort(df.plt, decreasing = T) # Sort in a descending way
  
  # Colours
  colors37 = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d",
               "#5a51dc","#d49f36","#552095","#507f2d","#db37aa","#84b67c",
               "#a06fda","#df462a","#5b83db","#c76c2d","#4f49a3","#82702d",
               "#dd6bbb","#334c22","#d83979","#55baad","#dc4555","#62aad3",
               "#8c3025","#417d61","#862977","#bba672","#403367","#da8a6d",
               "#a79cd4","#71482c","#c689d0","#6b2940","#d593a7","#895c8b",
               "#bd5975")
  
  df.plt <- df.plt / (10 ^ (nchar(m) - 1)) # Divide by million
  
  m <- round(max(df.plt), 0) + 1 # Set Maximum value for y - axis
  
  bar.plt.script <- barplot(df.plt,
                            names.arg = names(df.plt),
                            las = 2,
                            col = colors37,
                            main = "Distribution of Population by Age & Gender",
                            ylab = "Number of People in millions", 
                            ylim = c(0, m), 
                            xpd = T)
  
  abline(v = bar.plt.script, col = "grey", lty = 3) # Vertical lines
  abline(h = seq(0, m, .5), col = "grey", lty = 3) # Horizontal lines
  abline(h = mean(df.plt), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(df.plt), col = "green", lwd = 3) # Median percentage line
  
  axis(side = 2, at = seq(0.5, m, 1), las = 1) # Set axes
  axis(side = 4, at = seq(0, m, 0.5), las = 1)
  
  par(mar = c(8, 5, 3, 5)) # Define borders of the plot
  
  legend(x = "bottom", inset = c(0, -1.12), cex = .85, bty = "n", horiz = T,
         legend = c((sprintf("Mean: %s", round(mean(df.plt), 2))),
                    sprintf("Median: %s", round(median(df.plt), 2))),
         col = c("red", "green"), xpd = T, pch = 15)
  
  box() # Box
}
bar.plt.soc.age.gender("api/pp/643/2020/?csv=true") # Test
