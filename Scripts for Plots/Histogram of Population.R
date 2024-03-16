hist.plt.pop <- function(x, main = NULL){ # Histogram Plot of Population
  
  x <- x[,5] / 10 ^ 6 # Divide by 1 million
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  p.seq <- seq(0, round(s.max, 0) + 1, by = 1) # values for x-axis
  
  # Plot
  hist(x, freq = T, xlab = "Population in millions", border = "white", las = 1,
       main = main, col = "steelblue", breaks = round(length(x), -1), 
       xlim = c(s.min, round(s.max, 0) + 1))
  
  for (n in p.seq){ abline(v = n, col = "grey", lty = 3) } # Vertical line
  
  abline(h = 0, col = "black") # Add vertical line at y = 0
  axis(side = 1, at = p.seq) # Set x-axis values
  axis(side = 2, at = seq(1, 100, 1), las = 2) # Set y-axis values
  axis(side = 4, at = seq(0, 100, 1), las = 2) # Set y-axis values
  
  for (n in seq(1, 100, 1)){ abline(h = n, col = "grey", lty = 3) } # y-axis
  
  # Add Normal Distribution
  lines(seq(round(s.min, -1), s.max, by = 0.01),
        dnorm(seq(round(s.min, -1), s.max, by = 0.01),
              mean = mean(x), sd = sd(x)) * s.max * 2, col = "red3", lwd = 2)
  
  box() # Define borders
}
hist.plt.pop(rus.bubble.df1, main = "Histogram of Population by Regions") 
