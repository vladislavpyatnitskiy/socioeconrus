library("rvest") # Library

fertility.rate.ru <- function(x){ # Fertility Data of Russia from Wikipedia
  
  y <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = "")) %>%
    html_nodes('table') %>% .[[1]] %>% html_nodes('tr') %>%
    html_nodes('td') %>% html_text()
  
  # Federal Districts
  l <- sprintf("%s Federal District", c("Central", "Northwestern", "Southern",
                                        "North Caucasian", "Volga", "Ural",
                                        "Siberian", "Far Eastern"))
  
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
  
  for (n in 1:nrow(R)) if (isTRUE(grepl("Oblast", R[n,1]))){ # Reduce "Oblast"
    
      O <- read.fwf(textConnection(R[n,1]), widths = c(nchar(R[n,1]) - 7, 1),
                    colClasses = "character")[,1] 
      
      R[R$Region == R[n,1],][,1] <- O } # Reform some Regions' names as well
    
  s <- list(c("Komi Republic","Nenets Autonomous Okrug","North Ossetia–Alania",
              "Yugra", "Yamalo-Nenets Autonomous Okrug", "Altai Republic",
              "Yakutia", "Jewish Autonomous"),
            c("Komi", "Nenets AO", "North Ossetia", "Khanty-Mansi AO",
              "Yamalo-Nenets AO", "Altai", "Sakha", "Jewish AO"))
  
  for (n in 1:length(s)[[1]]){ R[R$Region == s[[1]][n],][,1] <- s[[2]][n] }
  
  R[-(nrow(R) - 2):-nrow(R),] # Reduce excessive rows and display data frame
}
fertility.rate.ru("List_of_federal_subjects_of_Russia_by_total_fertility_rate")
