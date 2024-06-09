lapply(c("ggplot2"), require, character.only = T) # Libraries

stack.bar.plt.pop.age <- function(x, c, position = NULL){ #
  
  y <- as.character(seq(1950, 2050, 5)) # list with years
  
  D <- NULL #
  
  for (m in 1:length(y)){ # Get Data for each year
  
    # Download CSV file from website
    f <- read.csv2(file =
                     url(sprintf("https://www.%s.net/api/pp/%s/%s/?csv=true",
                                 "populationpyramid", x, y[m]))) 
    
    df <- NULL # name for data frame
    
    for (n in 1:nrow(f)){ # Divide column into three
      
      df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,")))}
    
    nums <- df[,1] # Assign Age groups 
    
    df$Total <- sum(as.numeric(df[,2]), as.numeric(df[,3])) # Sum Age Groups
    
    l <- NULL # 
    
    for (n in 1:nrow(df)){ l <- rbind.data.frame(l, sum(as.numeric(df[n,2]),
                                                        as.numeric(df[n,3]))) }
    
    l <- data.frame(df[,1], l) #
    
    colnames(l) <- c("Age", y[m]) # Column names
    
    if (is.null(D)){ D <- l } else { D <- merge(D, l, by = "Age") } } 
  
  D <- D[match(nums, D$Age),] # Change Order of Market Caps
  
  df.plt <- NULL # Optimise for ggplot2 format
  
  for (n in 1:nrow(D)){ for (j in 2:ncol(D)){ # 
      
      df.plt <- rbind.data.frame(df.plt, cbind(D[n,1], colnames(D)[j],
                                               as.numeric(D[n,j]))) } }
  
  colnames(df.plt) <- c("Age", "Year", "Population") # Column names
  
  df.plt$Age <- factor(df.plt$Age, level = unique(df.plt$Age), ordered = F)
  
  df.plt[,3] <- as.numeric(df.plt[,3]) / 10^6 # Change column format to numeric
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  if (is.null(position)){
  
  ggplot(df.plt, aes(x = Year, y = Population, fill = Age)) + theme_minimal() +
    geom_bar(position = "fill", stat = "identity") + 
    labs(title = sprintf("%s's Population Dynamics by Age Groups", c),
         x = "Years",
         y = "Portions", fill = "Age Groups") + scale_fill_manual(values = C) +
    scale_y_continuous(breaks = seq(0, 1, 0.05),
                       sec.axis = ggplot2::sec_axis(~.,
                                                    breaks = seq(0,1,.05))) 
  } else {
      
    ggplot(df.plt, aes(x = Year, y = Population, fill = Age))+theme_minimal() +
      geom_bar(position = "stack", stat = "identity") + 
      labs(title = sprintf("%s's Population Dynamics by Age Groups", c),
           x = "Years", y = "Population in millions", fill = "Age Groups") +
      scale_fill_manual(values=C) }
}
stack.bar.plt.pop.age("643", c = "Russia", position = "stack") # Test
