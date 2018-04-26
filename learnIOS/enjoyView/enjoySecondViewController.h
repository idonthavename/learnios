//
//  enjoySecondViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/9.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface enjoySecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *search;

@end
