//
//  enjoyWebViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/22.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "enjoyWebViewController.h"

@interface enjoyWebViewController ()

@end

@implementation enjoyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _webView.alpha = 0;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self.view sendSubviewToBack:_webView];
    
    NSURL* url = [NSURL URLWithString:_webUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _webView.alpha = 1;
    [_overScreen removeFromSuperview];
    [_actind stopAnimating];
}

- (IBAction)back:(id)sender {
    if(_webView.backForwardList.backList.count == 0) [self.navigationController popViewControllerAnimated:YES];
    [_webView goBack];
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
