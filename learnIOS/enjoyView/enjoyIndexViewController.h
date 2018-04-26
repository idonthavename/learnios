//
//  enjoyIndexViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/8.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "enjoySecondViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <iCarousel.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "enjoyIndexCollectionViewCell.h"
#import "enjoyIndexTableViewCell.h"
#import "enjoyIndexTableViewCell2.h"

@interface enjoyIndexViewController : UIViewController<UISearchBarDelegate,iCarouselDelegate,iCarouselDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) IBOutlet UIScrollView *headerBanner;
@property (strong, nonatomic) IBOutlet UIPageControl *page;
@property (strong, nonatomic) IBOutlet UICollectionView *activityCollection;
@property (strong, nonatomic) IBOutlet UIScrollView *activityScroll;
@property (strong, nonatomic) IBOutlet UITableView *tablewView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewConst;
@property (strong, nonatomic) enjoySecondViewController* secondView;
@property (strong, nonatomic) AFHTTPSessionManager* session;
@property (strong, nonatomic) NSMutableArray* headerBannerArray;
@property (strong, nonatomic) NSMutableArray* activityArray;
@property (strong, nonatomic) iCarousel* icarousel;
@property (strong, nonatomic) iCarousel* icarouselActivity;
@property (strong, nonatomic) NSMutableArray* tabArray;
@property (strong, nonatomic) NSMutableArray* newsArray;
@property (weak, nonatomic) NSTimer* timer;
@property (weak, nonatomic) enjoyIndexCollectionViewCell* activityCell;
@property (strong, nonatomic) enjoyIndexTableViewCell* tablecell1;
@property (strong, nonatomic) enjoyIndexTableViewCell2* tablecell2;
@property(assign,nonatomic) int pageNews;
@end
