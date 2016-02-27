//
//  SAOAuthViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/21.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAOAuthViewController.h"
#import "AFNetworking.h"
#import "SAAccount.h"
#import "MBProgressHUD+MJ.h"
#import "SAAccountTool.h"


@interface SAOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SAOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //1.创建一个webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.y = 22;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    self.view.backgroundColor = [UIColor colorWithRGBARed:210 Green:210 Blue:210 Alpha:1];
    [self.view addSubview:webView];
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id	    true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3301393131&redirect_uri=http://alrcly.lofter.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在登录中……"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        long   fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

//利用code(授权成功后的Request token)换取了个accessToken
- (void)accessTokenWithCode:code{
    
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3301393131";
    params[@"client_secret"] = @"ad78fef0c21093aab9d9587160de0445";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://alrcly.lofter.com";
    params[@"code"] = code;
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        SALog(@"请求成功——%@",responseObject);
        
        [MBProgressHUD hideHUD];
        
        SAAccount *accout = [SAAccount accountWithDict:responseObject];
        
        //存储账号信息
        [SAAccountTool saveAccount:accout];
        
        //新特性版本号对比
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SALog(@"请求失败——%@",error);
        [MBProgressHUD hideHUD];
    }];
}

@end
