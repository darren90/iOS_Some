#-*-coding:utf8-*-
import requests
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

html = requests.get('http://www.hltm.tv/view/12436.html')
print html.text
