//
//  ArtLoginInputView.h
//  ArtVideoWB
//
//  Created by lbq on 2018/6/28.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ArtPhoneCode.h"
//#import "NSString+Input.h"
//#import <ArtCommon/ArtGradientButton.h>
#import "ArtLRTextField.h"

@class ArtLoginInputView;

typedef NS_ENUM(NSUInteger, EArtInputViewType) {
    EArtInputViewTypeText,//文本框
    EArtInputViewTypeNumberAndText,//区号选择+文本框
    EArtInputViewTypeRight,//文本框+选择
//    EArtInputViewTypeSecureText,//密码
};

typedef NS_OPTIONS(NSUInteger, EArtStringInputOptions) {
    EArtStringInput_HanZi    = 1 << 0,//汉字
    EArtStringInput_Number   = 1 << 1,//0-9
    EArtStringInput_Alphabet = 1 << 2,//a-zA-Z
    EArtStringInput_All      = ~0UL
};

typedef NS_OPTIONS(NSUInteger, EArtLRInputType) {
    EArtLRInputType_HanZi    = EArtStringInput_HanZi,
    EArtLRInputType_Number   = EArtStringInput_Number,
    EArtLRInputType_Alphabet = EArtStringInput_Alphabet,
    EArtLRInputType_All      = EArtStringInput_All
};

@interface ArtLoginInputView : UIView
- (instancetype)initWithType:(EArtInputViewType)aType;

@property (nonatomic, strong) ArtLRTextField *textField;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, strong) UIButton *selectionBtn;
@property (nonatomic, strong) UIImage  *iconImage;
//仅EArtInputViewTypeNumberAndText可用
@property (nonatomic,  copy) NSString  *phonePrefix;

//只允许汉字,英文,数字; 不可输入字符
@property (nonatomic, assign) EArtLRInputType textType;

@property (nonatomic,assign) BOOL  datePickerShowing;
//默认 kArtLRScaleViewHeight / 2
@property (nonatomic,assign) CGFloat  cornerRadius;

@end
