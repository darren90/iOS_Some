#-*- coding: UTF-8 -*-

from bs4 import BeautifulSoup
import requests
import re
import types
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

#得到所有的待爬取的链接
    def get_all_pages(self,url,total_page):
        pages_arary = []
        pages_arary.append(url)
        count = 1
        for i in range(1,total_page):
            new_url = "?page=" + '%d' % count
            new_full_url = url + new_url#urlparse.urljoin(url,new_url)
            # print new_full_url
            pages_arary.append(new_full_url)
            count = count + 1
            # print new_full_url
        return pages_arary
        
# 获取每个页面待爬取的item具体内容的链接
    def get_all_urls(self,all_pages):
       links_arary = [] #set()
       for page_url in all_pages:
           if page_url is None:
             break
           html = mySpider.getsource(page_url)
           if html is None:
             break
           # print 'start-- : %s ' % html 
           soup = BeautifulSoup(html, "html.parser",from_encoding='utf-8') 
           content = soup.find('ul',class_="row mi-mg-l-05 mi-mg-r-05")
           if content is None:
              continue
           links = content.find_all('li') # .find('img')['src']   
           for link in links:
            # print title
            # print link.find('a')['href']
            # print  
            # print '------end-----' 
            # 装一下数据的字典
            link_dic = {}

            # 标题
            t_title = link.get_text().replace(" ","").replace("\"","\'").replace("\t","").replace('\n','').replace(' ','').strip().lstrip().rstrip(',')  

            # 图标链接
            t_iconurl = link.find('a').find('img')['data-src'] 

            # 下一个页面的链接
            t_url = link.find('a')['href']
            t_full_url = urlparse.urljoin(page_url,t_url)
            # print t_url
            # print t_full_url
            # print '------end ======'

            link_dic["title"] = t_title
            link_dic["iconurl"] = t_iconurl
            link_dic["playurl"] = t_full_url
            links_arary.append(link_dic)
       return links_arary

#解析具体的数据
    def parse_html_data(self,link_dic):
     t_iconurl = link_dic["iconurl"]
     t_title = link_dic["title"]
     t_playurl = link_dic["playurl"] # 带爬去下载地址的文件
     print t_playurl
     html = mySpider.getsource(t_playurl)
     if html is None:
        return
     # print html
     # res_array = []
     res_data = {}

     soup = BeautifulSoup(html, "html.parser",from_encoding='utf-8') 

     content = soup.find('div',class_="pd")
     if content is None:
        return
     t_info = content.find('p').get_text().replace(" ","").replace("\"","\'").replace("\t","").replace('\n','').replace(' ','').strip().lstrip().rstrip(',')  
     # print t_info
     # print '---ddddd---'
     sql = "insert into BDURL (tv_name,tv_iconUrl,tv_info,tv_playurl) \
             values (\"%s\",\"%s\",\"%s\",\"%s\");" % (t_title,t_iconurl,t_info,t_playurl)
     res_data["sql"] = sql
     # res_array.append(res_data)

     links = content.find_all('li')
     for link in links:
        print link.get_text()
#         res_data = {}
#         url = link.get_text().replace(" ","").replace("\"","\'").replace("\t","").replace('\n','').replace(' ','').strip().lstrip().rstrip(',')   
#         # print 'url:%s' % url 
# ]        # url = url.replace("\" target=\"_blank","").replace("<a%20href=\\","").replace("\\","\\\\")
#         # sql = "insert into DYURL (tv_name,tv_iconUrl,tv_state,tv_viewcount,tv_type,tv_dub,tv_showtime,tv_updatetime,tv_info,tv_downType,tv_downSeries,tv_downSeries_url) \
#         #      values (\"%s\",'%s',\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\");" % (t_title,"","",t_time,"","","",t_time,t_info,"", "", url)
#         # res_data["sql"] = sql
#         # print sql
#         res_array.append(res_data)
     return res_data
 
if __name__ == '__main__':
    fout = open('output_dy.sql','w')
    fialCount = 1
    count = 1
    classinfo = []
    url = 'http://buding.in/ep_category/5507c82d7dfea5f9348b4567' 
    mySpider = spider()
    all_pages = mySpider.get_all_pages(url,320) #所有的页面 
    all_links = mySpider.get_all_urls(all_pages)
    for link_dic in all_links:
        try:
            res_dic = mySpider.parse_html_data(link_dic)
            fout.write(res_dic["sql"].encode('utf-8') + '\n')
            print 'success:%d' % (count)
            count = count +1
        except Exception as e:
            print '-- Craw fail %d ,excepton:%s' % (count,e)
            if fialCount == 10200:
                fout.close()
                break
            fialCount = fialCount + 1
            count = count +1
            fout.write("-- Craw fail %d " % count + '\n')
    fout.close()
 
# category   pags
# MAD·AMV    320



