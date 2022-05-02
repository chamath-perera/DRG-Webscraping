DRG-Webscraping
======================

### Simple python script to scrape costs from Find-A-Code.

The script takes a list of DRG codes and webscrapes them one by one and returns their costs. This allows the user to avoid spending time scrolling through various web pages to find costs when this is automated and returned as a table. 

Run the Webscraping_fn.py script to run the function. 

``` python
#Function to scrape costs from Find-A-Code.

webscrape_DRG("453","570","946","947", "642", "543", "948")

```
The table will output the costs for each DRG code in a table format. Like the one below. 

| |           URLS                                         |                                DRG Codes                                                                                                                                                                                               Federal Capital Payment |                Federal Capital Payment |                       Federal Operating Payment |            | Total Federal Payment 
|-----:|-------------------------------------------------------------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|-----------------------------------------:|--------------------------------------------:|------------|
|    0 | https://www.findacode.com/tools/code-print.php?set=DRG&c=453 |                              453 - COMBINED ANTERIOR AND POSTERIOR SPINAL FUSION WITH MCC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the | Total Federal Capital Payment: $4,342.16 | Total Federal Operating Payment: $56,245.72 | $60,587.88 |
|    1 | https://www.findacode.com/tools/code-print.php?set=DRG&c=570 |                                                           570 - SKIN DEBRIDEMENT WITH MCC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the | Total Federal Capital Payment: $1,342.96 | Total Federal Operating Payment: $17,395.89 | $18,738.85 |
|    2 | https://www.findacode.com/tools/code-print.php?set=DRG&c=946 |                                                       946 - REHABILITATION WITHOUT CC/MCC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the |   Total Federal Capital Payment: $532.23 |  Total Federal Operating Payment: $6,894.20 |  $7,426.43 |
|    3 | https://www.findacode.com/tools/code-print.php?set=DRG&c=947 |                                                         947 - SIGNS AND SYMPTOMS WITH MCC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the |   Total Federal Capital Payment: $564.27 |  Total Federal Operating Payment: $7,309.25 |  $7,873.52 |
|    4 | https://www.findacode.com/tools/code-print.php?set=DRG&c=642 |                                            642 - INBORN AND OTHER DISORDERS OF METABOLISM\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the |   Total Federal Capital Payment: $609.55 |  Total Federal Operating Payment: $7,895.70 |  $8,505.25 |
|    5 | https://www.findacode.com/tools/code-print.php?set=DRG&c=543 | 543 - PATHOLOGICAL FRACTURES AND MUSCULOSKELETAL AND CONNECTIVE TISSUE MALIGNANCY WITH CC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the |   Total Federal Capital Payment: $493.95 |  Total Federal Operating Payment: $6,398.35 |  $6,892.30 |
|    6 | https://www.findacode.com/tools/code-print.php?set=DRG&c=948 |                                                      948 - SIGNS AND SYMPTOMS WITHOUT MCC\nNote:  DRG information, including Relative Weight, Length of Stay, Procedure Type, and more, is also available.Access to this feature is available in the |   Total Federal Capital Payment: $371.98 |  Total Federal Operating Payment: $4,818.35 |  $5,190.33 |