hist.plt.year <- function(x){ # Histogram Plot of Regions by Life Expectancy
  
  x <- as.numeric(x) # Numeric
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  p.seq <- seq(round(s.min, -1), s.max, by = 1) # values for x-axis
  
  # Plot
  hist(x, freq = T, xlab = "Years", border = "white", xlim = c(s.min, s.max),
       col = "steelblue", las = 1, breaks = round(length(x), -1),
       main = "Histogram of Life Expectancies by Russian Regions")
  
  for (n in p.seq){ abline(v = n, col = "grey", lty = 3) } # Vertical line
  for (n in seq(1, 100, 1)){ abline(h = n, col = "grey", lty = 3) } # y-axis
  
  abline(h = 0) # Add vertical line at y = 0
  axis(side = 1, at = p.seq) # Set x-axis values
  for (n in 1:2){ axis(side = 2*n,at=seq(100,from=0,by=1),las=2) } # Set y-axes
  
  # Add Normal Distribution
  lines(seq(round(s.min, -1), s.max, by = 0.01),
        dnorm(seq(round(s.min, -1), s.max, by = 0.01),
              mean = mean(x), sd = sd(x)) * s.max / 4, col = "red3", lwd = 2)
  
  box() # Define borders
}
hist.plt.year(rus.bubble.df1[,4]) 
