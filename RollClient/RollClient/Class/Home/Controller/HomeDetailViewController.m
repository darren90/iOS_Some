//
//  HomeDetailViewController.m
//  RollClient
//
//  Created by Fengtf on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "RollImgDetail.h"

@interface HomeDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
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
    NSString *url = @"http://112.74.95.46/item/n/detail";
    if ([self.itemType isEqualToString:@"2"]) {
        url = @"http://112.74.95.46/item/n/video";
    }
    //发送请求 http://112.74.95.46/item/n/video
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          NSLog(@"%@",responseObject);
       
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
}

-(void)success:(NSDictionary *)json{
    if ([self.itemType isEqualToString:@"1"]) {//图片
        
        RollImgDetail *model = [RollImgDetail mj_objectWithKeyValues:json[@"detail"]];
        
        NSString *bodyStr = model.itemDetailArticle;
        NSString *cssStr = @"";
        NSString *html = @"<html> <head>";
        html = [html stringByAppendingString:cssStr];
        html = [html stringByAppendingString:@"</head>"];
        html = [html stringByAppendingString:bodyStr];
        html = [html stringByAppendingString:@"</body> </html>"];
        
        [self.webView loadHTMLString:html baseURL:nil];
    }else if ([self.itemType isEqualToString:@"2"]){//视频
        
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

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}


@end