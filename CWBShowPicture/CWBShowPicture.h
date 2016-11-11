//
//  CWBShowPicture.h
//  CWBShowPicture
//
//  Created by BBC on 15/9/6.
//  Copyright (c) 2015年 陈伟滨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWBShowPicture : UIView
@property(nonatomic,strong)      UIControl     * control;;
@property(nonatomic,assign)      int             allcount;
@property (nonatomic,copy) void(^sendClickIndexpath)(NSInteger index);//用block传值，

-(id)initWithImage:(NSString *)imgUrl WithMessage:(NSString *)message WithTitle:(NSString *)title WithPrice:(NSString *)price;

-(void)show;
@end
