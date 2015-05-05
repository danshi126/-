//
//  WPQuestion.h
//  超级猜图
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 worldelite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPQuestion : NSObject

@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *options;


- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) QuestionWithDict:(NSDictionary *)dict;
+ (NSArray *)Questions;

@end
