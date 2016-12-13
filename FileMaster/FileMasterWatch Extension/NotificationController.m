//
//  NotificationController.m
//  FileMasterWatch Extension
//
//  Created by Tengfei on 2016/12/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleL;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentL;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.

//    NSString *dict = notification;
 

//    NSString *str =  notification dat


    NSLog(@"--notification:%@",notification);
//    if (notification) {
//        NSDictionary *aps = [notification o:@"aps"];
//        NSString *category = [aps objectForKey:@"category"];
//        if ([category isEqualToString:@"NEWS_CATEGORY"]) {
//            NSString *title = [aps objectForKey:@"title"];
//            NSString *digest = [aps objectForKey:@"alert"];
//            [self.titleL setText:title];
//            [self.contentL setText:digest];
//
//
//            NSMutableDictionary *userInfo = [NSMutableDictionary new];
//            userInfo[@"PicName"] = @"applewatch004";
//            userInfo[@"Source"] = @"Notification";
//
////            [self updateUserActivity:WK_HANDOFF_demoDETAIL_IDENDIFIER userInfo:userInfo webpageURL:nil];
//        }
//    }

    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



