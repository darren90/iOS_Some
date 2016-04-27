
#-*- coding: UTF-8 -*-   
 
import urllib2

class HtmlDownloader(object):
 
 
	def downloader(self,url):
		if url is None:
			return None
		response1 = urllib2.urlopen(url)
		print response1.getcode()
	 	if response1.getcode() != 200:
	 		return None 
	  	return response1.read()

