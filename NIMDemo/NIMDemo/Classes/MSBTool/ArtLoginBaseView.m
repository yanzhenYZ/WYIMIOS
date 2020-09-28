//
//  ArtLoginBaseView.m
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginBaseView.h"
//#import <ArtFoundation/NSMutableAttributedString+LL.h>
//#import <ArtFoundation/NSMutableDictionary+LL.h>
//#import <ArtFoundation/UIImage+Art.h>
#import "UIColor+Art.h"
#import "MSBContant.h"

@implementation ArtLoginBaseView

- (ArtLoginInputView *)mobileInputView
{
    if(!_mobileInputView){
        _mobileInputView = [[ArtLoginInputView alloc] initWithType:EArtInputViewTypeNumberAndText];
//        NSMutableAttributedString *attribute = [NSMutableAttributedString ll_makeAttributeString:@"请输入手机号" attribute:^(NSMutableDictionary *attributes) {
//            attributes.ll_systemFontSize(kArtLRScaleFontSize).ll_color([UIColor colorWithHexString:@"BDBDBD"]);
//        }];
//        _mobileInputView.textField.attributedPlaceholder = [attribute copy];
        _mobileInputView.textField.placeholder = @"请输入手机号";
    }
    return _mobileInputView;
}

- (UIButton *)enterBtn
{
    if(!_enterBtn){
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[ArtGradientRoundedRectButton new];
        _enterBtn.titleLabel.font = [UIFont systemFontOfSize:kArtLRScaleButtonFont];
    }
    return _enterBtn;
}
+ (void)setupLRButtonState:(UIButton *)button
{
    //
    [button setTitleColor:kArtLRButtonTitleColor0 forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:kArtLRButtonBgColor0 size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    //
    [button setTitleColor:kArtLRButtonTitleColor4 forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage createImageWithColor:kArtLRButtonBgColor4 size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    //
    [button setTitleColor:kArtLRButtonTitleColor1 forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage createImageWithColor:kArtLRButtonBgColor1 size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    //
    [button setTitleColor:kArtLRButtonTitleColor5 forState:UIControlStateSelected + UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage createImageWithColor:kArtLRButtonBgColor5 size:CGSizeMake(1, 1)] forState:UIControlStateSelected + UIControlStateHighlighted];
}
@end
