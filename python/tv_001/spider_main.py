
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
		fialCount = 1
		self.urls.add_new_url(root_url)
		fout = open('output.sql','w')
		while  self.urls.has_new_url:
		 	try:
			 	new_url = self.urls.get_new_url()
			 	print '-- craw %d : %s' % (count,new_url)
			 	html_count = self.downloader.downloader(new_url)
			 	new_urls,new_data = self.parser.parser(new_url,html_count)
				fout.write(new_data["sql"].encode('utf-8') + '\n')

			 	self.urls.add_new_urls(new_urls)
			 	self.outputer.collect_data(new_data)

			 	# if count == totalCount:
			 	# 	break
			 	count = count +1
			except:
				# if count == totalCount:
			 # 		break
			 	 if fialCount == 10200:
			 	 	fout.close()
			 	 	break
			 	 fialCount = fialCount + 1
				 count = count +1
				 fout.write("-- Craw fail %d " % count + '\n')
			 	 print '-- Craw fail %d' % count
		fout.close()
		# self.outputer.output_html()


if __name__=="__main__":
	root_url = "http://www.hltm.tv/view/12436.html"
	obj_spider = SpiderMain()
	obj_spider.craw(root_url)
