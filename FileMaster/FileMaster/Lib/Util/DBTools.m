//
//  DBTools.m
//  FileMaster
//
//  Created by Tengfei on 16/6/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "DBTools.h"
#import "FMDB.h"

@implementation DBTools

static FMDatabaseQueue *_queue;


/**
 *  只加载一次
 */
+(void)initialize
{
    // 0.获得沙盒中的数据库文件名
    //不能放到Documents目录下，会和iTunes传输过来的内容冲突
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"fileMaster.sqlite"];
    
    KLog(@"%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        //  [db executeUpdate:@"drop table  t_status;"];
        [db executeUpdate:@"create table if not exists SeekDuration (id integer primary key autoincrement, duration double, title TEXT,movieId TEXT);"];
    }];
}



+(double)getSeekDuration:(NSString *)title
{
    __block double duration = 0.0;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select duration from SeekDuration where title = ? order by id desc",title];
        while (rs.next) {
            duration = [rs doubleForColumn:@"duration"];
            break;
        }
    }];
    return duration;
}

+(void)saveSeekDuration:(NSString *)title duration:(double)duration
{
    if (!title || duration <= 0.0) return;
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM SeekDuration where title = ?;",title];
        [db executeUpdate:@"insert into SeekDuration (title,duration) values (?,?)",title,@(duration)];
    }];
}


@end
