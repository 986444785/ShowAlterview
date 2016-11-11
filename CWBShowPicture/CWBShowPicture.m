//
//  CWBShowPicture.m
//  CWBShowPicture
//
//  Created by BBC on 15/9/6.
//  Copyright (c) 2015年 陈伟滨. All rights reserved.
//

#import "CWBShowPicture.h"

#define kAlertWidth 280.0f
#define kAlertHeight 300.0f
#define kAlert_bottom_Height  100.0f
@implementation CWBShowPicture


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self ;
}

-(id)initWithImage:(NSString *)imgUrl WithMessage:(NSString *)message WithTitle:(NSString *)title WithPrice:(NSString *)price
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds  = YES ;
        [self setUIWithImage:imgUrl WithMessage:message WithTitle:title WithPrice:price];

    }
    return self ;
}
 
-(void)setUIWithImage:(NSString *)imgUrl WithMessage:(NSString *)message WithTitle:(NSString *)title WithPrice:(NSString *)price

{
    UIImageView * logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight-kAlert_bottom_Height)];
    logoImgView.image = [UIImage imageNamed:imgUrl];
    logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    logoImgView.layer.masksToBounds = YES ;
    [self addSubview:logoImgView];

    UIImageView * blackImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kAlertHeight-kAlert_bottom_Height-25, kAlertWidth, 25)];
    blackImgView.image = [UIImage imageNamed:@"black_mengban_img"];
    [self addSubview:blackImgView];

    UILabel * messageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kAlertHeight-kAlert_bottom_Height-25, kAlertWidth, 25)];
    messageLable.textColor = [UIColor whiteColor];
    messageLable.font = [UIFont systemFontOfSize:12];
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.text = message ;
    [self addSubview:messageLable];




    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kAlertHeight-kAlert_bottom_Height, kAlertWidth, 30)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = title ;
    [self addSubview:titleLable];

    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(kAlertWidth-35, 5 , 30, 30);
    [cancleBtn addTarget:self action:@selector(cancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"restaurant_food_info_dialog_close.png"] forState:UIControlStateNormal];
    [self addSubview:cancleBtn];


    float height2 = kAlertHeight - kAlert_bottom_Height ;
    for (int i = 0; i<2; i++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height2+30+i*30, 40, 30)];
        lab.text = i==0 ? @"价格:" : @"数量:"; // 三目运算
        lab.font = [UIFont systemFontOfSize:12];
        [self addSubview:lab];

        UIButton * actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(50+i*60, height2+60, 25, 25);
        NSString * img = i == 0 ? @"icon_food_decrease_small.png" : @"icon_food_increase_small.png";
        [actionBtn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        actionBtn.tag = 10000+i;
        [actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionBtn];
    }
 
    UILabel * pricelab = [[UILabel alloc]initWithFrame:CGRectMake(50, height2+30, 100, 30)];
    pricelab.text = [NSString stringWithFormat:@"￥%@",price];
    pricelab.font = [UIFont systemFontOfSize:12];
    pricelab.textColor = [UIColor redColor];
    [self addSubview:pricelab];

     UILabel * countLab = [[UILabel alloc]initWithFrame:CGRectMake(75, height2+60, 35, 25)];
    countLab.text = @"0";
    countLab.font = [UIFont systemFontOfSize:12];
    countLab.tag = 40000;
    countLab.textAlignment = NSTextAlignmentCenter ;
    [self addSubview:countLab];

}

#pragma mark --- 加减按钮
-(void)actionBtnClick:(UIButton *)sender
{
    UILabel * countLab = (UILabel *)[self viewWithTag:40000];
    if (sender.tag == 10000) {
        if (_allcount>0) {
            _allcount --;
        }
    }else{
        _allcount ++;
    } 
    countLab.text = [NSString stringWithFormat:@"%d",_allcount];
    _sendClickIndexpath(sender.tag);
}

-(void)cancleBtnclick
{
    //remove self
    [self removeFromSuperview];
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    } 
    UIViewController *topVC = [self appRootViewController];

    if (!_control) {
        _control=[[UIControl alloc]initWithFrame:topVC.view.bounds];
        [_control addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor=[UIColor blackColor];
        _control.alpha = 0.5;
    }
    [topVC.view addSubview:_control];
    
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
 
- (void)removeFromSuperview
{

    [self.control removeFromSuperview];
    self.control = nil ;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);

    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
