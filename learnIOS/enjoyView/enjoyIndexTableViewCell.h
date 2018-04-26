//
//  enjoyIndexTableViewCell.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/4/19.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface enjoyIndexTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *imgview1;
@property (strong, nonatomic) IBOutlet UIImageView *imgview2;
@property (strong, nonatomic) IBOutlet UIImageView *imgview3;
@property (strong, nonatomic) IBOutlet UILabel *site;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *hot;
@property (strong, nonatomic) IBOutlet UILabel *read;

@end
