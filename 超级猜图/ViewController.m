//
//  ViewController.m
//  超级猜图
//
//  Created by apple on 15/5/4.
//  Copyright (c) 2015年 worldelite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@property (strong,nonatomic) UIButton *conver;

@end

@implementation ViewController


- (UIButton *)conver
{
    if(_conver == nil)
    {
        _conver = [[UIButton alloc] initWithFrame:self.view.bounds];
        _conver.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.view addSubview:_conver];
        _conver.alpha = 0.0;
        [_conver addTarget:self action:@selector(smallImage:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _conver;
}

- (IBAction)BigImage:(UIButton *)but
{
    [self conver];
    
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height - w;
    h = h * 0.5;
    
    [self.view bringSubviewToFront:self.iconButton];
    
    [UIView animateWithDuration:1.0f animations:^{
        self.iconButton.frame = CGRectMake(0, h, w, w);
        self.conver.alpha = 1.0;
    }];
    
    
    
}


- (void)smallImage:(UIButton *)but
{
    [UIView animateWithDuration:1.0f animations:^{
        self.iconButton.frame = CGRectMake(100, 100, 120, 120);
        but.alpha = 0.0;
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
