//
//  JSWaterCollectionViewLayout.m
//  JSWaterFlowLayout
//
//  Created by  江苏 on 16/6/1.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSWaterCollectionViewLayout.h"

static NSInteger const colCount=3;
static CGFloat const defaultMargin=10;
static const UIEdgeInsets  defaultEdge={10,10,10,10};

@interface JSWaterCollectionViewLayout()

@property(strong,nonatomic)NSMutableArray* colHeights;

@property(strong,nonatomic)NSMutableArray* attrsArr;


@end

@implementation JSWaterCollectionViewLayout



/*最小高度的列号*/
-(NSMutableArray *)colHeights
{
    if (_colHeights==nil) {
        _colHeights=[NSMutableArray array];
    }
    return _colHeights;
}


/*属性数组*/
-(NSMutableArray *)attrsArr
{
    if (_attrsArr==nil) {
        _attrsArr=[NSMutableArray array];
    }
    return _attrsArr;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    //做一次清空操作,清除以前计算出来的所有高度
    [self.attrsArr removeAllObjects];
    
    //每次初始化，清空依次计算的所有高度
    [self.colHeights removeAllObjects];
    
    for (NSInteger i=0; i<colCount; i++) {
        [self.colHeights addObject:@(defaultEdge.top)];
    }
    
    //开始创建每一个cell对应的布局属性
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath* indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        
       UICollectionViewLayoutAttributes* attrs= [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArr addObject:attrs];
    }
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
 
    return self.attrsArr;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes* attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width=(self.collectionView.bounds.size.width-defaultMargin*(colCount+1))/colCount;
    
    JSGoodModel* good=self.goods[indexPath.item];
    
    
    CGFloat height=good.h/good.w*width;
    
    //找出最短的那一行
    NSInteger minHeightCol = 0;
    //记录最短那一行的高度
    CGFloat minColHeight=[self.colHeights[0] doubleValue];
    for (NSInteger i=1; i<colCount; i++) {
        
        CGFloat colHeight=[self.colHeights[i] doubleValue];
        
        if (colHeight<minColHeight) {
            
            minColHeight=colHeight;
            minHeightCol=i;
            
        }
    }
    
    CGFloat x=defaultMargin+(width+defaultMargin)*minHeightCol;
    CGFloat y=minColHeight;
    
    if (y!=defaultMargin) {
        y+=defaultMargin;
    }
    
    attrs.frame=CGRectMake(x, y , width , height);
    
    //更新最短那列的高度
    self.colHeights[minHeightCol]=@(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

-(CGSize)collectionViewContentSize{
    
    //记录最高那一行的高度
    CGFloat maxColHeight=[self.colHeights[0] doubleValue];
    for (NSInteger i=1; i<colCount; i++) {
        CGFloat colHeight=[self.colHeights[i] doubleValue];
        if (colHeight>maxColHeight) {
            maxColHeight=colHeight;;
        }
    }
    
    return CGSizeMake(0, maxColHeight+defaultMargin);
}
@end
