#-*_coding:utf8-*-
import requests
import re
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

class spider(object):
    def __init__(self):
        print u'开始爬取内容。。。'

#getsource用来获取网页源代码
    def getsource(self,url):
        html = requests.get(url)
        return html.text

# http://www.hltm.tv/list/7.html
# http://www.hltm.tv/list/7_2.html

#changepage用来生产不同页数的链接
    def changepage(self,url,total_page):
        pages_arary = []
        pages_arary.append(link)
        count = 2
        for i in total_page:
            link = re.sub('/\S+_.html','%s_.html'%i,url)
             


        # for i in range(now_page,total_page+1):
        #     link = re.sub('/sd+_.html','%s_.html'%i,url,re.S)
        #     print link
        #     pages_arary.append(link)
        return pages_arary
    # def changepage(self,url,total_page):
    #     now_page = int(re.search('(7_\d+).html',url,re.S).group(1))
    #     pages_arary = []
    #     for i in range(now_page,total_page+1):
    #         link = re.sub('\d+_.html','%s_.html'%i,url,re.S)
    #         print link
    #         pages_arary.append(link)
    #     return pages_arary
#geteveryclass用来抓取每个课程块的信息
    def geteveryclass(self,source):
        everyclass = re.findall('(<li deg="".*?</li>)',source,re.S)
        return everyclass
#getinfo用来从每个课程块中提取出我们需要的信息
    def getinfo(self,eachclass):
        info = {}
        info['title'] = re.search('target="_blank">(.*?)</a>',eachclass,re.S).group(1)
        info['content'] = re.search('</h2><p>(.*?)</p>',eachclass,re.S).group(1)
        timeandlevel = re.findall('<em>(.*?)</em>',eachclass,re.S)
        info['classtime'] = timeandlevel[0]
        info['classlevel'] = timeandlevel[1]
        info['learnnum'] = re.search('"learn-number">(.*?)</em>',eachclass,re.S).group(1)
        return info
#saveinfo用来保存结果到info.txt文件中
    def saveinfo(self,classinfo):
        f = open('info.txt','a')
        for each in classinfo:
            f.writelines('title:' + each['title'] + '\n')
            f.writelines('content:' + each['content'] + '\n')
            f.writelines('classtime:' + each['classtime'] + '\n')
            f.writelines('classlevel:' + each['classlevel'] + '\n')
            f.writelines('learnnum:' + each['learnnum'] +'\n\n')
        f.close()

if __name__ == '__main__':

    classinfo = []
    url = 'http://www.hltm.tv/list/7.html'
    mySpider = spider()
    all_links = mySpider.changepage(url,20)
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






