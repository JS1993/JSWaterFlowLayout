//
//  ViewController.m
//  JSWaterFlowLayout
//
//  Created by  江苏 on 16/6/1.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "JSWaterCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionView;

@end

@implementation ViewController



/*collectionView懒加载*/
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        
        JSWaterCollectionViewLayout* waterFlowLayout=[[JSWaterCollectionViewLayout alloc]init];
        
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterFlowLayout];
//        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

static NSString* indentifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:indentifier];
}


#pragma mark--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 70;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
 
    return cell;
}

@end
