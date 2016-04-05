
//
//  MyCollectionViewCell.m
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIView+Extension.h"
#import "UIColor+HexString.h"
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)
#define imageScale (1000.00f/1430.00f)  //图片宽高比
#define zoomScale 1.08

@interface MyCollectionViewCell ()

@end
@implementation MyCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.masksToBounds = NO;
        [self.contentView addSubview:self.imageView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.contentView.layer.shadowColor = [[UIColor colorWithHexString:@"999999"] CGColor];
        self.contentView.layer.shadowOpacity = 0.8;//透明度
        self.contentView.layer.shadowRadius = 2;//半径
        self.contentView.layer.shadowOffset = CGSizeMake(1, 3);
        self.contentView.layer.cornerRadius = 4;
        
    }
    return self;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        
        //UIcollectionView的高度为ksMainHeight-别的控件加空白的高度  减的数越大 图片越小
        CGFloat collectionVHeight = KScreenHeight-260;
        CGFloat imgWidth = collectionVHeight/zoomScale*imageScale;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, collectionVHeight/zoomScale)];
        _imageView.center = self.contentView.center;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [_imageView setClipsToBounds:YES];
        _imageView.layer.cornerRadius = 4;
    }
    return _imageView;
}


@end
