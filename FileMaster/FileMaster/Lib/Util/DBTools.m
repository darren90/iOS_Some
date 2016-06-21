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
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"fileMaster.sqlite"];
    
    NSLog(@"%@",path);
    
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
    //    __block NSMutableArray *dictArray = nil;
    __block double duration = 0.0;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select duration from SeekDuration where title = ?",title];
        while (rs.next) {
            duration = [rs doubleForColumn:@"duration"];
            break;
        }
    }];
    return duration;
}

+(void)saveSeekDuration:(NSString *)title duration:(double)duration
{
//    __block NSMutableArray *dictArray = nil;
    if (!title || duration <= 0.0) return;
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into SeekDuration (title,duration) values (?,?)",title,@(duration)];
    }];
}

//+(void)addStatus:(NSDictionary *)dict
//{
//    NSString *access_token = [TFAccountTools account].access_token;
//    NSString *idstr = dict[@"idstr"];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
//    [_queue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:@"insert into t_status (access_token,idstr,dict) values (?,?,?)",access_token,idstr,data];
//    }];
//    
//}
//
//
//+(NSArray *)statusesWithParam:(TFHomeStatusParam *)param
//{
//    __block NSMutableArray *dictArray = nil;
//    
//    [_queue inDatabase:^(FMDatabase *db) {
//        dictArray = [NSMutableArray array];
//        
//        // accessToken
//        NSString *accessToken = [TFAccountTools account].access_token;
//        
//        FMResultSet *rs = nil;
//        if (param.since_id) { // 如果有since_id
//            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
//        } else if (param.max_id) { // 如果有max_id
//            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
//        } else { // 如果没有since_id和max_id
//            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
//        }
//        
//        while (rs.next) {
//            NSData *data = [rs dataForColumn:@"dict"];
//            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            [dictArray addObject:dict];
//        }
//        
//        
//    }];
//    
//    return dictArray;
//}




@end
