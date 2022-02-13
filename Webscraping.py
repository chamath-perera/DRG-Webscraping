from bs4 import BeautifulSoup
import urllib.request
import re

url = "https://en.wikipedia.org/wiki/Artificial_intelligence"
page = urllib.request.urlopen(url)

soup = BeautifulSoup(page, 'html.parser')
print(soup)

regex = re.compile('^tocsection-')
content_lis = soup.find_all('li', attrs={'class': regex})
print(content_lis)