//
//  menuViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/29.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray* settingArray;
@property(strong,nonatomic) UIView* header;
@end
