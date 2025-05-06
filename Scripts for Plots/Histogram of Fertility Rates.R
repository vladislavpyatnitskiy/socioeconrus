hist.plt.fert <- function(x){ # Histogram Plot of Fertility by Regions
  
  x <- x[,"Fertility Rate"]
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  hist(
    x,
    freq = T,
    xlab = "Fertility Per Woman",
    border = "white",
    main = "Histogram of Fertility Rate by Regions",
    xlim = c(s.min, s.max),
    col = "steelblue",
    breaks = round(length(x), -1),
    las = 1
    )
  
  grid(nx = NULL, ny = NULL, col = "grey", lty = 3, lwd = 1) # Grid
  
  abline(h = 0) # Add vertical line at y = 0
  
  axis(side = 4, las = 2) # Set right y-axis 
  
  R <- seq(round(s.min, -1), s.max, by = 0.01) # Range for Normal Distribution
  
  # Add Normal Distribution
  lines(
    R,
    dnorm(R, mean = mean(x), sd = sd(x)) * s.max,
    col = "red3",
    lwd = 3
    )
  
  par(mar = rep(4, 4)) # Define borders of the plot
  
  box() # Define borders
}
hist.plt.fert(rus.bubble.df.new) 
