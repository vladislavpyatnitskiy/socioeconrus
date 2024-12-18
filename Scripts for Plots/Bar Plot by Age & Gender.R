bar.plt.soc.age.gender <- function(C, Y){ # Bar plot of gender age groups
  
  f <- sprintf("https://www.populationpyramid.net/api/pp/%s/%s/?csv=true", C, Y)
  
  f <- read.csv2(file = url(f)) # Download CSV file to get data
  
  d <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    d <- rbind.data.frame(d, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(d) <- c("Age", "Male", "Female") # Column names
  
  ages <- as.factor(d[,1]) # Change data type of first column to factor
  
  for (n in 2:3){ d[,n] <- as.numeric(d[,n]) } # make columns numeric
  
  D <- NULL  
  
  for (n in 1:nrow(d)){ # Optimise for ggplot2 format
    
    D <- rbind.data.frame(D, rbind(c(sprintf("%s %s",d[n,1],colnames(d)[2]),
                                     as.numeric(d[n,2])),
                                   c(sprintf("%s %s",d[n,1],colnames(d)[3]),
                                     as.numeric(d[n,3])))) }
  A <- D[,1] # Age & Gender groups
  
  N <- as.numeric(D[,2]) # Make numeric format
  
  names(N) <- A # Put names for age and gender groups
  
  N <- sort(N, decreasing = T) # Sort in a descending way
  
  m <- round(max(N), 0) + 1 # Set Maximum value for y - axis
  
  N <- N / (10 ^ (nchar(m) - 1)) # Divide by million
  
  J <- NULL # Create set of colours for bar plot
  
  for (n in 1:length(N)){ J <- c(J, ifelse(grepl("F", names(N)[n]) == T,
                                           "magenta", "blue")) }
    
  B <- barplot(N, names.arg = names(N), las = 2, col = J, xpd = T, 
               main = "Population by Age & Gender Groups in millions",
               ylim = c(0, m / (10 ^ (nchar(m) - 1)) + 1))
  
  abline(v = B, col = "grey", lty = 3) # Vertical lines
  
  vals = list(list(mean(N), median(N), seq(0, m, .5)), c("red","green","grey"),
              c(1, 1, 3), c(3, 3, 1))

  axis(side=2, at = seq(0.5, m / (10^(nchar(m) - 1)) + 1, 1), las=1) # Set axes
  axis(side=4, at = seq(0, m / (10^(nchar(m) - 1)) + 1, 0.5), las=1)
  
  par(mar = c(10, 5, 3, 5)) # Define borders of the plot
  
  for (n in 1:3){ abline(h = vals[[1]][[n]], col = vals[[2]][n],
                         lty = vals[[3]][n], lwd = vals[[4]][n]) }
  
  legend(x = "bottom", inset = c(0, -0.6), cex = .85, bty = "n", horiz = T, 
         legend = c((sprintf("Mean: %s", round(vals[[1]][[1]], 2))),
                    sprintf("Median: %s", round(vals[[1]][[2]], 2))),
         col = vals[[2]][c(1,2)], xpd = T, pch = 15)
  
  box() # Box
}
bar.plt.soc.age.gender(C = "643", Y = "2024") # Test
