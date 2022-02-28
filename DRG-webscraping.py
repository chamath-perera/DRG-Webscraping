
# %%
#Load required libraries
import webbrowser
import pandas as pd
import requests
from bs4 import BeautifulSoup

#Set max table column width and allow text wrapping. 
pd.set_option('display.max_colwidth', 0)

#Define the DRG codes that will be webscraped from the website
DRG_codes = ["453","570","946","947"]

#Base url that will be used to generate the final url in the build_url function. 
baseurl = "https://www.findacode.com/tools/code-print.php?set=DRG&c="

#Define the function to create the url that will be scraped.
def build_url(DRGcode):
    return baseurl + DRGcode
urls = []
for DRGcode in DRG_codes:
    urls.append(build_url(DRGcode))

#Table to display the results    
data = {"URLS": urls[:]}

df = pd.DataFrame(data)

#Print the table in the output
df

cost = []

#Webscraping commences 
for url in urls[:]:
    page = requests.get(url).text
    soup = BeautifulSoup(page, 'html.parser')
    cost.append(soup.find_all("table")[14].get_text())

df["costs"] = cost

df

#Open the webpage from the URL that has been generated in the build_url function. 
for url in urls[:]:
   webbrowser.open(url,1)

