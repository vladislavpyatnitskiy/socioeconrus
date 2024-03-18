pie.plt.age <- function(x){ # Pie Plot of Russia's Population by Age
  
  f <- read.csv2(file = url(x)) # Download CSV file from website
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  ages <- as.factor(df[,1]) # Change data type of first column to factor
  
  rownames(df) <- df[,1] # Put age groups into row names
  
  df <- df[,-1] # Reduce excessive column
  
  for (n in 1:2){ df[,n] <- as.numeric(df[,n]) } # Make values numeric
  
  df <- round(rowSums(df, na.rm = T) / sum(df), 4) * 100 # Multiply by 100
  
  df <- as.data.frame(df) # Change data type to data frame
  
  # Pie Plot by Age Groups
  plot_ly(df, labels = ~ages, values = ~df, type = 'pie', sort = F,
          textposition = 'outside', textinfo = 'percent') %>%
    layout(title = "Pie Plot of Russia's Age Portions",
           margin = list(l = 20, r = 20, t = 120),
           xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
           yaxis = list(showgrid = F, zeroline = F, showticklabels = F))
}
pie.plt.age("https://www.populationpyramid.net/api/pp/643/2020/?csv=true")
