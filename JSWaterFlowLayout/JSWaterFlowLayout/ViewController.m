//
//  ViewController.m
//  JSWaterFlowLayout
//
//  Created by  江苏 on 16/6/1.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "JSWaterCollectionViewLayout.h"
#import "JSGoodModel.h"
#import "JSGoodCollectionViewCell.h"

#import <MJRefresh.h>
#import <MJExtension.h>

@interface ViewController ()<UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionView;

/*商品数组*/
@property(strong,nonatomic)NSMutableArray* goods;

@property(strong,nonatomic)JSWaterCollectionViewLayout*  waterFlowLayout;

@end

@implementation ViewController


/*商品数组懒加载*/
-(NSMutableArray *)goods
{
    if (_goods==nil) {
        _goods=[NSMutableArray array];
    }
    return _goods;
}


/*collectionView懒加载*/
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        
        self.waterFlowLayout=[[JSWaterCollectionViewLayout alloc]init];
        
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.waterFlowLayout];
//        _collectionView.delegate=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.dataSource=self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

static NSString* indentifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    
    [self setUpRefresh];
}


-(void)setUpCollectionView{
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JSGoodCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:indentifier];
    
}

-(void)setUpRefresh{
    
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
     [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer.hidden=YES;
    
}

-(void)loadNew{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         NSArray* arr=[JSGoodModel mj_objectArrayWithFilename:@"goods.plist"];
        
        [self.goods removeAllObjects];
        
        [self.goods addObjectsFromArray:arr];
        
        self.waterFlowLayout.goods=self.goods;
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
    
}

-(void)loadMore{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSArray* arr=[JSGoodModel mj_objectArrayWithFilename:@"goods.plist"];
        
        [self.goods addObjectsFromArray:arr];
        
        self.waterFlowLayout.goods=self.goods;
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
    });
    
}
#pragma mark--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    self.collectionView.mj_footer.hidden=self.goods.count==0;
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JSGoodCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    
    cell.good=self.goods[indexPath.item];
 
    return cell;
}

@end
