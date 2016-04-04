//
//  SettingSwitchCell.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/7.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingSwitchCell.h"
#import "SettingSwitchItem.h"
#import "UMessage.h"

@interface SettingSwitchCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@end

@implementation SettingSwitchCell

- (void)awakeFromNib {
    // Initialization code
    [self.switchView addTarget:self action:@selector(switchState:) forControlEvents:UIControlEventValueChanged];

}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const Identifier = @"switchsetting";
    SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingSwitchCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


-(void)setItem:(SettingSwitchItem *)item
{
    _item = item;
    
    self.titleLabel.text = item.title;
    self.subTitleLabel.text = item.subtitle;
    self.switchView.on = item.isOn;
}


-(void)switchState:(UISwitch *)switchView{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([self.item.title isEqualToString:KSettingPush]) {//推送
        [defaults setBool:switchView.on forKey:KSettingPush];
        BOOL isOn = switchView.isOn;
        if (isOn == 1){
            //系统是否已经 打开允许通知了
            BOOL isallowPush = [self isAllowedNotification];
            if (isallowPush == 0) { //0代表没有打开
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:KAppName message:@"为了显示通知，您需要在【设置】->【通知】->【不包括】中启用通知" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
                [self openUMPush]; //系统允许推动，这里打开可以通知
            }
        }else{  //关闭推送
            [UMessage unregisterForRemoteNotifications];
        }

    }else if([self.item.title isEqualToString:KSettingUse3G]){//使用3G
          [defaults setBool:switchView.on forKey:KSettingUse3G];
    }
    [defaults synchronize];
    NSLog(@"---switch:%@",self.item.title);
}


-(void)openUMPush
{
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
}

- (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if (IsIOS8) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}


- (void)drawRect:(CGRect)rect   //画出tableviewcell下方的分割线
{
    CGFloat lineHeight = 0.4;
    CGFloat cellHetht = self.frame.size.height;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, cellHetht - lineHeight);
    CGContextAddLineToPoint(ctx, KWidth, cellHetht - lineHeight);
    CGContextSetRGBStrokeColor(ctx, 0.88, 0.88, 0.88, 1.0);
    CGContextStrokePath(ctx);
}


@end
