//
//  ArtLoginView.m
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginView.h"
//#import "ArtStatisticAnalysisService+extension.h"
#import <Masonry.h>
#import "UIColor+Art.h"
#import <ReactiveCocoa.h>
#import "MSBContant.h"

@interface ArtLoginView()
@property (nonatomic, assign) BOOL isCurrentCK;
@property (nonatomic, strong) UIButton *ckBtn;
@property (nonatomic, strong) UIButton *pwBtn;
@end
@implementation ArtLoginView
- (instancetype)init
{
    self = [super init];
    [self makeUI];
    return self;
}

- (void)makeUI
{
    self.isCurrentCK = YES;
    [self addSubview:self.ckBtn];
    [self.ckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(0.5);
    }];
    
    [self addSubview:self.pwBtn];
    [self.pwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(1.5);
    }];
    
    UIView *vLineView = [UIView new];
//    vLineView.backgroundColor = UIColorFromHexString(@"EDEDED");
    [self addSubview:vLineView];
    [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ckBtn);
        make.centerX.equalTo(self);
        make.width.equalTo(@(1));
        make.height.equalTo(@(30 * kArtLRScaleFactor));
    }];
    
    [self.ckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.top.equalTo(self.ckBtn.mas_bottom)
        .offset(23.5 * kArtLRScaleFactor);
    }];
    
    [self.pwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.top.equalTo(self.ckView);
    }];
    
    @weakify(self);
    [[self.ckBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        @strongify(self);
//        [ArtStatisticAnalysisService event:@"1_4_0_click_ldecode"];
        if(x.selected){return;}
        x.selected = !x.selected;
        self.pwBtn.selected = !x.selected;
        [self showCheckCodeAnimation:x.selected];
    }];
    
    [[self.pwBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        @strongify(self);
//        [ArtStatisticAnalysisService event:@"1_4_0_click_password"];
        if(x.selected){return;}
        x.selected = !x.selected;
        self.ckBtn.selected = !x.selected;
        [self showCheckCodeAnimation:!x.selected];
    }];
    
    [[RACObserve(self, switchToPW) distinctUntilChanged] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue) {
            [self.pwBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        } else {
            [self.ckBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)showCheckCodeAnimation:(BOOL)show
{
    self.isCurrentCK = show;
    [self.ckView endEditing:YES];
    [self.pwView endEditing:YES];
    if (show) {
        self.ckView.mobileInputView.textField.text = self.pwView.mobileInputView.textField.text;
//        [ArtStatisticAnalysisService eventType:EArtEventType_Login_CD];
    } else {
        self.pwView.mobileInputView.textField.text = self.ckView.mobileInputView.textField.text;
//        [ArtStatisticAnalysisService eventType:EArtEventType_Login_PW];
    }
//    [UIView animateWithDuration:0.25 animations:^{
        self.ckView.alpha = show ? 1 : 0;
        self.pwView.alpha = show ? 0 : 1;
//    }];
}
- (ArtLoginCheckCodeView *)ckView
{
    if(!_ckView){
        _ckView = [[ArtLoginCheckCodeView alloc] init];
        [self addSubview:_ckView];
    }
    return _ckView;
}

- (ArtLoginPasswordView *)pwView
{
    if(!_pwView){
        _pwView = [[ArtLoginPasswordView alloc] init];
        _pwView.alpha = 0;
        [self addSubview:_pwView];
    }
    return _pwView;
}

- (UIButton *)ckBtn
{
    if(!_ckBtn){
//        [ArtStatisticAnalysisService eventType:EArtEventType_Login_CD];
        _ckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ckBtn.titleLabel.font = [UIFont systemFontOfSize:kArtLRScaleTitleFont];
        [_ckBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_ckBtn setTitle:@"验证码登录" forState:UIControlStateSelected];
        [_ckBtn setTitleColor:UIColorFromHexString(@"999999") forState:UIControlStateNormal];
        [_ckBtn setTitleColor:UIColorFromHexString(@"333333") forState:UIControlStateSelected];
        _ckBtn.selected = YES;
    }
    return _ckBtn;
}
- (UIButton *)pwBtn
{
    if(!_pwBtn){
        _pwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pwBtn.titleLabel.font = [UIFont systemFontOfSize:kArtLRScaleTitleFont];
        [_pwBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_pwBtn setTitle:@"密码登录" forState:UIControlStateSelected];
        [_pwBtn setTitleColor:UIColorFromHexString(@"999999") forState:UIControlStateNormal];
        [_pwBtn setTitleColor:UIColorFromHexString(@"333333") forState:UIControlStateSelected];
    }
    return _pwBtn;
}
@end
