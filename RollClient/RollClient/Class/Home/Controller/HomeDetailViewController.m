//
//  HomeDetailViewController.m
//  RollClient
//
//  Created by Fengtf on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "RollImgDetail.h"
#import "RollVideoDetail.h"
#import "LoadingPreView.h"
#import "RollModel.h"

@interface HomeDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)LoadingPreView *preView;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = nil;
    if ([DatabaseTool isHadCollected:self.collectModel.itemId]) {
        rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_news_collect_h_gx"] style:UIBarButtonItemStyleDone target:self action:@selector(righBarBtnClickDel:)];
    }else{
        rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_news_collect_n_gx"] style:UIBarButtonItemStyleDone target:self action:@selector(righBarBtnClickAdd:)];
    }
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _preView = [[LoadingPreView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_preView];
    
    [self getData];
}

-(void)righBarBtnClickAdd:(UIBarButtonItem *)item{
    [DatabaseTool saveRollCollect:self.collectModel withId:self.collectModel.itemId];
//    [item setImage:[UIImage imageNamed:@"icon_me_collect"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_news_collect_h_gx"] style:UIBarButtonItemStyleDone target:self action:@selector(righBarBtnClickDel:)];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    SVProgressHUD.minimumDismissTimeInterval = 0.6;
    [SVProgressHUD showSuccessWithStatus:@"添加收藏成功"];
}

-(void)righBarBtnClickDel:(UIBarButtonItem *)item{
    [DatabaseTool deleteRollCollect:self.collectModel.itemId];
//    [item setImage:[UIImage imageNamed:@"icon_news_collect_h"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_news_collect_n_gx"] style:UIBarButtonItemStyleDone target:self action:@selector(righBarBtnClickAdd:)];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    SVProgressHUD.minimumDismissTimeInterval = 0.6;
    [SVProgressHUD showSuccessWithStatus:@"删除收藏成功"];
}


-(void)getData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *itemId = self.itemId == nil ? @"" : self.itemId;
    params[@"itemId"] = itemId;
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    mgr.responseSerializer  = [AFJSONResponseSerializer serializer];
    __unsafe_unretained __typeof(self) weakSelf = self;
    NSString *url = @"http://112.74.95.46/item/n/detail";
    if ([self.itemType isEqualToString:@"2"]) {
        url = @"http://112.74.95.46/item/n/video";
    }
    //发送请求 http://112.74.95.46/item/n/video
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          NSLog(@"%@",responseObject);
          [weakSelf success:responseObject];
       
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
}

-(void)success:(NSDictionary *)json{
    if ([self.itemType isEqualToString:@"1"]) {//图片
        
        RollImgDetail *model = [RollImgDetail mj_objectWithKeyValues:json[@"detail"]];
        
        NSString *bodyStr = model.itemDetailArticle;
        NSString *cssStr = @"<link rel=\"stylesheet\" type=\"text/css\" href=\"http://112.74.95.46/html/css/dt.css\">";
        NSString *html = @"<html> <head>";
        html = [html stringByAppendingString:cssStr];
        html = [html stringByAppendingString:@"</head>"];
        html = [html stringByAppendingString:bodyStr];
        html = [html stringByAppendingString:@"</body> </html>"];
        
        [self.webView loadHTMLString:html baseURL:nil];
    }else if ([self.itemType isEqualToString:@"2"]){//视频
        RollVideoDetail *model = [RollVideoDetail mj_objectWithKeyValues:json[@"video"]];
        NSString *cssStr = [NSString stringWithFormat:@"<div class=\"tt-video-box\" tt-videoid=\'%@\' tt-poster=\'%@\'>视频加载中...</div>  <script src=\"http://s0.pstatp.com/tt_player/tt.player.js\"></script>",model.videoSrc,model.videoSrc];

        NSString *comment = [NSString stringWithFormat:@"<div id=\"uyan_frame\"></div>  <script type=\"text/javascript\" src=\"http://v2.uyan.cc/code/uyan.js?uid=%@\"></script>",model.itemVideoId];
        
        NSString *html = @"<html> <head>";
        html = [html stringByAppendingString:cssStr];
        html = [html stringByAppendingString:@"</head>"];
//        html = [html stringByAppendingString:bodyStr];
        
        html = [html stringByAppendingString:comment];
        html = [html stringByAppendingString:@"</body> </html>"];
        [self.webView loadHTMLString:html baseURL:nil];
        
    }
}

#pragma - mark 初始化通知
-(void)initNotice
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
    
}

#pragma - mark  进入全屏
-(void)begainFullScreen
{
    NSLog(@"------begainFullScreen");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.allowRotation = YES;
    
    //强制横屏：-：右偏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
#pragma - mark 退出全屏
-(void)endFullScreen
{
    NSLog(@"------endFullScreen");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(void)webViewDidStartLoad:(UIWebView *)webView
{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_preView removeFromSuperview];
        
        [self initNotice];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL isON = [defaults boolForKey:KAutoPlayView];
   
        if(isON){//自动播放时执行
            //延时自动播放
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
                [self.webView stringByEvaluatingJavaScriptFromString:requestDurationString];
            });
        }
    });
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_preView removeFromSuperview];
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
