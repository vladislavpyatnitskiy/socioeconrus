hist.plt.soc <- function(x, main = NULL){ # Histogram Plot
  
  x <- as.numeric(x) # make values numeric
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  # Round maximum values
  s.max <- ceiling(round(s.max) / 10 ^ (nchar(round(s.max)) - 1)) *
    10 ^ (nchar(round(s.max)) - 1)
  
  p.seq <- seq(s.max / 20, s.max, s.max / 20) # values for x-axis
  
  # Plot
  hist(x, freq = T, xlab = "Histogram & Normal Distribution", border = "white",
       xlim = c(s.min, s.max), col = "steelblue", las = 1,
       breaks = round(length(x), -1), main = main)
  
  for (n in p.seq){ abline(v = n, col = "grey", lty = 3) } #
    
  abline(h = 0, col = "black") # Add vertical line at y = 0
  axis(side = 1, at = p.seq) # Set x-axis values
  
  for (n in seq(1, 100, 1)){ abline(h = n, col = "grey", lty = 3) } # y-axis
  
  # Add Normal Distribution
  lines(seq(s.min, s.max, by = 1),
        dnorm(seq(s.min, s.max, by = 1), mean = mean(x),
              sd = sd(x)) * max(x) * 2, col = "red3", lwd = 2)
  
  box() # Define borders
}
hist.plt.soc(as.numeric(rus.bubble.df1[,3]),
             main = "Histogram of Russian Regions") # Test
