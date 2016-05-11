#-*- coding: UTF-8 -*-   
import requests
import sys;
reload(sys);
sys.setdefaultencoding("utf8")

#http://tieba.baidu.com/f?ie=utf-8&kw=python
html = requests.get('http://tieba.baidu.com/f?ie=utf-8&kw=python')
print html.text
