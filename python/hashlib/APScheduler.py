#-*- coding: UTF-8 -*-   

# http://debugo.com/apscheduler/
# from apscheduler.schedulers.blocking import BlockingScheduler

# def my_job():
#     print 'hello world'

# sched = BlockingScheduler()
# sched.add_job(my_job, 'interval', seconds=1)
# sched.start()










 #coding=utf-8
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import time
import os
import logging    
import psutil  


#设置一个日志输出文件  
log_filename="logging.txt"  

  
#设置日志输出格式  
log_format=' [%(asctime)s]   %(message)s'  

  
#将日志文件格式化  
logging.basicConfig (format=log_format,datafmt='%Y-%m-%d %H:%M:%S %p',level=logging.DEBUG,filename=log_filename,filemode='w')  
  
 
def tick():
	print('Tick! The time is: %s' % datetime.now())
	logging.debug('Tick! The time is : %s' % datetime.now()) 



if __name__ == '__main__':
	scheduler = BlockingScheduler()
	scheduler.add_job(tick,'cron', second='*/1', hour='*') 
	print('Press Ctrl+{0} to exit'.format('Break' if os.name == 'nt' else 'C'))
	try:
		scheduler.start()
	except (KeyboardInterrupt, SystemExit):
		scheduler.shutdown() 











