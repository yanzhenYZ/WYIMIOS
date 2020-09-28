//
//  ArtLoginBaseView.h
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtLoginInputView.h"
//#import "ArtAppLoginConfig.h"


typedef NS_ENUM(NSUInteger, EArtLoginType) {
    EArtLoginTypePassword,//密码
    EArtLoginTypeCheckCode,//验证密码
//    EArtLoginTypeModify,//修改密码
    EArtLoginTypeRegister,//注册
};

typedef NS_ENUM(NSUInteger, EArtRegisterType) {
    EArtRegisterTypeDefault,//注册
    EArtRegisterTypeAD,//广告注册
    EArtRegisterTypeLogin,//直接跳转到登录
};

@interface ArtLoginBaseView : UIView
//@property (nonatomic, assign) ArtLoginUserIdentityType identity;
@property (nonatomic, strong) ArtLoginInputView *mobileInputView;
@property (nonatomic, strong) UIButton *enterBtn;
//仅enterBtn和获取验证码按钮
+ (void)setupLRButtonState:(UIButton *)button;
@end
