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
        response = requests.get(url)
        response.encoding = 'utf-8'
        return response.text

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
           response = requests.get(page_url)
           response.encoding = 'utf-8'
           html = response.text.encode('utf-8')
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
     res_array = []
     res_data = {}
     soup = BeautifulSoup(html_countent, "html.parser",from_encoding='utf-8') 

     # 标题
     title = soup.find('div',class_="infotitle").find('h1')

     # 标题对应的图片地址
     icon_url = soup.find('div',class_="bpic l").find('img')['src']   

     # 简介- 带有HTML标签
     t_info_d = soup.find('div',class_="box01 mb20 l")

     t_info = t_info_d #.replace("\"","\\").replace("\'","\\'")  
     # 简介 - 去除HTML标签
     t_cleaninfo = t_info_d.get_text().replace(" ","").replace("\"","\'").replace("\t","").replace('\n','').replace(' ','').replace("<ｓｃｒｉｐｔtype=\"text/javaｓｃｒｉｐｔ\"><ｓｃｒｉｐｔ>","").strip().lstrip().rstrip(',')    
     if len(t_cleaninfo) > 2001:
        t_cleaninfo = t_cleaninfo[0:2000] 
     other_infos = soup.find('div',class_="info l").find_all('li')  #soup.find(id="info l").find_all('li')  

     #从数组中取出其他的值

     # 更新状态
     t_state = ""

     # 点击量
     t_viewcount = ""

     # 动漫类型
     t_type = ""

     # 动漫地区
     t_showarea = ""

     # 配音语言
     t_dub = ""

     # 上映时间
     t_showtime = ""

     # 最后更新的时间
     t_updatetime = ""

     for other_info in other_infos:
         t_msg = other_info.find('p').get_text().strip()
         t_span = other_info.find('span').get_text().strip()
         if t_span is not None:
            if t_span == "状态":
                t_state = t_msg
            elif t_span == "点击量":
                t_viewcount = t_msg
            elif t_span == "动漫类型":
                t_type = t_msg
            elif t_span == "动漫地区":
                t_showarea = t_msg
            elif t_span == "配音语言":
                t_dub = t_msg
            elif t_span == "上映年份":
                t_showtime = t_msg
            elif t_span == "最后更新":
                t_updatetime = t_msg
            else:
                print ''
     # print title.get_text()
     print '-- %s' % title.get_text()
     down_types = soup.find('ul',class_="yuanItem").find_all('li')
     # print down_types
     count = 1
     # down_type 下载类型
     for down_type in down_types:
        down_type_str = down_type.get_text().strip('\n')
        print '-- start :-%s -' % (down_type_str)
        keydoword = 'tabxinfan_1_tab_%d' % count        
        down_urls = soup.find(id=keydoword).find_all('li')# down_urls = soup.find(id="tabxinfan_1_tab_2").find_all('li')
        for downurl in down_urls:
            # print title.get_text()
            # 每一集的标题
            t_title = downurl.get_text().strip('\n')
            # 每一集的下载地址
            u_url = downurl.find('a')['href'].strip('\n')

            sql = "insert into DBURL (tv_name,tv_iconUrl,tv_state,tv_viewcount,tv_type,tv_dub,tv_showtime,tv_updatetime,tv_info,tv_downType,tv_downSeries,tv_downSeries_url) \
             values (\"%s\",'%s',\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",'%s','%s','%s');" % (title.get_text().encode('utf-8'),icon_url,t_state,t_viewcount,t_type,t_dub,t_showtime,t_updatetime,t_cleaninfo,down_type_str, t_title, u_url)
            # sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ('%s','%s','%s','%s','%s') " % title.get_text() 
            res_data["sql"] = sql
            res_array.append(res_data)
            print sql
        count = count +1
        print '-- end---------'
     return res_array
 
if __name__ == '__main__':
    fout = open('output_1.sql','w')
    fialCount = 1
    count = 1
    classinfo = []
    url = 'http://www.hltm.tv/list/7.html' #'http://www.hltm.tv/list/7.html' # 'http://www.hltm.tv/list/18.html'
    mySpider = spider()
    all_pages = mySpider.changepage(url,"7",10) # mySpider.changepage(url,"18",300) #所有的页面 
    all_links = mySpider.getAllLines(all_pages)
    for link in all_links:
        # print link
        try:
            html = mySpider.getsource(link)
            res_array = mySpider.parse_html_data(html)
            for res_data in res_array:
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


# 已完结 第一页和第二页
# http://www.hltm.tv/list/18.html
# http://www.hltm.tv/list/18_2.html


# 连载中 第一页和第二页
# http://www.hltm.tv/list/7.html
# http://www.hltm.tv/list/7_2.html






