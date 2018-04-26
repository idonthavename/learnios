//
//  enjoyIndexViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/8.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "enjoyIndexViewController.h"
#import <UIImageView+WebCache.h>
#import "UIImage+UIImage_Scale.h"
#import <MJRefresh.h>
#import "enjoyWebViewController.h"

#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)

@interface enjoyIndexViewController ()

@end

@implementation enjoyIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _session = [AFHTTPSessionManager manager];
    _session.responseSerializer = [AFJSONResponseSerializer serializer];
    _headerBannerArray = [[NSMutableArray alloc] init];
    _activityArray = [[NSMutableArray alloc] init];
    _newsArray = [[NSMutableArray alloc] init];
    _search.backgroundImage = [self imageWithColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0] size:_search.bounds.size];
    [_search setImage:[UIImage imageNamed:@"images/search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [_search valueForKey:@"searchField"];
    if (searchField) {
        // 背景色
        [searchField setBackgroundColor:[UIColor colorWithRed:0.074 green:0.649 blue:0.524 alpha:1.000]];
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        // 圆角
        searchField.layer.cornerRadius = 15.0f;
        searchField.layer.masksToBounds = YES;
    }
    _search.delegate = self;
    [self initData];
    //banner
    [_headerBanner layoutIfNeeded];
    [_activityScroll layoutIfNeeded];
    _icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_headerBanner.frame), CGRectGetHeight(_headerBanner.frame))];
    _icarousel.type = iCarouselTypeLinear;
    _icarousel.pagingEnabled = YES;
    _icarousel.delegate = self;
    _icarousel.dataSource = self;
    _icarousel.tag = 100;
    [_headerBanner addSubview:_icarousel];
    //选项栏
    _activityCollection.delegate = self;
    _activityCollection.dataSource = self;
    UICollectionViewFlowLayout* activityLayout = [[UICollectionViewFlowLayout alloc] init];
    activityLayout.itemSize = CGSizeMake((screenWidth - 20 * 6) / 5, 60);
    activityLayout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    _activityCollection.collectionViewLayout = activityLayout;
    //活动
    _icarouselActivity = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_activityScroll.frame), CGRectGetHeight(_activityScroll.frame))];
    _icarouselActivity.type = iCarouselTypeLinear;
    _icarouselActivity.pagingEnabled = YES;
    _icarouselActivity.dataSource = self;
    _icarouselActivity.delegate = self;
    _icarouselActivity.tag = 101;
    [_activityScroll addSubview:_icarouselActivity];
    //新闻列表
    _tablewView.delegate = self;
    _tablewView.dataSource = self;
    _tablewView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tablewView.sectionFooterHeight = 0;
    _tablewView.rowHeight = UITableViewAutomaticDimension;
    _tablewView.estimatedRowHeight = 180.0f;
    _contentScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshNews)];
    _contentScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
}

-(void)reSizeTableView{
    [_tablewView reloadData];
    [_tablewView layoutIfNeeded];
    _tableViewConst.constant = _tablewView.contentSize.height;
}

