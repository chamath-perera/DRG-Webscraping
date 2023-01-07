

webscrape_DRG <- function(DRG) {
  
  suppressPackageStartupMessages({
    
    suppressWarnings({
      
      list.of.packages <- c("rvest", "readr", "stringr")
      
      new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
      
      if(length(new.packages)) install.packages(new.packages)
      
      lapply(list.of.packages, require, character.only = TRUE)
      
    }) 
    
  })

  DRG_codes <- DRG
  
  baseurl <- "https://www.findacode.com/code.php?set=DRG&c="
  baseurl_print <- "https://www.findacode.com/tools/code-print.php?set=DRG&c="
  
  URLs <- paste0(baseurl, DRG_codes)
  URLs_print <- paste0(baseurl_print, DRG_codes)
  
  DRG <- matrix(NA, nrow = length(URLs), ncol = 4, dimnames = list(1:length(URLs), c("Code","Total FOP","Total FCP","DRG Cost")))
  
  for (i in 1:length(URLs)) {
    
    DRG[i,1] <- read_html(URLs[i]) %>% 
      html_nodes("h1") %>% 
      html_text(trim = TRUE)
    
    DRG_data <- read_html(URLs_print[i]) %>% 
      html_nodes('span[class="section_title"]') %>% 
      html_text(trim = TRUE)
    
    DRG[i,2] <- parse_number(str_match(DRG_data[11],"\\$([0-9,.]+)")[,2])
    
    DRG[i,3] <- parse_number(str_match(DRG_data[17],"\\$([0-9,.]+)")[,2])
    
    DRG[i,4] <- as.numeric(DRG[i,2]) + as.numeric(DRG[i,3])

  }
  
  return(DRG)
  
}


webscrape_DRG(c("453","570","946","947", "642", "543", "948"))


