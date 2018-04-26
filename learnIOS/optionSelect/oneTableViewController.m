//
//  oneTableViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/29.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "oneTableViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface oneTableViewController ()

@end

@implementation oneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01f)];
    self.view.layer.zPosition = -1;
    _session = [AFHTTPSessionManager manager];
    _session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    _data = [[NSMutableArray alloc] init];
    _page = 1;
    
    
    MJRefreshGifHeader* MJhead = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self reFreshData:0];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self reFreshData:1];
    }];
    MJhead.automaticallyChangeAlpha = YES;
    MJhead.lastUpdatedTimeLabel.hidden = YES;
    [MJhead setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [MJhead setTitle:@"释放就要刷新咯" forState:MJRefreshStatePulling];
    [MJhead setTitle:@"服务器正在狂奔" forState:MJRefreshStateRefreshing];
    MJhead.stateLabel.textColor = [UIColor redColor];
    MJhead.stateLabel.font = [UIFont systemFontOfSize:16];
    NSMutableArray* loading = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 3; i++) {
        UIImage* loadimage = [UIImage imageNamed:[NSString stringWithFormat:@"images/loading/dropdown_loading_%02d@2x.png",i]];
        [loading addObject:loadimage];
    }
    [MJhead setImages:[NSArray arrayWithObject:loading[0]] forState:MJRefreshStateIdle];
    [MJhead setImages:loading forState:MJRefreshStateRefreshing];
    [MJhead setImages:loading forState:MJRefreshStatePulling];
    [self reFreshData:0];
    //self.tableView.contentInset = UIEdgeInsetsMake(-56, 0, 0, 0);
    self.tableView.mj_header = MJhead;
}

-(void)reFreshData:(int)type{
    NSDictionary* params = [[NSDictionary alloc] init];
    if (type) {
        _page++;
        params = @{@"pages":[NSNumber numberWithInt:_page]};
    }else{
        params = nil;
    }
    [SVProgressHUD showWithStatus:@"加载中"];
    [_session GET:@"http://198.181.47.194/ios/index/test-user" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (type == 0) {
            [_data removeAllObjects];
        }
        if ((int)responseObject[@"status"] < 100){
            _page--;
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            _data[_page-1] = [[NSMutableArray alloc] init];
            for (NSMutableDictionary* item in responseObject[@"data"]) {
                [_data[_page-1] addObject:item];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    [SVProgressHUD dismissWithDelay:0.5];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"1 hit");
}

-(void)viewWillLayoutSubviews{
    self.view.frame = CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _page;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (_data.count > 0) {
        cell.textLabel.text = _data[indexPath.section][indexPath.row][@"name"];
        cell.detailTextLabel.text = _data[indexPath.section][indexPath.row][@"number"];
    }else{
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
