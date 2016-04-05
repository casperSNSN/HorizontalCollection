//
//  NSArray+Extension.h
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 *  可防止数组越界
 */
- (nullable id)safetyObjectAtIndex:(NSUInteger)index;
/**
 *  随机选择数组中元素
 */
- (nullable id)randomObject;
@end
