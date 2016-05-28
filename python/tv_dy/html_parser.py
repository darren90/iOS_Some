#-*- coding: UTF-8 -*-   
from bs4 import BeautifulSoup
import re
import urlparse
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )

class HtmlParser(object):
 
 
	def parser(self,page_url,html_count):
		if page_url is None or html_count is None:
			return
		#soup = BeautifulSoup(html_count, "html_parser", from_encoding='utf-8')
		soup = BeautifulSoup(html_count, "html.parser",from_encoding='utf-8') 
		new_urls = self._get_new_urls(page_url,soup)
		new_data = self._get_new_data(page_url,soup)
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
		 res_dic = {}
		 res_arr = []

		 # res_data["url"] = page_url

		 # down_urls = soup.find('div',class_="tab_content")
		 # print type(down_urls)
		 # print down_urls.get_text()

		 title = soup.find('div',class_="infotitle").find('h1')
		 
		 icon_url = soup.find('div',class_="bpic l").find('img')['src']
		 # print icon_url

		 # print title.get_text()
		 print '-- %s' % title.get_text()
		 res_dic["caption"] = title.get_text()

		 down_types = soup.find('ul',class_="yuanItem").find_all('li')
		 # print down_types
		 count = 1
		 for down_type in down_types:
		 	# print down_type.find('a').get('onmousemove')
		 	# secBoard('tabxinfan_1','tabxinfan_1_tab',1);
		 	# print down_type.get_text()
		 	# print len(down_types) #取数组的
		 	# 开始遍历每一个下载链接
		 	# print '--------- %s:start---------' % down_type.get_text()
		 	down_type_str = down_type.get_text().strip('\n')
		 	print '-- start :-%s -' % (down_type_str)
			keydoword = 'tabxinfan_1_tab_%d' % count	 	
		 	down_urls = soup.find(id=keydoword).find_all('li')# down_urls = soup.find(id="tabxinfan_1_tab_2").find_all('li')
		 	for downurl in down_urls:
		 		res_sub_dic = {}
		 		# print type(downurl) 
		 		print page_url
		 		print downurl.get_text()
		 		# print downurl
		 		print downurl.find('a')['href']
		 		res_sub_dic["type"] = down_type.get_text()
		 		res_sub_dic['title'] = downurl.get_text()
		 		res_sub_dic['url'] = downurl.find('a')['href']
		 		res_dic["arr"] = res_arr
		 		t_title = downurl.get_text().strip('\n')
		 		u_url = downurl.find('a')['href'].strip('\n')
		 		sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values (\"%s\",'%s','%s','%s','%s');" % (title.get_text(),icon_url,down_type_str, t_title, u_url)
		 		# sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ('%s','%s','%s','%s','%s') " % title.get_text() 
		 		res_data["sql"] = sql
		 		res_data["page_url"] = "-- page_url:%s " % page_url
		 		print sql

		 		res_arr.append(res_sub_dic)
		 	count = count +1
		 	print '-- end---------'
 
		 #old no usr again

		 # #<dd class="lemmaWgt-lemmaTitle-title"> <h1>Python</h1>
		 # title_node = soup.find('div', class_="infotitle").find("h1")
		 # # print 'title node %s' % title_node.get_text()
		 # res_data['title'] = title_node.get_text()
		 # # print 'sdf %s' % res_data['title']

		 # #<div class="lemma-summary" label-module="lemmaSummary"> <div class="para" label-module="para">
		 # summary_node = soup.find('div',class_="lemma-summary")
		 # res_data['summary'] = summary_node.get_text()
		 return res_data

# CREATE TABLE "DBURL" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "tv_name" TEXT, "tv_iconUrl" TEXT, "tv_downType" TEXT, "tv_downSeries" TEXT, "tv_downSeries_url" TEXT);
# insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ("神盾","http://icon.icon.com","网盘","第一集","http://down.down.com") 
# insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ('神盾2','http://icon.icon.com','网盘','第一集','http://down.down.com') 
# truncate table `fei`.`DBURL` 
# `fei`.`DBURL`

