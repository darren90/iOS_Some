#-*- coding: UTF-8 -*-

from bs4 import BeautifulSoup
import requests
import re
import urlparse
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

class spider(object):
    def __init__(self):
        print u'-- 开始爬取内容。。。'

#getsource用来获取网页源代码
    def getsource(self,url):
        html = requests.get(url)
        return html.text

# http://www.hltm.tv/list/7.html
# http://www.hltm.tv/list/7_2.html

#changepage用来生产不同页数的链接
    def changepage(self,url,keyStr,total_page):
        pages_arary = []
        pages_arary.append(url)
        # regex = re.compile(r"/\d+\.html")
        # typeStr = regex.findall(url)
        # print type(typeStr)
        # print 'typeStr %s ' % typeStr[0]
        count = 2
        for i in range(1,total_page):
            new_url = keyStr + '_%d' % count + ".html"
            new_full_url = urlparse.urljoin(url,new_url)
            # print new_full_url
            pages_arary.append(new_full_url)
            count = count + 1
        return pages_arary
    # 获取每个页面待爬取的item具体内容的链接
    def getAllLines(self,all_pages):
       links_arary = set()
       for page_url in all_pages:
           if page_url is None:
             break
           html = requests.get(page_url).text
           if html is None:
             break
           # print 'start-- : %s ' % html 
           soup = BeautifulSoup(html, "html.parser",from_encoding='utf-8') 
           links = soup.find('ul',class_="plist02 clearfix") #.find_all('li')
           if links is  None:
              break
           for link in links.find_all('li'):
              new_link = link.find('a')['href']   
              # print new_link
              links_arary.add(new_link)
       return links_arary

#解析具体的数据
    def parse_html_data(self,html_countent):
     res_data = {}
     soup = BeautifulSoup(html_countent, "html.parser",from_encoding='utf-8') 
     title = soup.find('div',class_="infotitle").find('h1')
     icon_url = soup.find('div',class_="bpic l").find('img')['src']
     # print title.get_text()
     print '-- %s' % title.get_text()
     down_types = soup.find('ul',class_="yuanItem").find_all('li')
     # print down_types
     count = 1
     for down_type in down_types:
        down_type_str = down_type.get_text().strip('\n')
        print '-- start :-%s -' % (down_type_str)
        keydoword = 'tabxinfan_1_tab_%d' % count        
        down_urls = soup.find(id=keydoword).find_all('li')# down_urls = soup.find(id="tabxinfan_1_tab_2").find_all('li')
        for downurl in down_urls:
            # print type(downurl) 
            # print downurl
            print downurl.find('a')['href']
            t_title = downurl.get_text().strip('\n')
            u_url = downurl.find('a')['href'].strip('\n')
            sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values (\"%s\",'%s','%s','%s','%s');" % (title.get_text(),icon_url,down_type_str, t_title, u_url)
            # sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ('%s','%s','%s','%s','%s') " % title.get_text() 
            res_data["sql"] = sql
            print sql
        count = count +1
        print '-- end---------'
     return res_data

# #geteveryclass用来抓取每个课程块的信息
#     def geteveryclass(self,source):
#         everyclass = re.findall('(<li deg="".*?</li>)',source,re.S)
#         return everyclass
# #getinfo用来从每个课程块中提取出我们需要的信息
#     def getinfo(self,eachclass):
#         info = {}
#         info['title'] = re.search('target="_blank">(.*?)</a>',eachclass,re.S).group(1)
#         info['content'] = re.search('</h2><p>(.*?)</p>',eachclass,re.S).group(1)
#         timeandlevel = re.findall('<em>(.*?)</em>',eachclass,re.S)
#         info['classtime'] = timeandlevel[0]
#         info['classlevel'] = timeandlevel[1]
#         info['learnnum'] = re.search('"learn-number">(.*?)</em>',eachclass,re.S).group(1)
#         return info
# #saveinfo用来保存结果到info.txt文件中
#     def saveinfo(self,classinfo):
#         f = open('info.txt','a')
#         for each in classinfo:
#             f.writelines('title:' + each['title'] + '\n')
#             f.writelines('content:' + each['content'] + '\n')
#             f.writelines('classtime:' + each['classtime'] + '\n')
#             f.writelines('classlevel:' + each['classlevel'] + '\n')
#             f.writelines('learnnum:' + each['learnnum'] +'\n\n')
#         f.close()

if __name__ == '__main__':
    fout = open('output.sql','w')
    fialCount = 1
    count = 1
    classinfo = []
    url = 'http://www.hltm.tv/list/7.html'#'http://www.hltm.tv/list/18.html'
    mySpider = spider()
    all_pages = mySpider.changepage(url,"7",10) #所有的页面 
    all_links = mySpider.getAllLines(all_pages)
    for link in all_links:
        # print link
        try:
            html = mySpider.getsource(link)
            res_data = mySpider.parse_html_data(html)
            fout.write(res_data["sql"].encode('utf-8') + '\n')
            count = count +1
        except Exception as e:
            if fialCount == 10200:
                fout.close()
                break
            fialCount = fialCount + 1
            count = count +1
            fout.write("-- Craw fail %d " % count + '\n')
            print '-- Craw fail %d ,excepton:%s' % (count,e)
    fout.close()
    # for link in all_links:
    #     print u'正在处理页面：' + link
    #     html = mySpider.getsource(link)
    #     everyclass = mySpider.geteveryclass(html)
    #     for each in everyclass:
    #         info = mySpider.getinfo(each)
    #         classinfo.append(info)
    # mySpider.saveinfo(classinfo)


# 已完结 第一页和第二页
# http://www.hltm.tv/list/18.html
# http://www.hltm.tv/list/18_2.html


# 连载中 第一页和第二页
# http://www.hltm.tv/list/7.html
# http://www.hltm.tv/list/7_2.html






