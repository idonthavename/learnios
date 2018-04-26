//
//  optionSelectViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/28.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "optionSelectViewController.h"
#import <iCarousel.h>
#import "oneTableViewController.h"
#import "twoTableViewController.h"
#import "threeTableViewController.h"
#import <RESideMenu.h>

#define buttonWidth 100
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)

@interface optionSelectViewController ()

@end

@implementation optionSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLoad];
    oneTableViewController* onet = [[oneTableViewController alloc] init];
    twoTableViewController* twot = [[twoTableViewController alloc] init];
    threeTableViewController* threet = [[threeTableViewController alloc] init];
    [_tableArray addObject:onet];
    [_tableArray addObject:twot];
    [_tableArray addObject:threet];
    _currentView = _tableArray[0];
    
    [self addChildViewController:_currentView];
    [_currentView didMoveToParentViewController:self];
    [self.view addSubview:_currentView.view];
    
    [self initHeaderButtons];
    
    _myScrollView.backgroundColor = [UIColor purpleColor];
    _myScrollView.contentSize = CGSizeMake(buttonWidth * _titleArray.count , 50);
    _myScrollView.canCancelContentTouches = YES;
        
    /*遮罩层
    UIViewController* hideViewC = [[UIViewController alloc] init];
    UIView* hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    hideView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    hideViewC.view = hideView;
    [self.navigationController.view addSubview:hideView];
    [self.view addSubview:hideView];
    [self.tabBarController.view addSubview:hideView];
    [self.sideMenuViewController presentLeftMenuViewController];
     */
}

-(void)initLoad{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"黄图",@"逗比",@"恶作剧", nil];
    }
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
}

-(void)initHeaderButtons{
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + (buttonWidth*i), 0, buttonWidth, 50);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        button.tag = 100 + i;
        [_myScrollView addSubview:button];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            _currentButton = button;
            _headerView = [[UIView alloc] init];
            _headerView.frame = CGRectMake(0, 50-5, buttonWidth, 5);
            _headerView.backgroundColor = [UIColor yellowColor];
            [_myScrollView addSubview:_headerView];
        }
    }
}

-(void)buttonPress:(UIButton*) button{
    if (button.tag == _currentButton.tag) {
        return;
    }else{
        [_currentButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_currentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect headerViewCG = _headerView.frame;
            headerViewCG.origin.x = button.frame.origin.x;
            _headerView.frame = headerViewCG;
        }];
        [self switchTableView:_tableArray[button.tag - 100]];
        _currentButton = button;
    }
}

-(void)switchTableView:(UITableViewController*) tableView{
    [self addChildViewController:tableView];
    [self transitionFromViewController:_currentView toViewController:tableView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:^(BOOL finished) {
        if (finished) {
            [_currentView willMoveToParentViewController:nil];
            [_currentView removeFromParentViewController];
            [tableView didMoveToParentViewController:self];
            _currentView = tableView;
        }
    }];
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
