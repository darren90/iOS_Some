
#-*- coding: UTF-8 -*-   
# import sys
# reload(sys)
# sys.setdefaultencoding( "utf-8" )

class HtmlOutputer(object):
 	def __init__(self):
 		self.datas = []

	def collect_data(self,data):
		 if data is None:
		 	return
		 self.datas.append(data)


	def output_html(self):
		 fout = open('output.sql','w')
		 for data in self.datas:
		 	fout.write(data["sql"].encode('utf-8') + '\n')
		 fout.close()



 		# f = open('output.sql','w')
 		# print self.datas
   #      for data in self.datas:
   #          f.write(data["sql"].encode('utf-8') +'\n')
   #      f.close()

		 # fout = open('output.html','w')
		 # fout.write("<html>")
		 # fout.write("<body>")
		 # fout.write("<table>")
		 
		 # #asci
		 # count = 1
		 # for data in self.datas:
		 # 	# print 'caption'
		 # 	# print data['caption']
		 # 	fout.write("<tr>")
		 # 	fout.write("<td>%s</td>" % data['caption'])
		 # 	fout.write("<td>   第%d条</td>" % count)
		 # 	fout.write("</tr>")

		 # 	for sub_data in data["arr"]:
		 # 		fout.write("<tr>")
		 # 		fout.write("<td style='color:blue;'>%s</td>" % sub_data['type'].encode('utf-8'))
			#  	fout.write("<td>%s</td>" % sub_data['title'].encode('utf-8'))
			#  	fout.write("<td>%s</td>" % sub_data['url'].encode('utf-8'))
			#  	fout.write("</tr>")
		 # 	fout.write("<tr>")
		 # 	fout.write("<td style='color:red;'>------------------------</td>")
		 # 	fout.write("</tr>")
		 # 	count = count + 1

		 # fout.write("</table>")
		 # fout.write("</body>")
		 # fout.write("</html>")

		 # fout.close()




