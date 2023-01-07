
################################################################################

#' DRG-Code Web scraper Internal Tool
#' Version: v0.0.1 (Jan-2023)
#' Developer: Chamath Perera
#' License: GNU General Public License v3.0 
#' Copyright: 2023

#' This is a web-application that will scrape data from Find-a-Code.com, using
#' the `rvest` package. The purpose of this tool is to automate the data collection
#' process for analysts.

#' Both user interface and server scripts will be included in the same R-script.

################################################################################

library(shiny)
library(DT)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Find-A-Code Data Scraping Tool"),
    h2(tags$a(href="https://github.com/chamath-perera/DRG-Webscraping", icon("github"))),
    
    br(),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel( width = 4,
          textInput("text", "Add your DRG codes seperated by a comma:", value = "948,812,941,442,869,446,813,392,096"),
          actionButton("bttn", "Return Costs")
        ),

        # Show a plot of the generated distribution
        mainPanel(width = 8,
           DTOutput("DRGtext"),
           tags$head(tags$style("#DRGtext {white-space: pre-wrap; word-break: keep-all; font-size: 12px}")),
           textOutput("test")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  DRGcodes <- eventReactive(input$bttn, {
    
    words <- unlist(strsplit(input$text, ",")) # get words separated by ','
    paste0(words)
    
  })
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
          
          withProgress(message = 'Fetching data...', value = 0, {
            
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
              
              incProgress(amount = 1/length(URLs), detail = paste(round(i/length(URLs)*100,2),"%") )
              
            }
            
          })
          
          return(DRG)
          
        }
        
  output$DRGtext <- renderDataTable({
    
    datatable(webscrape_DRG(DRGcodes()), extensions = 'Buttons', 
    options = list(dom = 'Bfrtip',buttons = c('copy', 'csv', 'excel', 'pdf', 'print'))) %>% 
    formatCurrency(c(2:4), digits = 2)
  
  })
    

  
  }

# Run the application 
shinyApp(ui = ui, server = server)
