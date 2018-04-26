//
//  UIImage+UIImage_Scale.h
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/31.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Scale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
@end
