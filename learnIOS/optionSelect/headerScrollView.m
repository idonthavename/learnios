//
//  headerScrollView.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/28.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "headerScrollView.h"

@implementation headerScrollView

-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
