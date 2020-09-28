//
//  ArtLoginPasswordView.m
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginPasswordView.h"
#import <Masonry.h>
//#import "NSMutableAttributedString+LL.h"
//#import "NSMutableDictionary+LL.h"
#import "UIColor+Art.h"
//#import "UIImage+ArtLoginAndRegister.h"
#import "MSBContant.h"

@interface ArtLoginPasswordView()
@end
@implementation ArtLoginPasswordView

- (instancetype)init
{
    self = [super init];
    [self makeUI];
    return self;
}

- (void)makeUI
{
    [self addSubview:self.mobileInputView];
    [self.mobileInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(kArtLRScaleViewHeight));
    }];
    
    [self addSubview:self.passwordInputView];
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mobileInputView.mas_bottom)
        .offset(kArtLRScaleViewSpacing);
        make.height.equalTo(self.mobileInputView);
    }];
    
    [self addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.top.equalTo(self.passwordInputView.mas_bottom)
        .offset(30 * kArtLRScaleFactor);
        make.height.equalTo(@(kArtLRScaleButtonHeight));
    }];
    
    [self configureEnterBtn];
    [self configureMobileInputView];
}

- (void)configureEnterBtn
{
    [self.enterBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.enterBtn setTitle:@"登录" forState:UIControlStateSelected];
}

- (void)configureMobileInputView
{
    self.mobileInputView.textField.keyboardType = UIKeyboardTypeNumberPad;
}
#pragma mark - Lazy
- (ArtLoginInputView *)passwordInputView
{
    if(!_passwordInputView){
        _passwordInputView = [[ArtLoginInputView alloc] initWithType:EArtInputViewTypeText];
        _passwordInputView.iconImage = [UIImage imageNamed:@"art_lr_pwd"];
//        NSMutableAttributedString *attribute = [NSMutableAttributedString ll_makeAttributeString:@"请输入密码" attribute:^(NSMutableDictionary *attributes) {
//            attributes.ll_systemFontSize(kArtLRScaleFontSize).ll_color([UIColor colorWithHexString:@"BDBDBD"]);
//        }];
        _passwordInputView.textField.placeholder = @"请输入密码";
        //attributedPlaceholder = [attribute copy];
        _passwordInputView.textField.secureTextEntry = YES;
        _passwordInputView.textField.clearsOnBeginEditing = YES;
    }
    return _passwordInputView;
}
@end
