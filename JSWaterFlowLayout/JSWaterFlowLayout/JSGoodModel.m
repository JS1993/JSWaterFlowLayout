//
//  JSGoodModel.m
//  JSWaterFlowLayout
//
//  Created by  江苏 on 16/6/1.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSGoodModel.h"

@implementation JSGoodModel

-(instancetype)initWithDict:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)JSGoodModelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}

+(NSArray*)GoodModel{
    NSMutableArray* arrM=[NSMutableArray array];
    NSArray* arr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"goods" ofType:@"plist"]];
    for (NSDictionary* dic in arr ) {
        [arrM addObject:[self JSGoodModelWithDict:dic]];
    }
    return arrM;
}

@end
