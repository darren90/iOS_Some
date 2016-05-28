
#-*- coding: UTF-8 -*-

import urllib2

class HtmlDownloader(object):

	def downloader(self,url):
		if url is None:
			return None
		response1 = urllib2.urlopen(url)
	 	if response1.getcode() != 200:
	 		return None
	 	#print response1.read()
	  	return response1.read()
