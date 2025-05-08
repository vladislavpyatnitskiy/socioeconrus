hist.plt.y.diff <- function(x){ # Histogram Plot of Life Expectancy Difference
  
  x <- as.numeric(x[,"Difference"])
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  hist(
    x,
    freq = T,
    xlab = "Years",
    border = "white",
    xlim = c(s.min, s.max),
    col = "steelblue",
    las = 1,
    breaks = round(length(x), -1),
    main = "Histogram of Difference in Life Expectancy between Male & Female"
    ) # Plot
  
  grid(nx = NULL, ny = NULL, col = "grey", lty = 3, lwd = 1) # Grid
  
  abline(h = 0) # Add vertical line at y = 0
  
  axis(side = 4, las = 2) # Right y-axis
  
  R <- seq(round(s.min, -1), s.max, by = 0.01)
  
  lines(
    R,
    dnorm(R, mean = mean(x), sd = sd(x)) * s.max,
    col = "red3",
    lwd = 3
    ) # Normal Distribution
  
  par(mar = c(3, 3, 3, 3)) # Define borders of the plot
  
  box() # Define borders
}
hist.plt.y.diff(dif.df) # Test
