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
        response.encoding = 'gb2312'
        return response.text
# 得到所有的分类数据：标题 + 链接
    # def get_all_categorys(self,url):
    #     all_categorys = []
    #     # 第一个分类，由于没有地址，无法加入到总数组中
    #     all_categorys.append(dic_f)
    #     html = mySpider.getsource(url)
    #     soup = BeautifulSoup(html, "html.parser",from_encoding='utf-8') 
    #     links = soup.find('div',class_="co_content2").find_all('table')
    #     for link in links:
    #         if link.get_text() is not None:
    #             # print type(link)
    #             # print len(link.contents)
    #             for sub_link in link.find_all('td'):
    #                 if sub_link is None or sub_link == '':
    #                     continue
    #                 # print type(sub_link)
    #                 tag_a = sub_link.find('a')
    #                 if tag_a is None:
    #                   continue
    #                 # 类别的名称
    #                 title = sub_link.get_text().strip('\n')
    #                 # 类别对应的链接地址
    #                 new_url = tag_a['href']
    #                 full_url = urlparse.urljoin(url,new_url)
    #                 full_url = full_url + 'index.html'
    #                 # print '%s - %s ' % (title , full_url)
    #                 all_dic = {}
    #                 all_dic["url"]= full_url
    #                 all_dic["category"] = title
    #                 all_categorys.append(all_dic)
    #     return all_categorys

#得到所有的待爬取的链接
    def get_all_pages(self,url,total_page):
        pages_arary = []
        pages_arary.append(url)
        count = 2
        for i in range(1,total_page):
            new_url = "index" + '_%d' % count + ".html"
            new_full_url = url + new_url#urlparse.urljoin(url,new_url)
            # print new_full_url
            pages_arary.append(new_full_url)
            count = count + 1
        return pages_arary
# 获取每个页面待爬取的item具体内容的链接
    def get_all_urls(self,all_pages):
       links_arary = set()
       for page_url in all_pages:
           if page_url is None:
             break
           html = mySpider.getsource(page_url)
           if html is None:
             break
           # print 'start-- : %s ' % html 
           soup = BeautifulSoup(html, "html.parser",from_encoding='utf-8') 
           content = soup.find('div',class_="co_content8")
           if content is None:
              continue
           links = content.find_all('table')
           for link in links:
             if link.get_text() is not None:
                # print type(link)
                # print len(link.contents)

                # 时间，日期
                t_time = ""

                # 简介
                t_info = ""

                # 标题
                t_title = ""

                # 链接
                t_url = ""

                for sub_link in link.find_all('td'):
                    if sub_link is None or sub_link == '':
                        continue
                    tag_a = sub_link.find('a')
                    if tag_a is None:
                      titleStr = sub_link.get_text().replace(" ","").replace("\"","\'").replace("\t","").replace('\n','').replace(' ','').strip().lstrip().rstrip(',')   
                      if "日期" in titleStr:
                        t_time = titleStr
                      else:
                        t_info = titleStr
                      # continue
                    # 类别的名称
                    else: 
                        t_title = sub_link.get_text().strip('\n')
                        # 类别对应的链接地址
                        new_url = tag_a['href']
                        t_url = urlparse.urljoin(page_url,new_url)
                print 't_time:%s' % t_time
                print 't_info:%s' % t_info
                print 't_title:%s' % t_title
                print 't_url:%s' % t_url
                print '-----------------end---'
                    # full_url = urlparse.urljoin(url,new_url)
                    # full_url = full_url + 'index.html'
                    # # print '%s - %s ' % (title , full_url)
                    # all_dic = {}
                    # all_dic["url"]= full_url
                    # all_dic["category"] = title
                    # all_categorys.append(all_dic)


           # if links is  None:
           #    break
           # for link in links.find_all('li'):
           #    new_link = link.find('a')['href']   
           #    # print new_link
           #    links_arary.add(new_link)
       return links_arary

#解析具体的数据
    def parse_html_data(self,html_countent):
     res_array = []
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
            # print title.get_text()
            t_title = downurl.get_text().strip('\n')
            u_url = downurl.find('a')['href'].strip('\n')
            sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values (\"%s\",'%s','%s','%s','%s');" % (title.get_text().encode('utf-8'),icon_url,down_type_str, t_title, u_url)
            # sql = "insert into DBURL (tv_name,tv_iconUrl,tv_downType,tv_downSeries,tv_downSeries_url) values ('%s','%s','%s','%s','%s') " % title.get_text() 
            res_data["sql"] = sql
            res_array.append(res_data)
            print sql
        count = count +1
        print '-- end---------'
     return res_array
 
if __name__ == '__main__':
    fout = open('output_dy.sql','w')
    fialCount = 1
    count = 1
    classinfo = []
    url = 'http://www.dy2018.com/html/dongman/' 
    mySpider = spider()
    all_pages = mySpider.get_all_pages(url,1) #所有的页面 
    all_links = mySpider.get_all_urls(all_pages)
    # for link in all_links:
    #     # print link
    #     try:
    #         html = mySpider.getsource(link)
    #         res_array = mySpider.parse_html_data(html)
    #         for res_data in res_array:
    #             fout.write(res_data["sql"].encode('utf-8') + '\n')
    #         count = count +1
    #     except Exception as e:
    #         if fialCount == 10200:
    #             fout.close()
    #             break
    #         fialCount = fialCount + 1
    #         count = count +1
    #         fout.write("-- Craw fail %d " % count + '\n')
    #         print '-- Craw fail %d ,excepton:%s' % (count,e)
    fout.close()
 





