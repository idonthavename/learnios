//
//  optionSelectViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/28.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerScrollView.h"

@interface optionSelectViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet headerScrollView *myScrollView;

@property(strong,nonatomic) UIViewController* currentView;
@property(strong,nonatomic) UIButton* currentButton;
@property(strong,nonatomic) NSArray* titleArray;
@property(strong,nonatomic) NSMutableArray* tableArray;
@property(strong,nonatomic) UIView* headerView;


@end
