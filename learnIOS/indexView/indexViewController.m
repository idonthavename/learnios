//
//  indexViewController.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/25.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "indexViewController.h"
#import <Masonry.h>

#define JianGe 25
#define GeShu 4
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define Screenheight ([UIScreen mainScreen].bounds.size.height)

@interface indexViewController ()

@end

@implementation indexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_scrollView layoutIfNeeded];
    _scrollWidth = _scrollView.frame.size.width;
    _scrollHeight = _scrollView.frame.size.height;
    _imageArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    _scrollView.contentSize = CGSizeMake(_scrollWidth * _imageArray.count, _scrollHeight);
    _scrollView.delegate = self;
    
    _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, _scrollWidth, _scrollHeight)];
    _iCarousel.type = iCarouselTypeLinear;
    _iCarousel.pagingEnabled = YES;
    _iCarousel.delegate = self;
    _iCarousel.dataSource = self;
    [_scrollView addSubview:_iCarousel];
    [self startBannerTimer];
    
    UICollectionViewFlowLayout* bannerLayout = [[UICollectionViewFlowLayout alloc] init];
    bannerLayout.itemSize = CGSizeMake((ScreenWidth - JianGe*(GeShu+1)) / GeShu, 80);
    bannerLayout.minimumInteritemSpacing = JianGe;
    _myCollectionV.collectionViewLayout = bannerLayout;
    
    UICollectionViewFlowLayout* tjgdLayout = [[UICollectionViewFlowLayout alloc] init];
    tjgdLayout.itemSize = CGSizeMake(ScreenWidth/3 - 3, 170);
    tjgdLayout.minimumInteritemSpacing = 3;
    tjgdLayout.minimumLineSpacing = 20;
    _tjgdCollectionV.collectionViewLayout = tjgdLayout;
    
}

-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option) {
        case iCarouselOptionWrap:
            return YES;
            break;
        default:
            break;
    }
    return value;
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _imageArray.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView* imageview = [[UIImageView alloc] init];
    imageview.frame = CGRectMake(0, 0, _scrollWidth, _scrollHeight);
    NSString* imageName = [NSString stringWithFormat:@"images/banner_%@.jpeg",_imageArray[index]];
    imageview.image = [UIImage imageNamed:imageName];
    return imageview;
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pageControl.currentPage = carousel.currentItemIndex;
}

-(void)startBannerTimer{
    __weak __typeof(self)weakSelf = self;
    if (@available(iOS 10.0, *)) {
        _bannerTimer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf.iCarousel scrollByNumberOfItems:1 duration:0.8];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (collectionView.tag) {
        case 1:
            return 4;
            break;
        case 2 :
            return 6;
            break;
        default:
            break;
    }
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (collectionView.tag) {
        case 1:{
            _bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
            NSArray* titleArray = [NSArray arrayWithObjects:@"私人FM",@"每日推荐",@"歌单",@"排行榜", nil];
            _bannerCell.mylabel.text = titleArray[indexPath.row];
            NSString* imageName = [NSString stringWithFormat:@"images/cell%ld.png",(long)indexPath.row];
            _bannerCell.myimage.image = [UIImage imageNamed:imageName];
            return _bannerCell;
            break;
        }
        case 2:{
            _tjgdCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tjgdCell" forIndexPath:indexPath];
            NSArray* contentArray = @[
                                    @[@"华语速爆新歌",@"1.2亿"],
                                    @[@"春风熏暖 红情绿意不如你",@"36万"],
                                    @[@"Best Club Sounds Remixs/Hype",@"113万"],
                                    @[@"High fire!【电音】",@"31万"],
                                    @[@"Future Bass Records/Chill Trap Records",@"27万"],
                                    @[@"夜店文化 优质EDM",@"18万"]
                                    ];
            _tjgdCell.mylabel.text = contentArray[indexPath.row][0];
            _tjgdCell.numlabel.text = contentArray[indexPath.row][1];
            NSString* imagename = [NSString stringWithFormat:@"images/tjgd%ld.jpg",indexPath.row];
            _tjgdCell.myimage.image = [UIImage imageNamed:imagename];
            return _tjgdCell;
            break;
        }
        default:
            break;
    }
    return _bannerCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (collectionView.tag) {
        case 2:
            return CGSizeMake(50, 50);
            break;
        default:
            break;
    }
    return CGSizeMake(0, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    switch (collectionView.tag) {
        case 2:
            _tjgdReusableV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"tjgdHeader" forIndexPath:indexPath];
            [_tjgdReusableV.mybutton setTitle:@"推荐歌单  ➾" forState:UIControlStateNormal];
            return _tjgdReusableV;
            break;
        default:
            break;
    }
    return _tjgdReusableV;
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
