pie.plt.gender <- function(x){ # Pie Plot showing gender portions
  
  f <- read.csv2(file = url(x)) # Download CSV file from website
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  df <- df[,-1] # Reduce excessive column
  
  for (n in 1:2){ df[,n] <- as.numeric(df[,n]) } # make columns numeric
  
  df <- round(colSums(df, na.rm = T) / sum(df), 4) * 100 # sum for each gender
  
  pie(df, labels = c(sprintf("%s %s%%", names(df), df)), radius = 1.7,
      col = c("navy", "darkred"), main = "Russia's Gender Portion")
}
pie.plt.gender("https://www.populationpyramid.net/api/pp/643/2020/?csv=true")