-(void)refreshNews{
    _pageNews++;
    NSDictionary* paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:_pageNews], @"page", nil];
    [_session GET:@"http://198.181.47.194/ios/index/news" parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(_pageNews < 2) [_newsArray removeAllObjects];
        [_contentScrollView.mj_header endRefreshing];
        [_contentScrollView.mj_footer endRefreshing];
        if ([responseObject[@"status"] intValue] < 100) {
            [SVProgressHUD showErrorWithStatus:@"服务器宕机"];
        }else{
            if ([responseObject[@"data"] count] == 0) {
                [_contentScrollView.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (NSDictionary* dic in responseObject[@"data"]) {
                    [_newsArray addObject:dic];
                }
                [self reSizeTableView];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"新闻加载失败"];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    enjoyWebViewController* enjoyWeb =[self.storyboard instantiateViewControllerWithIdentifier:@"enjoyWeb"];
    enjoyWeb.webUrl = _newsArray[indexPath.row][@"url"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:enjoyWeb animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_newsArray.count > 0) {
        NSDictionary* data = _newsArray[indexPath.row];
        if ([data[@"thumb"] count] == 1 && ![data[@"thumb"][0] isEqualToString:@""]) {
            NSString* cellid = @"tcell2";
            _tablecell2 = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
            if (!_tablecell2) {
                _tablecell2 = [[enjoyIndexTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            _tablecell2.title.text = data[@"title"];
            _tablecell2.site.text = data[@"site"];
            _tablecell2.hot.hidden = [data[@"hot"] intValue] == 1 ? NO : YES;
            _tablecell2.read.text = [NSString stringWithFormat:@"%@ 阅读",data[@"read_num"]];
            [_tablecell2.imgview1 sd_setImageWithURL:[NSURL URLWithString:data[@"thumb"][0]]];
            return _tablecell2;
        }else{
            NSString* cellid = @"tcell1";
            _tablecell1 = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
            if (!_tablecell1) {
                _tablecell1 = [[enjoyIndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            _tablecell1.title.text = data[@"title"];
            _tablecell1.site.text = data[@"site"];
            _tablecell1.time.text = data[@"datetime"];
            _tablecell1.hot.hidden = [data[@"hot"] intValue] == 1 ? NO : YES;
            _tablecell1.read.text = [NSString stringWithFormat:@"%@ 阅读",data[@"read_num"]];
            if ([data[@"thumb"] count] >= 3) {
                [_tablecell1.imgview1 sd_setImageWithURL:[NSURL URLWithString:data[@"thumb"][0]]];
                [_tablecell1.imgview2 sd_setImageWithURL:[NSURL URLWithString:data[@"thumb"][1]]];
                [_tablecell1.imgview3 sd_setImageWithURL:[NSURL URLWithString:data[@"thumb"][2]]];
            }else{
                [_tablecell1.imgview1 removeFromSuperview];
                [_tablecell1.imgview2 removeFromSuperview];
                [_tablecell1.imgview3 removeFromSuperview];
            }
            return _tablecell1;
        }
    }else{
        return [[UITableViewCell alloc] init];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArray.count;
}

-(void)initData{
    [SVProgressHUD showWithStatus:@"亲，请稍等～"];
    //首页banner
    [_session GET:@"http://198.181.47.194/ios/index/banner/" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_headerBannerArray removeAllObjects];
        if ([responseObject[@"status"] intValue] < 100) {
            [SVProgressHUD showErrorWithStatus:@"服务器失效"];
        }else{
            for (NSDictionary* dic in responseObject[@"data"]) {
                [_headerBannerArray addObject:dic];
            }
            [_icarousel reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"banner加载失败"];
    }];
    [_session GET:@"http://198.181.47.194/ios/index/activity" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_activityArray removeAllObjects];
        if ([responseObject[@"status"] intValue] < 100) {
            [SVProgressHUD showErrorWithStatus:@"服务器失效"];
        }else{
            for (NSDictionary* dic in responseObject[@"data"]) {
                [_activityArray addObject:dic];
            }
            [_icarouselActivity reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"活动加载失败"];
    }];
    //首页状态栏
    NSArray* arr1 = [[NSArray alloc] initWithObjects:@"惠州事",@"吃喝玩",@"妈妈派",@"买房",@"装修", nil];
    NSArray* arr2 = [[NSArray alloc] initWithObjects:@"车生活",@"兴趣圈",@"聊心事",@"西子卡",@"全部圈子", nil];
    _tabArray = [[NSMutableArray alloc] initWithObjects:arr1,arr2, nil];
    //首页新闻
    _pageNews = 0;
    [self refreshNews];
    [SVProgressHUD dismissWithDelay:0.5];
}

-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option) {
        case iCarouselOptionWrap:
            return YES;
            break;
        case iCarouselOptionSpacing:
            if (carousel.tag == 101) {
                return 1.05;
            }else{
                return value;
            }
            break;
        default:
            break;
    }
    return value;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView* imgview = [[UIImageView alloc] init];
    if (carousel.tag == 100) {
        imgview.frame = CGRectMake(0, 0, CGRectGetWidth(_headerBanner.frame), CGRectGetHeight(_headerBanner.frame));
        NSString* str = [NSString stringWithFormat:@"http://198.181.47.194/uploads/%@",_headerBannerArray[index][@"thumb"]];
        imgview.contentMode = UIViewContentModeScaleToFill;
        [imgview sd_setImageWithURL:[NSURL URLWithString:str]];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_headerBanner.frame) - 30 - 20, CGRectGetWidth(_headerBanner.frame) - 10, 20)];
        label.text = _headerBannerArray[index][@"title"];
        label.textColor = [UIColor whiteColor];
        [imgview addSubview:label];
    }else if (carousel.tag == 101){
        imgview.frame = CGRectMake(60, 0, CGRectGetWidth(_activityScroll.frame) - 120, CGRectGetHeight(_activityScroll.frame));
        NSString* str = [NSString stringWithFormat:@"http://198.181.47.194/uploads/%@",_activityArray[index][@"thumb"]];
        [imgview sd_setImageWithURL:[NSURL URLWithString:str]];
        if (![_activityArray[index][@"title"] isKindOfClass:[NSNull class]]) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_activityScroll.frame) - 30, CGRectGetWidth(_activityScroll.frame) - 20, 20)];
            label.text = _activityArray[index][@"title"];
            label.textColor = [UIColor whiteColor];
            [imgview addSubview:label];
        }
    }
    return imgview;
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if (carousel.tag == 100) {
        _page.numberOfPages = _headerBannerArray.count;
        return _headerBannerArray.count;
    }else{
        return _activityArray.count;
    }
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if(carousel.tag == 100) _page.currentPage = carousel.currentItemIndex;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(bannerTimer) userInfo:nil repeats:YES];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.fd_prefersNavigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)bannerTimer{
    [_icarousel scrollByNumberOfItems:1 duration:0.8];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    UIViewController* enjoySecondSearch = [self.storyboard instantiateViewControllerWithIdentifier:@"enjoySecondSearch"];
    [self.navigationController pushViewController:enjoySecondSearch animated:YES];
    return NO;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _activityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"activityColl" forIndexPath:indexPath];
    UIImage* image = [UIImage imageNamed:@"images/indexActivity.png"];
    [_activityCell.mybutton setImage:image forState:UIControlStateNormal];
    [_activityCell.mybutton setTitle:_tabArray[indexPath.section][indexPath.row] forState:UIControlStateNormal];
    CGSize titleSize = _activityCell.mybutton.titleLabel.bounds.size;
    CGSize imageSize = _activityCell.mybutton.imageView.bounds.size;
    [_activityCell.mybutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleSize.height+10, -(titleSize.width+5))];
    [_activityCell.mybutton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+10, -(imageSize.width + 5), 0, 0)];
    return _activityCell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
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
