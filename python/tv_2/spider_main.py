
#-*- coding: UTF-8 -*-

#from baike import url_manager,html_downloader,html_parser,html_outputer
import url_manager,html_downloader,html_parser,html_outputer


class SpiderMain(object):
	def __init__(self):
		self.urls = url_manager.UrlManager()
		self.downloader = html_downloader.HtmlDownloader()
		self.parser = html_parser.HtmlParser()
		self.outputer = html_outputer.HtmlOutputer()

	def craw(self,root_url):
		count = 1
		totalCount = 10
		self.urls.add_new_url(root_url)
		while  self.urls.has_new_url:
		 	try:
			 	new_url = self.urls.get_new_url()
			 	print 'craw %d : %s' % (count,new_url)
			 	html_count = self.downloader.downloader(new_url)
			 	new_urls,new_data = self.parser.parser(new_url,html_count)

			 	self.urls.add_new_urls(new_urls)
			 	self.outputer.collect_data(new_data)

			 	if count == totalCount:
			 		break

			 	count = count +1
			except:
				if count == totalCount:
			 		break
				count = count +1
			 	print 'Craw fail %d' % count

		self.outputer.output_html()


if __name__=="__main__":
	root_url = "http://www.hltm.tv/view/12436.html"
	obj_spider = SpiderMain()
	obj_spider.craw(root_url)
