#%%

#' Developer: Chamath Perera
#' Version: 0_1
#' Date Created: 12-02-2022
#' Description: This script will webscrape the NCCN reccomended treatments from a website.

#Importing libraries

import requests
from bs4 import BeautifulSoup

url = "https://www.cancertherapyadvisor.com/home/cancer-topics/gastrointestinal-cancers/gastrointestinal-cancers-treatment-regimens/hepatocellular-carcinoma-treatment-regimens/"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

print(soup.title)

Tx_dosage = soup.findAll('p', attrs={"class": "drug-name"})

for dose in Tx_dosage:
    print(dose.text)
    