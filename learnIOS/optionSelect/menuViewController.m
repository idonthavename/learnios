//
//  menuViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/29.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "menuViewController.h"
#import "UIImage+UIImage_Scale.h"

@interface menuViewController ()

@end

@implementation menuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView* tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingArray = [NSMutableArray arrayWithObjects:@"了解会员特权",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件",@"免流量特权", nil];
//    tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    if (@available(iOS 11.0, *)) tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:tableView];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _header.frame.size.width, _header.frame.size.height)];
    UIImage* image = [UIImage imageNamed:@"images/menuimg.jpg"];
    image = [image getSubImage:CGRectMake(200, 200, _header.frame.size.width, _header.frame.size.height)];
    imageview.image = image;
    //imageview.clipsToBounds = YES;
    imageview.contentMode = UIViewContentModeScaleToFill;
    //[imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    [_header addSubview:imageview];
    return _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _settingArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellid = [NSString stringWithFormat:@"cell"];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = _settingArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"images/cell3.png"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
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
