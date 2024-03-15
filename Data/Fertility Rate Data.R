library("rvest") # Library

fertility.rate.ru <- function(x){ # Fertility Data of Russia from Wikipedia
  
  s <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = ""))
  
  s.wiki <- s %>% html_nodes('table') %>% .[[1]] -> tab # Assign Table 
  
  y <- tab %>% html_nodes('tr') %>% html_nodes('td') %>% html_text()
  
  # Federal Districts
  l <- c("Central Federal District", "Northwestern Federal District",
         "Southern Federal District", "North Caucasian Federal District",
         "Volga Federal District", "Ural Federal District",
         "Siberian Federal District", "Far Eastern Federal District")
  
  D <- NULL # Get positions of Federal Districts in vector
  
  for (n in 1:length(l)){ D <- c(D, grep(l[n], y)) } # Join them
  
  C <- data.frame(D + 19 , c(D[-1], length(y))) # Make data frame for regions
  
  R <- NULL # Data Frame with Regions, Federal Districts and Fertility Rate
  
  for (n in 1:nrow(C)){ for (m in seq(C[n,1],C[n,2],by=19)){ while (m!=C[n,2]){
        
        r <- read.fwf(textConnection(y[m]), widths = c(nchar(1), nchar(y[m])),
                      colClasses = "character")[2]
      
        R <- rbind.data.frame(R,
                              cbind(r,
                                    read.fwf(textConnection(l[n]),
                                             widths = c(nchar(l[n])-17, 1),
                                             colClasses = "character")[,1],
                                    as.numeric(gsub('["\n"]', '', y[m + 18]))))
        
        break } } } # Stop when all data is collected and sign column names
  
  colnames(R) <- c("Region", " Federal District", "Fertility Rate")
  
  R[R$Region == "Moscow",][,1] <- "Moscow City" # Distinguish city from oblast
  
  # Reduce "Oblast" from Region names
  for (n in 1:nrow(R)) if (isTRUE(grepl("Oblast", R[n,1]))){ 
      
      O <- read.fwf(textConnection(R[n,1]), widths = c(nchar(R[n,1]) - 7, 1),
                    colClasses = "character")[,1] 
      
      R[R$Region == R[n,1],][,1] <- O } 
  
  # Replace region names to these ones
  R[R$Region == "Komi Republic",][,1] <- "Komi"
  R[R$Region == "Nenets Autonomous Okrug",][,1] <- "Nenets AO"
  R[R$Region == "North Ossetia–Alania",][,1] <- "North Ossetia"
  R[R$Region == "Yugra",][,1] <- "Khanty-Mansi AO"
  R[R$Region == "YaNAO",][,1] <- "Yamalo-Nenets AO"
  R[R$Region == "Altai Republic",][,1] <- "Altai"
  R[R$Region == "Yakutia",][,1] <- "Sakha"
  R[R$Region == "Jewish Autonomous",][,1] <- "Jewish AO"
  
  R <- R[-(nrow(R) - 2):-nrow(R),] # Reduce excessive rows
  
  R # Display
}
fertility.rate.ru("List_of_federal_subjects_of_Russia_by_total_fertility_rate")
