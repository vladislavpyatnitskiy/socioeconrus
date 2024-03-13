hist.plt.year <- function(x, main = NULL){ # Histogram Plot
  
  x <- as.numeric(x) # Numeric
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  p.seq <- seq(round(s.min, -1), s.max, by = 1) # values for x-axis
  
  # Plot
  hist(x, freq = T, xlab = "Years", border = "white", xlim = c(s.min, s.max),
       col = "steelblue", las = 1, breaks = round(length(x), -1), main = main)
  
  for (n in p.seq){ abline(v = n, col = "grey", lty = 3) } # Vertical line
  
  abline(h = 0, col = "black") # Add vertical line at y = 0
  axis(side = 1, at = p.seq) # Set x-axis values
  axis(side = 2, at = seq(1, 100, 1), las = 2) # Set y-axis values
  
  for (n in seq(1, 100, 1)){ abline(h = n, col = "grey", lty = 3) } # y-axis
  
  # Add Normal Distribution
  lines(seq(round(s.min, -1), s.max, by = 0.01),
        dnorm(seq(round(s.min, -1), s.max, by = 0.01),
              mean = mean(x), sd = sd(x)) * s.max / 4, col = "red3", lwd = 2)
  
  box() # Define borders
}
hist.plt.year(rus.bubble.df1[,4],
              main = "Histogram of Life Expectancies by Russian Regions") 
