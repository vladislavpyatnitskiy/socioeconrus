library("factoextra") # Library

post.soviet.clusterting <- function(x){ # Clusters of Post Soviet Countries
  
  df <- data.frame(x[,3], x[,4]) # Take columns
  
  rownames(df) <- x[,1] # Names of countries
  colnames(df) <- c("Income", "Life Expectancy") # Column names
  
  eclust(df, "kmeans", nstart = 25) # Cluster Plot
}
post.soviet.clusterting(su.df) # Test
