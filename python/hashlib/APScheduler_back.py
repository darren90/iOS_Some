#-*- coding: UTF-8 -*-   

# http://debugo.com/apscheduler/
# from apscheduler.schedulers.blocking import BlockingScheduler

# def my_job():
#     print 'hello world'

# sched = BlockingScheduler()
# sched.add_job(my_job, 'interval', seconds=1)
# sched.start()



# import logging    
# import psutil  
# import os  
  
# #设置一个日志输出文件  
# log_filename="logging.txt"  
  
# #设置日志输出格式  
# log_format=' [%(asctime)s]   %(message)s'  
  
# i=0  
  
# #获取当前运行的pid  
# p1=psutil.Process(os.getpid())   
  
# #将日志文件格式化  
# logging.basicConfig (format=log_format,datafmt='%Y-%m-%d %H:%M:%S %p',level=logging.DEBUG,filename=log_filename,filemode='w')  
  
# #cpu使用率  
# cpu_persent='cpu使用率：' +(str)(p1.cpu_percent(1))  
  
# #mem_persent='内存使用率：'+ (str)(p1.memory_percent)  
# while i<5:  
  
#     logging.debug('出纸检测   '+cpu_persent)  
#     i=i+1  
#     print i  



 #coding=utf-8
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import time
import os

def tick():
	print('Tick! The time is: %s' % datetime.now())


if __name__ == '__main__':
	scheduler = BlockingScheduler()
	scheduler.add_job(tick,'cron', second='*/3', hour='*') 
	print('Press Ctrl+{0} to exit'.format('Break' if os.name == 'nt' else 'C'))
	try:
		scheduler.start()
	except (KeyboardInterrupt, SystemExit):
		scheduler.shutdown() 











