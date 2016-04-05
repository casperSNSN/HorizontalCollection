//
//  ViewController.m
//  HorizontalCollectionDemo
//
//  Created by 孙宁 on 16/4/5.
//  Copyright © 2016年 孙宁. All rights reserved.
//

#import "ViewController.h"

#import "MyCollectionViewFlowLayout.h"
#import "MyCollectionViewCell.h"

#import "UIColor+HexString.h"
#import "UIView+Extension.h"
#import "NSArray+Extension.h"
#import "DataModel.h"

#define KScreenWidth ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)
#define imageScale (1000.00f/1430.00f)  //图片宽高比
#define lineSpacing 20.00f //itme 间隔
#define zoomScale 1.08 //缩放比例

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,MyCollectionViewFlowLayoutDelegate>
{
    NSMutableArray *dataArray;
    //collectionView高度
    CGFloat collectionVHeight;
    
    NSInteger count;
    
}
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *decLabel;
@property (strong, nonatomic) UICollectionView *collectionV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 5;
    
    //UIcollectionView的高度为ksMainHeight-别的控件加空白的高度  减的数越大 图片越小
    collectionVHeight = KScreenHeight-260;
    dataArray = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.decLabel];
    [self.view addSubview:self.collectionV];
    
    
    for (NSInteger i=0; i<count; i++) {
        
        DataModel *model = [DataModel new];
        model.img = [NSString stringWithFormat:@"%u",arc4random()%5];
        model.title = [NSString stringWithFormat:@"我是第%ld个Cell的title",i];
        model.decs = [NSString stringWithFormat:@"我是第%ld个Cell的描述啊 我是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",i];
        [dataArray addObject:model];
    }
    [self labelText:0];
    [_collectionV reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - Property
- (UICollectionView *)collectionV
{
    if (!_collectionV) {
        
        MyCollectionViewFlowLayout *flow =[[MyCollectionViewFlowLayout alloc]init];
        //1.1.布局item,设置item的大小
        //放大后的item会放大zoomScale倍  所以此处需计算
        flow.itemSize = CGSizeMake(collectionVHeight/zoomScale*imageScale, collectionVHeight/zoomScale);
        flow.isAlpha = YES;
        flow.delegate = self;
        //1.2.设置item的间距离
        flow.minimumLineSpacing = lineSpacing;
        //1.3 设置距离左边的距离
        CGFloat oneX =self.view.center.x -flow.itemSize.width *0.5;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        flow.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        
        //为了把阴影 显示出来 所以_collectionV 高度 +20
        _collectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 72, KScreenWidth, collectionVHeight+20) collectionViewLayout:flow];
        _collectionV.layer.masksToBounds = YES;
        _collectionV.backgroundColor = [UIColor whiteColor];
        //2.设置collectionView属性
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        _collectionV.layer.masksToBounds = YES;
        _collectionV.showsHorizontalScrollIndicator =NO;
        [_collectionV registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionV;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        CGFloat imgWidth = collectionVHeight/zoomScale*imageScale;
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-imgWidth)/2, self.view.height-150, imgWidth, 25)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor=[UIColor colorWithHexString:@"#333333"];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
-(UILabel *)decLabel
{
    if (!_decLabel) {
        _decLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.originX, _titleLabel.bottom+12, _titleLabel.width, 40)];
        _decLabel.textAlignment = NSTextAlignmentCenter;
        _decLabel.numberOfLines = 2;
        _decLabel.textColor = [UIColor lightGrayColor];
        _decLabel.font = [UIFont systemFontOfSize:14];
    }
    return _decLabel;
}
#pragma mark - UICollectionViewDelegate
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DataModel * model = [dataArray safetyObjectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:model.img];
    
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPoint pInView = [self.view convertPoint:collectionView.center toView:collectionView];
    // 获取中间cell的indexPath
    NSIndexPath *indexPathNow = [collectionView indexPathForItemAtPoint:pInView];
    //如果被点击处于中间则进入点击事件,否则,把被点击cell,滑动到中间
    if (indexPath.row == indexPathNow.row) {
        
        NSLog(@"点击了该Cell");
        
    }else{
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
#pragma mark - WJMCollectionViewFlowLayoutDelegate
- (void)collectionViewDidScrollTo:(NSInteger)index
{
    [self labelText:index];
}
- (void)labelText:(NSInteger)dex
{
    DataModel * model = [dataArray safetyObjectAtIndex:dex];
    if (![self.titleLabel.text isEqualToString:model.title]) {
        self.titleLabel.text = model.title;
    }
    if (![self.decLabel.text isEqualToString:model.decs]) {
        self.decLabel.text = model.decs;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
