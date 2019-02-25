# instale a lib: pip install beautifulsoup4 

from __future__ import division, unicode_literals 
import codecs
from bs4 import BeautifulSoup

f=codecs.open("iac.html", 'r', 'utf-8')
document= BeautifulSoup(f.read()).get_text()
print(document)
