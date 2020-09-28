//
//  ArtLoginCheckCodeView.m
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginCheckCodeView.h"
//#import "ArtAppLoginConfig.h"
#import <Masonry.h>
//#import <ArtFoundation/NSMutableAttributedString+LL.h>
//#import "NSMutableDictionary+LL.h"
#import "UIColor+Art.h"
//#import "UIImage+ArtLoginAndRegister.h"
#import "MSBContant.h"

@interface ArtLoginCheckCodeView()

@end
@implementation ArtLoginCheckCodeView


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
    
    [self addSubview:self.checkCodeInputView];
    [self.checkCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@(0));
        make.top.equalTo(self.mobileInputView.mas_bottom).offset(kArtLRScaleViewSpacing);
        make.height.equalTo(self.mobileInputView);
    }];
    
    [self.checkCodeInputView addSubview:self.checkCodeBtn];
    [self.checkCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(6 * kArtLRScaleFactor));
        make.bottom.and.right.equalTo(@(-6 * kArtLRScaleFactor));
        make.width.equalTo(@(108 * kArtLRScaleFactor));
    }];
    
    [self addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.top.equalTo(self.checkCodeInputView.mas_bottom)
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

- (void)resetCheckBtn
{
    self.checkCodeBtn.enabled = YES;
    BOOL isSelected = NO;
    if ([self.mobileInputView.selectionBtn.titleLabel.text isEqualToString:@"+86"]) {
        isSelected = self.mobileInputView.textField.text.length == 11;
    } else {
        isSelected = self.mobileInputView.textField.text.length >= kPhoneNumberMin;
    }
    self.checkCodeBtn.selected = isSelected;
    [self.checkCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.checkCodeBtn setTitle:@"获取验证码" forState:UIControlStateSelected];
}

- (void)checkBtnForCountDown:(NSInteger)aCountDown
{
    self.checkCodeBtn.enabled = NO;
    self.checkCodeBtn.selected = NO;
    NSString *str = [NSString stringWithFormat:@"已发送(%tus)",aCountDown];
    [self.checkCodeBtn setTitle:str forState:UIControlStateNormal];
}

//MARK: lazy


- (ArtLoginInputView *)checkCodeInputView
{
    if(!_checkCodeInputView){
        _checkCodeInputView = [[ArtLoginInputView alloc] initWithType:EArtInputViewTypeText];
        _checkCodeInputView.iconImage = [UIImage imageNamed:@"art_lr_code"];
//        NSMutableAttributedString *attribute = [NSMutableAttributedString ll_makeAttributeString:@"请输入验证码" attribute:^(NSMutableDictionary *attributes) {
//            attributes.ll_systemFontSize(kArtLRScaleFontSize).ll_color([UIColor colorWithHexString:@"BDBDBD"]);
//        }];
        _checkCodeInputView.textField.placeholder = @"请输入验证码";
        //attributedPlaceholder = [attribute copy];
        _checkCodeInputView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _checkCodeInputView;
}

- (UIButton *)checkCodeBtn
{
    if(!_checkCodeBtn){
//        _checkCodeBtn = [ArtGradientRoundedRectButton new];
        _checkCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:kArtLRScaleFontSize];
        [_checkCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _checkCodeBtn;
}
@end
