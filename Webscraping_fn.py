
# %%
def webscrape_DRG(*code):
    
    #Load required libraries
    import pandas as pd
    import requests
    from bs4 import BeautifulSoup
    import re

    #Set max table column width and allow text wrapping. 
    pd.set_option('display.max_colwidth', 0)

    #Define the DRG codes that will be webscraped from the website
    DRG_codes = [*code]

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
    
    #Create empty lists that will hold data from webscraped DRG codes
    code = []
    FCP = []
    FOP = []

    #Web scraping using a for loop that passes through all URLs
    for url in urls[:]:
        page = requests.get(url).text
        soup = BeautifulSoup(page, 'html.parser')
        name = soup.find('blockquote')
        name.br.extract()
        code.append(name.text[1:-213])
        FOP.append(soup.find(id="drg_t_op_pmt").getText()) #id in the DRG website for the Federal Operating Payment
        FCP.append(soup.find(id="drg_t_cp_pmt").getText()) #id in the DRG website for the Federal Capital Payment

    FCP = [item.strip() for item in FCP]
    FOP = [item.strip() for item in FOP]

    #Column names for the df table 
    df["DRG Codes"] = code
    df["Federal Capital Payment"] = FCP
    df["Federal Operating Payment"] = FOP

    intFCP = []

    #Extracting only the numbers from the extracted data. 
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
        
    #Sum of the two numbers FOP + FCP
    sum_list = [a + b for a, b in zip(intFCP, intFOP)]

    #Empty list for the Total Federal Payment
    TFP = []

    #Apply the $ formatting to the number
    for element in sum_list:
        TFP.append("${:,.2f}".format(element))
    
    #Column name     
    df["Total Federal Payment"] = TFP

    #Return the data table
    return(df)

#%%
webscrape_DRG("453","570","946","947", "642", "543", "948")
