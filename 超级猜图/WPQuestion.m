//
//  WPQuestion.m
//  超级猜图
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 worldelite. All rights reserved.
//

#import "WPQuestion.h"

@implementation WPQuestion

- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self != nil)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype) QuestionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)Questions
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for(NSDictionary *dict in array)
    {
        [arrayM addObject:[self QuestionWithDict:dict]];
    }
    return arrayM;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.answer,self.icon,self.title,self.options];
}
@end
