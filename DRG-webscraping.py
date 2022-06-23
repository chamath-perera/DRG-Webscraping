
# %%
#' Title: DRG-Webscraping
#' Developer: CP
#' Version: 0_1


#Load required libraries
import webbrowser
import pandas as pd
import requests
import re
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

code = []
FCP = []
FOP = []

#Webscraping commences 
for url in urls[:]:
    page = requests.get(url).text
    soup = BeautifulSoup(page, 'html.parser')
    name = soup.find('blockquote')
    name.br.extract()
    code.append(name.text[1:-213])
    FCP.append(soup.find(id="drg_t_op_pmt").getText())
    FOP.append(soup.find(id="drg_t_cp_pmt").getText())

FCP = [item.strip() for item in FCP]
FOP = [item.strip() for item in FOP]

df["DRG Codes"] = code
df["Federal Capital Payment"] = FCP
df["Federal Operating Payment"] = FOP

intFCP = []

for element in FCP:
    x= re.findall(r"\$[^\]]+", element)
    x = ''.join(x)
    x = x.replace("$","").replace(",","")
    intFCP.append(float(x))

intFOP = []

for element in FOP:
    x= re.findall(r"\$[^\]]+", element)
    x = ''.join(x)
    x= x.replace("$","").replace(",","")
    intFOP.append(float(x))
    

sum_list = [a + b for a, b in zip(intFCP, intFOP)]

TFP = []

for element in sum_list:
    TFP.append("${:,.2f}".format(element))
    
df["Total Federal Payment"] = TFP

df

#Open the webpage from the URL that has been generated in the build_url function. 
#for url in urls[:]:
    #webbrowser.open(url,1)