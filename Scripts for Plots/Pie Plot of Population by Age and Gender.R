library("plotly") # Library

pie.plt.nested.gender.age <- function(x){ # Nested Pie Plot by Gender and Age
  
  # Download CSV file from website
  f <- read.csv2(file = url(sprintf("https://www.populationpyramid.net/%s",x))) 
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  ages <- as.factor(df[,1]) # Change data type of first column to factor
  
  for (n in 2:3){ df[,n] <- as.numeric(df[,n]) } # make columns numeric
  
  D1 <- NULL # "Age group" / Age group"
  D2 <- NULL # "Total - Male" / Total - Female"
  D3 <- NULL # "Total - Male - Age group" / Total - Female - Age group"
  D4 <- NULL # "Numbers"
  
  for (n in 1:nrow(df)){ D1 <- rbind.data.frame(D1, rbind(df[n,1], df[n,1]))
    
    D2 <- rbind.data.frame(D2, rbind(sprintf("Total - %s", colnames(df)[2]),
                                     sprintf("Total - %s", colnames(df)[3])))
    
    D3 <- rbind.data.frame(D3, rbind(sprintf("Total - %s - %s",
                                             colnames(df)[2], df[n,1]),
                                     sprintf("Total - %s - %s",
                                             colnames(df)[3], df[n,1])))
    
    D4 <- rbind.data.frame(D4, rbind(df[n,2], df[n,3])) }
    
  df1 <- data.frame(D1, D2, D3, D4) # Join all data frames
  
  # Data Frame with rows of Male and Female Groups
  df.gender <- cbind.data.frame(rbind(c("Male", "Total", "Total - Male",
                                        colSums(df[,2:3])[1]),
                                      c("Female", "Total", "Total - Female",
                                        colSums(df[,2:3])[2])))
  
  list.df <- list(df.gender, df1) # Put 2 Data Frames into a list
  
  df2 <- NULL # Give data frames same column names and join them
  
  for (n in 1:length(list.df)){ colnames(list.df[[n]]) <- c("labels","parents",
                                                            "ids", "n")
    df2 <- rbind.data.frame(df2, list.df[[n]]) }
  
  # Plot
  plot_ly(data = df2, ids = ~ids, labels = ~labels, parents = ~parents,
          values = ~n, type = "sunburst", branchvalues = "total",
          sort = F) %>%#, textposition = 'outside', textinfo = 'percent') %>%
    layout(title = "Pie Plot of Russia's Female Population by Age Group",
           margin = list(l = 20, r = 20, t = 120),
           xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
           yaxis = list(showgrid = F, zeroline = F, showticklabels = F))
}
pie.plt.nested.gender.age("api/pp/643/2020/?csv=true") # Test
