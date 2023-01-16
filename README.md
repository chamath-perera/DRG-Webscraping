DRG-Code data Web Scraping
======================

### Simple python script to scrape costs from Find-A-Code.

The script takes a list of DRG codes and webscrapes them one by one and returns their costs. This allows the user to avoid spending time scrolling through various web pages to find costs, as this is automated and returned as a table.

Run the Webscraping_fn.py script to run the function. 

``` python
#Function to scrape costs from Find-A-Code.
webscrape_DRG("453","570","946","947", "642", "543", "948")

```
---

## R-code & Shiny

The python code above was replicated in R using the `rvest()` package. Data from the Find-a-Code website is scraped and returned in a table. The purpose of this tool is to automate the data collection process for analysts. 

``` r

    DRG[i,1] <- read_html(URLs[i]) %>% 
      html_nodes("h1") %>%
      html_text(trim = TRUE)

```

The function was also wrapped inside a simple Shiny app for increased accesibility. Use the `app.R` script to access the Shiny app.
