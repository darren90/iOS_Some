#-*- coding: UTF-8 -*-   

import hashlib

md5 = hashlib.md5()
md5.update('how to use md5 in python hashlib?')
print md5.hexdigest()


#如果数据量很大，可以分块多次调用update()，最后计算的结果是一样的：

md5 = hashlib.md5()
md5.update('how to use md5 in ')
md5.update('python hashlib?')
print md5.hexdigest()

print '-------------------'

# import hashlib

m = hashlib.md5()
m.update('a')
print m.hexdigest()    # 0cc175b9c0f1b6a831c399e269772661
m.update('a')
print m.hexdigest()    # 4124bc0a9335c27f086f24ba207a4912

m = hashlib.md5()
m.update('aa')
print m.hexdigest()    # 4124bc0a9335c27f086f24ba207a4912

# 用set
# new_urls = set()
# new_urls.add(url)
# f url not in self.new_urls and url not in self.old_urls:
# 			self.new_urls.add(url)
# 爬取过程中的时候，可以用set判断url是否爬取过
# 但是 如果爬过也要用md5其内容，来判断内容是否已经更新了。
# 所以数据库中要能存 爬取的url和内容的md5字段 is_crawled:是否已经爬取



#redis缓存数据库








