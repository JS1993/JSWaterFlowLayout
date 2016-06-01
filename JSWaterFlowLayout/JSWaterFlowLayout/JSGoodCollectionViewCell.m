//
//  JSGoodCollectionViewCell.m
//  JSWaterFlowLayout
//
//  Created by  江苏 on 16/6/1.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSGoodCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface JSGoodCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation JSGoodCollectionViewCell

-(void)setGood:(JSGoodModel *)good{
    _good=good;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:good.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = good.price;
}


@end
