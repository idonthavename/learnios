//
//  oneTableViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/29.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface oneTableViewController : UITableViewController
@property(strong,nonatomic) NSMutableArray* data;
@property(strong,nonatomic) AFHTTPSessionManager* session;
@property(assign,nonatomic) int page;
@end
