//
//  enjoyWebViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/22.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface enjoyWebViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) IBOutlet UIView *overScreen;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actind;
@property (weak, nonatomic) NSString* webUrl;
@end
