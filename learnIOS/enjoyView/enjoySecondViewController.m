//
//  enjoySecondViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/9.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "enjoySecondViewController.h"
#import <RESideMenu.h>
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface enjoySecondViewController ()

@end

@implementation enjoySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.sideMenuViewController.panGestureEnabled = NO;
    self.navigationItem.hidesBackButton = YES;
    _search.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIButton *cancleBtn = [_search valueForKey:@"cancelButton"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:77.0/255.0 green:174.0/255.0 blue:245.0/255.0 alpha:1.0]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [_search becomeFirstResponder];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = @"和情人在斗嘴";
    return cell;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.sideMenuViewController.panGestureEnabled = YES;
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
