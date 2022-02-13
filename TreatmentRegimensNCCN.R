#' Title: Web scraping NCCN Treatments 
#' Developer: Chamath Perera
#' Date:12/02/2022

library(rvest)
library(readr)
library(tm)
library(xml2)

#Scraping the regimen names
Tx_header <- read_html("https://www.cancertherapyadvisor.com/home/cancer-treatment-regimens/") %>% 
  html_nodes(".js-fr-accordion__header") %>% 
  html_text() %>% 
  readr::parse_character()

Tx_header

#Scraping all regimen subgroups 
Tx_title <- read_html("https://www.cancertherapyadvisor.com/home/cancer-treatment-regimens/") %>%
  html_nodes(".title") %>% 
  html_text() %>% 
  readr::parse_character()

Tx_title

#Example function to construct the URL that will be used to scrape information. 
runURL <- function(regimens = 1:4){
  
  url = "https://www.cancertherapyadvisor.com/home/cancer-topics"
  
  if (regimens == 1){
    url = paste(url,"gastrointestinal-cancers/gastrointestinal-cancers-treatment-regimens/hepatocellular-carcinoma-treatment-regimens/")
  }
  
  print(url)
}

#Scraping the treatments included in the web page 
cancer <- read_html(runURL(regimens = 1))

Tx <- cancer %>% 
  html_nodes(".drug-name") %>% 
  html_text2()

Tx

#Scraping the published date of the web page 
date <- cancer %>% 
  html_nodes(".-published") %>% 
  html_text()

paste0("Published ",parse_date(date, "%B %d, %Y"))


#Web scrape the download link (href) for the pdf with all the regimens. 
download <- cancer %>%
  html_node(".download-document")

xml2::xml_attrs(download)[[2]]


