library("rvest") # library

dif.life.exp.ru <- function(x){ # Male & Female Life Expectancies in Russia
  
  s <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = ""))
  
  s.wiki <- s %>% html_nodes('table') %>% .[[1]] -> tab # Assign Table 
  
  y <- tab %>% html_nodes('tr') %>% html_nodes('td') %>% html_text()
  
  v <- NULL # Get data of regions with life expectancies
  
  for (n in 1:(length(y) / 20)){ d <- y[1 + n * 20] # Region names
  
    v <- rbind.data.frame(v, cbind(d, cbind(as.numeric(y[3 + n * 20]),
                                            as.numeric(y[4 + n * 20])))) }
  
  v <- v[apply(v, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  colnames(v) <- c("Region", "Male", "Female") # Column names
  
  if (isTRUE(any(v[,1] == "Sakha (Yakutia)"))){ # Rename some serions
    
    v[v$Region == "Khanty-Mansi AO(Tyumen Oblast)",][,1] <- "Khanty-Mansi AO" 
    v[v$Region == "Sakha (Yakutia)",][,1] <- "Sakha" 
    v[v$Region == "Arkhangelsk Oblast(except AO)",][,1] <- "Arkhangelsk Oblast"
    v[v$Region == "Yamalo-Nenets AO(Tyumen Oblast)",][,1] <- "Yamalo-Nenets AO"
    v[v$Region == "Jewish Autonomous Oblast",][,1] <- "Jewish AO" 
    v[v$Region == "Nenets AO(Arkhangelsk Oblast)",][,1] <- "Nenets AO" 
    v[v$Region == "Tyumen Oblast(except two AO)",][,1] <- "Tyumen Oblast" 
  }
  v # Display
}
dif.life.exp.ru("List_of_federal_subjects_of_Russia_by_life_expectancy") # Test
