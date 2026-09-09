# Pie Plot showing gender portions
pie.plt.gender <- function(year=NULL, country=NULL, name=NULL, radius=1){ 
  
  if (is.null(year)) year = format(Sys.Date(), "%Y")
  if (is.null(country)) country = "643"
  
  # Download CSV file from website
  f <- read.csv2(
    file = url(
      sprintf(
        "https://www.populationpyramid.net/api/pp/%s/%s/?csv=true",
        country, year
        )
      )
    ) 
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  df <- df[,-1] # Reduce excessive column
  
  for (n in 1:2){ df[,n] <- as.numeric(df[,n]) } # make columns numeric
  
  df <- round(colSums(df, na.rm = T) / sum(df), 4) * 100 # sum for each gender
  
  if (is.null(name)) main = "Gender Portion" 
  else main = sprintf("%s's Gender Portion", name)
  
  pie(
    df, 
    labels = c(sprintf("%s %s%%", names(df), df)), 
    radius = radius,
    col = c("navy", "darkred"),
    main = main
    )
}
pie.plt.gender(name="Russia")
