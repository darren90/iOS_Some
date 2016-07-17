//
//  DBTools.m
//  FileMaster
//
//  Created by Tengfei on 16/6/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "DBTools.h"
#import "FMDB.h"
#import "Rank_Word.h"
#import <MJExtension.h>

@implementation DBTools

static FMDatabaseQueue *_queue;


/**
 *  只加载一次
 */
+(void)initialize
{
    // 0.获得沙盒中的数据库文件名
    //不能放到Documents目录下，会和iTunes传输过来的内容冲突
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"rank.sqlite"];
    
    NSLog(@"%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        //  [db executeUpdate:@"drop table  t_status;"];
        [db executeUpdate:@"create table if NOT EXISTS rank_word (id INTEGER primary key AUTOINCREMENT, rank_year varchar(200), rank varchar(200), last_rank varchar(200), co_name varchar(200),co_detailurl varchar(200), income varchar(200), profit varchar(200), nation varchar(200));"];
    }];
    

    //沙盒路径
    NSString *home = NSHomeDirectory();
    NSString *documents = [home stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",documents);
    
    //
    if ([TFTools shouldExecuteSql]) {
        NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"rank_wrod.sql" ofType:nil];
        NSString *sqlStr = [NSString stringWithContentsOfFile:sqlPath encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"%@",sqlStr);
        [_queue inDatabase:^(FMDatabase *db) {
            [db executeStatements:sqlStr];
        }];
    }
}



+(NSArray *)get_rank_word_year:(NSString *)rank_year
{
    __block NSMutableArray *array = [NSMutableArray array];
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select rank_year , rank , last_rank , co_name,co_detailurl , income , profit , nation from rank_word where rank_year = ?",rank_year];
        while (rs.next) {
//            rank_year , rank , last_rank , co_name,co_detailurl , income , profit , nation
            NSString *rank_year = [rs stringForColumn:@"rank_year"];
            NSString *rank = [rs stringForColumn:@"rank"];
            NSString *last_rank = [rs stringForColumn:@"last_rank"];
            NSString *co_name = [[rs stringForColumn:@"co_name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *co_detailurl = [rs stringForColumn:@"co_detailurl"];
            NSString *income = [rs stringForColumn:@"income"];
            NSString *profit = [rs stringForColumn:@"profit"];
            NSString *nation = [rs stringForColumn:@"nation"];
            
            Rank_Word *rw = [[Rank_Word alloc]init];
            rw.rank_year = rank_year;
            rw.rank = rank;
            rw.last_rank = last_rank;
            rw.co_name = co_name;
            rw.co_detailurl = co_detailurl;
            rw.income = income;
            rw.profit = profit;
            rw.nation = nation;
            [array addObject:rw];
        }
    }];
    return array;
}

+(void)saveSeekDuration:(NSString *)title duration:(double)duration
{
    if (!title || duration <= 0.0) return;
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into rank_word (title,duration) values (?,?)",title,@(duration)];
    }];
}


@end
