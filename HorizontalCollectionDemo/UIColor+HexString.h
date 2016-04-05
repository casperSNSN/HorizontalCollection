//
//  UIColor+HexString.h
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
//颜色值16进制转化
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
