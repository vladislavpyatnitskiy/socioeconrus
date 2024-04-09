library("plotly")

bubble.plt.soc.3d <- function(x){ # Bubble Plot

  fig <- plot_ly(x, x = ~x[,4], y = ~x[,5], z = ~x[,3], size=~x[,7], 
                 color=~x[,2],marker=list(symbol='circle',sizemode='diameter'),
                 sizes = c(5, 150), text=~paste(x[,1]))
  # Rename axes
  fig %>% layout(title="Impact of Income and Life Exp Difference on Fertility",
                 scene=list(xaxis=list(title='Life Expectancy Difference'),
                            yaxis=list(title='Monthly GDP per Capital'),
                            zaxis=list(title = 'Fertility Rate per Woman')))
}
bubble.plt.soc.3d(df.new.rus) # Test
