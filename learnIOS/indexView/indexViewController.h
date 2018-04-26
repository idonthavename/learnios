//
//  indexViewController.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/25.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
#import "indexCollectionViewCell.h"
#import "tjgdCollectionViewCell.h"
#import "tjgdCollectionReusableView.h"

@interface indexViewController : UIViewController<UIScrollViewDelegate,iCarouselDelegate,iCarouselDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionV;
@property (strong, nonatomic) IBOutlet UICollectionView *tjgdCollectionV;

@property(retain,nonatomic) NSTimer* bannerTimer;
@property(strong,nonatomic) iCarousel* iCarousel;
@property(strong,nonatomic) NSMutableArray* imageArray;
@property(assign,nonatomic) CGFloat scrollWidth;
@property(assign,nonatomic) CGFloat scrollHeight;
@property(strong,nonatomic) indexCollectionViewCell* bannerCell;
@property(strong,nonatomic) tjgdCollectionViewCell* tjgdCell;
@property(strong,nonatomic) tjgdCollectionReusableView* tjgdReusableV;
@end
