
#-*- coding: UTF-8 -*-   
from bs4 import BeautifulSoup
import re
import urlparse

class HtmlParser(object):
 
 
	def parser(self,page_url,html_count):
		if page_url is None or html_count is None:
			return
		#soup = BeautifulSoup(html_count, "html_parser", from_encoding='utf-8')
		soup = BeautifulSoup(html_count, "html.parser") 
		new_urls = self._get_new_urls(page_url,soup)
		new_data = self._get_new_data(page_url,soup)
		print 'new new'
		return new_urls,new_data

	def _get_new_urls(self,page_url,soup):
		 new_urls = set()
		 links = soup.find_all('a',href=re.compile(r"/view/\d+\.htm"))
		 for link in links:
		 	new_url = link['href']
		 	new_full_url = urlparse.urljoin(page_url,new_url)
		 	new_urls.add(new_full_url)
		 return new_urls

	def _get_new_data(self,page_url,soup):
		 res_data = {}
		 res_data["url"] = page_url
		 #<dd class="lemmaWgt-lemmaTitle-title"> <h1>Python</h1>
		 title_node = soup.find('div', class_="infotitle").find("h1")
		 print 'title node'
		 print title_node.get_text()
		 print 'title node2'
		 res_data['title'] = title_node.get_text()

		 #<div class="lemma-summary" label-module="lemmaSummary"> <div class="para" label-module="para">
		 summary_node = soup.find('div',class_="lemma-summary")
		 res_data['summary'] = summary_node.get_text()
		 return res_data
