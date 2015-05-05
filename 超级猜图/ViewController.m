//
//  ViewController.m
//  超级猜图
//
//  Created by apple on 15/5/4.
//  Copyright (c) 2015年 worldelite. All rights reserved.
//

#import "ViewController.h"
#import "WPQuestion.h"

@interface ViewController ()
//显示图片
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
//图片提示文字
@property (weak, nonatomic) IBOutlet UILabel *answer;
//图片序号
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (strong,nonatomic) IBOutlet UIButton *nextButton;

//记录图片放大后信息
@property (strong,nonatomic)  UIButton *conver;
//索引
@property (nonatomic,assign) char index;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index = -1;
    self.nextFouction;
    
}

//图片滤镜
- (UIButton *)conver
{
    if(_conver == nil)
    {
        _conver = [[UIButton alloc] initWithFrame:self.view.bounds];
        _conver.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.view addSubview:_conver];
        _conver.alpha = 0.0;
        [_conver addTarget:self action:@selector(BigImage:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _conver;
}

/**
 放大缩小显示图片
*/
- (IBAction)BigImage:(UIButton *)but
{
    
    if(self.conver.alpha == 0.0)
    {//放大
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = self.view.bounds.size.height - w;
        h = h * 0.5;
        [self.view bringSubviewToFront:self.iconButton];
    
        [UIView animateWithDuration:1.0f animations:^{
            self.iconButton.frame = CGRectMake(0, h, w, w);
            self.conver.alpha = 1.0;
        }];
    }
    else
    {//缩小
        [UIView animateWithDuration:1.0f animations:^{
            self.iconButton.frame = CGRectMake(100, 100, 120, 120);
            self.conver.alpha = 0.0;
        }];
    }

    
}

//设置手机信息栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//下一张图片 按键功能
- (IBAction)nextFouction
{
    NSArray *question = [WPQuestion Questions];
    self.index++;
    WPQuestion *info = question[self.index];
    [self.iconButton setImage:[UIImage imageNamed:info.icon] forState:(UIControlStateNormal)];
    [self.num setText:[NSString stringWithFormat:@"%d/%lu",self.index+1,(unsigned long)question.count]];
    [self.answer setText:info.title];
    
    self.nextButton.enabled = ((self.index+1) < question.count);
}

@end
