//
//  MyCollectionViewFlowLayout.h
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCollectionViewFlowLayoutDelegate <NSObject>

-(void)collectionViewDidScrollTo:(NSInteger)index;

@end
@interface MyCollectionViewFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,weak)id<MyCollectionViewFlowLayoutDelegate>delegate;

//透明度是否打开，默认NO，不打开
@property(nonatomic,assign)BOOL isAlpha;

@end
