#-*-coding:utf8-*-
import requests
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

html = requests.get('http://www.dy2018.com/i/96912.html')
# print html.text

a=[1,2,3]
b=[4,5,6]
a=a+b
print a 
# ftp://%bc%d3%c0%d5%b1%c8:%C7%EB%B5%C7%C2%BD%BC%D3%C0%D5%B1%C8%BB%<a%20href=\
url = "ftp://%bc%d3%c0%d5%b1%c8:%C7%EB%B5%C7%C2%BD%BC%D3%C0%D5%B1%C8%BB%<a%20href=\\"
url.replace("<a%\20href=\\","")
url2 = "<a%20href=\\"
print url

