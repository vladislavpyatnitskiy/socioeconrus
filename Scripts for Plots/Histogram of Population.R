hist.plt.pop <- function(x){ # Histogram Plot of Population
  
  x <- x[,"Population"] / 10 ^ 6 # Divide by 1 million
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  hist(
    x,
    freq = T,
    xlab = "Population in millions",
    border = "white",
    las = 1,
    main = "Histogram of Population by Regions",
    col = "steelblue",
    breaks = round(length(x), -1), 
    xlim = c(s.min, round(s.max, 0) + 1)
    ) # Plot
  
  grid(nx = NULL, ny = NULL, col = "grey", lty = 3, lwd = 1) # Grid
  
  abline(h = 0) # Add vertical line at y = 0
  
  axis(side = 4, las = 2) # Set y-axis values
  
  R <- seq(round(s.min, -1), s.max, by = 0.01)
  
  lines(
    R,
    dnorm(R, mean = mean(x), sd = sd(x)) * s.max * 2,
    col = "red3",
    lwd = 2
    ) # Add Normal Distribution
  
  par(mar = rep(4, 4)) # Define borders of the plot
  
  box() # Define borders
}
hist.plt.pop(rus.bubble.df1) # Test
