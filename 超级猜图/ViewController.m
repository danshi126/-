//
//  ViewController.m
//  超级猜图
//
//  Created by apple on 15/5/4.
//  Copyright (c) 2015年 worldelite. All rights reserved.
//

#import "ViewController.h"
#import "WPQuestion.h"

#define kButtonWidth        35
#define kButtonHeight       35
#define kButtonMargin       10
#define kTotalCol           7


@interface ViewController ()
//显示图片
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
//图片提示文字
@property (weak, nonatomic) IBOutlet UILabel *answer;
//图片序号
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (strong,nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *scroe;

//记录图片放大后信息
@property (strong,nonatomic)  UIButton *conver;
//索引
@property (nonatomic,assign) char index;

@property (weak, nonatomic) IBOutlet UIView *answerView;

@property (weak, nonatomic) IBOutlet UIView *textView;

@property (strong,nonatomic) NSArray *questions;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index = -1;
    self.nextFouction;
    
}

- (NSArray *)questions
{
    if(_questions == nil)
        _questions = [WPQuestion Questions];
    return _questions;
        
}

#pragma mark - 设置图片滤镜
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

#pragma mark - 图片放大与缩小
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

#pragma mark - 设置下一幅图片功能

//下一张图片 按键功能
- (IBAction)nextFouction
{
    self.index++;
    if(self.index == self.questions.count)
    {
        NSLog(@"恭喜通关！！！");
        for(UIButton *but in self.answerView.subviews)
            [but removeTarget:self action:@selector(clickAnswer:) forControlEvents:(UIControlEventTouchUpInside)];
        return;
    }
    WPQuestion *info = self.questions[self.index];
    
    [self crateBasicInfo:info];
    [self WPQuestion:info];
    [self crateOption:info];
    

}

- (void)crateBasicInfo:(WPQuestion *)info
{

    [self.iconButton setImage:[UIImage imageNamed:info.icon] forState:(UIControlStateNormal)];
    [self.num setText:[NSString stringWithFormat:@"%d/%lu",self.index+1,self.questions.count]];
    [self.answer setText:info.title];
    self.nextButton.enabled = ((self.index+1) < self.questions.count);

}

-(void)WPQuestion:(WPQuestion *)info
{
     //答案区按键布局
    NSUInteger length = info.answer.length;
    CGFloat margin = (self.answerView.bounds.size.width - length * kButtonWidth - (length - 1) * kButtonMargin)*0.5;
    for(UIView *view in self.answerView.subviews)
        [view removeFromSuperview];
    for(char i = 0; i < length; i++)
    {
        CGFloat x = margin + (kButtonWidth + kButtonMargin)*i;
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, kButtonHeight, kButtonWidth)];
        [but setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:(UIControlStateNormal)];
        [but setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:(UIControlStateHighlighted)];
        [but setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [self.answerView addSubview:but];
        [but addTarget:self action:@selector(clickAnswer:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)crateOption:(WPQuestion *)info
{
    char i;
    if(self.textView.subviews.count != info.options.count)
    {
        CGFloat x,y;
        //答案文字备选
        int margin = (self.textView.bounds.size.width - kTotalCol * kButtonWidth - (kTotalCol - 1) * kButtonMargin) * 0.5;
        for(i = 0; i < info.options.count; i++)
        {
            int row = i / kTotalCol;    //行
            int col = i % kTotalCol;    //列
            y = row * (kButtonMargin + kButtonWidth);
            x = margin + col * ((kButtonMargin + kButtonWidth));
            UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(x, y, kButtonWidth, kButtonHeight)];
            [bu setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:(UIControlStateNormal)];
            [bu setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        
            [bu setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
            [self.textView addSubview:bu];
            [bu addTarget:self action:@selector(clickOption:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    i = 0;
    for(UIButton *but in self.textView.subviews)
    {
        but.hidden = NO;
        [but setTitle:info.options[i++] forState:(UIControlStateNormal)];
    }
}


#pragma mark - 侯选区与答案判断
- (IBAction) clickOption:(UIButton *)but
{
    if(but == nil)
        return;
    
    UIButton *answerBut = [self fristAnswerBut];
    if(answerBut == nil)
        return;
    [answerBut setTitle:but.currentTitle forState:(UIControlStateNormal)];
    but.hidden = YES;
    
    UIButton* ans = [self fristAnswerBut];
    if(ans == nil)
    {//答案填满了
        [self myJudge];
    }
}

- (void)myJudge
{
    NSMutableString *result = [NSMutableString string];
    for(UIButton *but in self.answerView.subviews)
    {
        [result appendString:but.currentTitle];
    }
    
    if([result isEqualToString:[self.questions[_index] answer]])
    {//答案正确
        [self SetButColor:[UIColor yellowColor]];
    //    [self nextFouction];
        [self performSelector:@selector(nextFouction) withObject:nil afterDelay:0.5];
    }
    else
    {
        [self SetButColor:[UIColor redColor]];
    }
}

- (UIButton *)fristAnswerBut
{

    for(UIButton *but in self.answerView.subviews)
    {
        if(but.currentTitle.length == 0)
            return but;
    }
    return nil;
}

- (void)SetButColor:(UIColor *)color
{
    for(UIButton *but in self.answerView.subviews)
    {
        [but setTitleColor:color forState:(UIControlStateNormal)];
    }
}

- (void)clickAnswer:(UIButton *)but
{
    if(but == nil)
        return;
    for(UIButton *b in self.textView.subviews)
    {
        if(([b.currentTitle isEqualToString:but.currentTitle]) && (b.hidden == YES))
        {
            b.hidden = NO;
            break;
        }
            
    }
    [but setTitle:@"" forState:(UIControlStateNormal)];
}


#pragma mark - 提示按钮操作
- (IBAction)clickPrompt
{
    for(UIButton *but in self.answerView.subviews)
    {
        [self clickAnswer:but];
    }
    WPQuestion *info = self.questions[[self index]];
    NSString *fristNum = [info.answer substringToIndex:1];
    NSLog(@"%@",fristNum);
    
    for(UIButton *b in self.textView.subviews)
    {
     //   NSLog(@"%@",b);
        if(([b.currentTitle isEqualToString:fristNum]))
        {
            [self clickOption:b];
            break;
        }
    }
    
}


#pragma mark - 分数加减
- (void)Score_Add:(int)num
{
    ;
}

@end
