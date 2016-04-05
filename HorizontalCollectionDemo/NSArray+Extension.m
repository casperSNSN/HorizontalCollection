
//
//  NSArray+Extension.m
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (nullable id)safetyObjectAtIndex:(NSUInteger)index
{
    if (!self || self.count == 0 || self.count <= index) {
        return nil;
    }
    
    return self[index];
}

- (nullable id)randomObject
{
    if (!self || ![self isKindOfClass:[NSArray class]] || self.count == 0) {
        return nil;
    }
    int i = arc4random()%self.count;
    return [self safetyObjectAtIndex:i];
}

@end
