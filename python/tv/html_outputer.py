
#-*- coding: UTF-8 -*-   
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )

class HtmlOutputer(object):
 	def __init__(self):
 		self.datas = []

	def collect_data(self,data):
		 if data is None:
		 	return
		 self.datas.append(data)


	def output_html(self):
		 fout = open('output.html','w')
		 fout.write("<html>")
		 fout.write("<body>")
		 fout.write("<table>")

		 print 'sdfsdfdsfds'
		 # asci
		 for data in self.datas:
		 	print 'caption'
		 	print data['caption']
		 	fout.write("<tr>")
		 	fout.write("<td>%s</td>" % data['caption'])
		 	fout.write("</tr>")

		 	for sub_data in data["arr"]:
		 		fout.write("<tr>")
		 		fout.write("<td style='color:blue;'>%s</td>" % sub_data['type'].encode('utf-8'))
			 	fout.write("<td>%s</td>" % sub_data['title'].encode('utf-8'))
			 	fout.write("<td>%s</td>" % sub_data['url'].encode('utf-8'))
			 	fout.write("</tr>")
		 	fout.write("<tr>")
		 	fout.write("<td style='color:red;'>------------------------</td>")
		 	fout.write("</tr>")

		 fout.write("</table>")
		 fout.write("</body>")
		 fout.write("</html>")

		 fout.close()




