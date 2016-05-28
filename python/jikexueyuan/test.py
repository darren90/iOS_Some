#-*-coding:utf8-*-
import requests
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

html = requests.get('http://www.dy2018.com/i/96912.html')
print html.text
