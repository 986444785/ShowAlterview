//
//  ViewController.m
//  CWBShowPicture
//
//  Created by BBC on 15/9/6.
//  Copyright (c) 2015年 陈伟滨. All rights reserved.
//

#import "ViewController.h"
#import "CWBShowPicture.h"
@interface ViewController ()

@end 

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"click me !" forState:UIControlStateNormal];
    [self.view addSubview:btn];
 
}

-(void)btnclick
{
    CWBShowPicture * cwb = [[CWBShowPicture alloc]initWithImage:@"15.jpg" WithMessage:@"图片仅供参考，请以实物为准" WithTitle:@"this is a cat" WithPrice:@"15"];
    cwb.sendClickIndexpath = ^(NSInteger index){
        NSLog(@"add  or  reduce %ld",(long)index);
    };
    [cwb show];
}
 
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
