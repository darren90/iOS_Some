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

@interface HomeDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_news_collect_n_g"] style:UIBarButtonItemStyleDone target:self action:@selector(righBarBtnClick)];
    [self getData];
}

-(void)righBarBtnClick{
    
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
    NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
    [self.webView stringByEvaluatingJavaScriptFromString:requestDurationString];
    [self initNotice];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
