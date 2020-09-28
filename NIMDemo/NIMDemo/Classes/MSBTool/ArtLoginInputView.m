//
//  ArtLoginInputView.m
//  ArtVideoWB
//
//  Created by lbq on 2018/6/28.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginInputView.h"
//#import "ArtDatePickerView.h"
//#import "ArtAppLoginConfig.h"
#import <Masonry.h>
//#import <ArtFoundation/ArtUIDefine.h>
//#import <ArtFoundation/UIColor+Art.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "UIImage+ArtLoginAndRegister.h"
#import "MSBContant.h"
#import "UIColor+Art.h"

static NSString *kLRReg_nine     = @"➋➌➍➎➏➐➑➒";//九宫格
static NSString *kLRReg_hanzi    = @"\u4e00-\u9fa5";
static NSString *kLRReg_number   = @"0-9";
static NSString *kLRReg_alphabet = @"a-zA-Z";

@interface ArtLoginInputView()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, assign) EArtInputViewType type;
//
@property (nonatomic,strong) UIView  *contentView;

@property (nonatomic, strong) UIView *vLine;//竖线
//@property (nonatomic,  copy) NSArray<ArtPhoneCode *> *dataList;
@property (nonatomic, strong) UITextField *tmpField;
@property (nonatomic, strong) UIPickerView *areaPicker;
//@property (nonatomic, strong) ArtDatePickerView *datePicker;

@property (nonatomic,strong) UILabel  *phonePrexLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UIImageView *iconImageView;
@end
@implementation ArtLoginInputView

- (instancetype)initWithType:(EArtInputViewType)aType
{
    self = [super init];
    self.type = aType;
//    self.textType = EArtLRInputType_All;
    self.datePickerShowing = NO;
    [self makeUI];
    return self;
}

- (void)makeUI
{
    @weakify(self);
    self.highlighted = NO;
    if (self.type == EArtInputViewTypeNumberAndText) {
//        self.textType = EArtLRInputType_Number;
        self.iconImageView.image = [UIImage imageNamed:@"art_lr_phone"];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(18.5 * kArtLRScaleFactor));
            make.width.and.height.equalTo(@(24 * kArtLRScaleFactor));
            make.centerY.equalTo(self.contentView);
        }];
        [self.phonePrexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(17 * kArtLRScaleFactor);
            make.centerY.equalTo(self.contentView);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phonePrexLabel.mas_right).offset(7 * kArtLRScaleFactor);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(7 * kArtLRScaleFactor, 5 * kArtLRScaleFactor));
        }];
        [self.selectionBtn setTitleColor:UIColor.clearColor forState:UIControlStateNormal];
        self.selectionBtn.backgroundColor = UIColor.clearColor;
        [self.selectionBtn setImage:nil forState:UIControlStateNormal];
        [self.selectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.contentView);
            make.left.equalTo(self.phonePrexLabel);
            make.right.equalTo(self.arrowImageView);
        }];
        [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.left.equalTo(self.selectionBtn.mas_right).offset(13 * kArtLRScaleFactor);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView).multipliedBy(0.4);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(@(0));
            make.right.equalTo(@(-18.5 * kArtLRScaleFactor));
            make.left.equalTo(self.vLine.mas_right).offset(11.5 * kArtLRScaleFactor);
        }];
        self.textField.canPasteBlock = ^BOOL{
            @strongify(self)
            NSString *string = UIPasteboard.generalPasteboard.string.copy;
            //粘贴板里有字符,且必须是纯数字,才可以粘贴(电话号码都是数字)
            if (string.length > 0 && [self isPureInt:string]) {
                UIPasteboard.generalPasteboard.string = string;
                return YES;
            }
            return NO;
        };
        self.areaPicker = [self makeAreaPicker];
        self.tmpField.inputView = self.areaPicker;
    } else if (self.type == EArtInputViewTypeRight){
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-12 * kArtLRScaleFactor));
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(7 * kArtLRScaleFactor, 5 * kArtLRScaleFactor));
        }];
        self.textField.enabled = NO;
        self.textField.textAlignment = NSTextAlignmentRight;
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.contentView);
            make.right.equalTo(self.arrowImageView.mas_left).offset(-5 * kArtLRScaleFactor);
        }];
        [self.selectionBtn setTitle:@"" forState:UIControlStateNormal];
        [self.selectionBtn setTitleColor:UIColor.clearColor forState:UIControlStateNormal];
        self.selectionBtn.backgroundColor = UIColor.clearColor;
        [self.selectionBtn setImage:nil forState:UIControlStateNormal];
        [self.selectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
//        self.datePicker = [self makeDatePicker];
//        self.tmpField.inputView = self.datePicker;
    }else {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(@(0));
            make.left.equalTo(@(18.5 * kArtLRScaleFactor));
            make.right.equalTo(@(-18.5 * kArtLRScaleFactor));
        }];
    }
    //border
    self.backgroundColor = UIColor.clearColor;
    self.layer.masksToBounds = NO;
//    self.layer.shadowColor   = [UIColorFromHexString(@"766D6D") colorWithAlphaComponent:0.08].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 4);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius  = 16;
    //
    self.cornerRadius = kArtLRScaleViewHeight / 2;
    
    if (self.type == EArtInputViewTypeNumberAndText) return;
    [[self.selectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.type == EArtInputViewTypeNumberAndText) {
//            self.dataList = [ArtSharedConfig shared].launchConfig.telPrex;
//            if (self.dataList.count > 0 && !self.tmpField.isFirstResponder) {
//                [self.areaPicker reloadAllComponents];
//                __block NSInteger row = 0;
//                [self.dataList enumerateObjectsUsingBlock:^(ArtPhoneCode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if ([self.selectionBtn.currentTitle isEqualToString:obj.areaCode]) {
//                        row = idx;
//                        *stop = YES;
//                    }
//                }];
//                [self.areaPicker selectRow:row inComponent:0 animated:NO];
//                [self pickerView:self.areaPicker didSelectRow:row inComponent:0];
//                [self.tmpField becomeFirstResponder];
//            }else{
//                [self.tmpField resignFirstResponder];
//            }
        } else {
            if (!self.tmpField.isFirstResponder) {
                if (self.textField.text.length > 0) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy年MM月"];
                    NSDate *date = [formatter dateFromString:self.textField.text];
//                    [self.datePicker setCurrentDate:[NSDate dateWithYear:date.year month:date.month]];
                }
                [self.tmpField becomeFirstResponder];
                self.datePickerShowing = YES;
            } else {
                [self.tmpField resignFirstResponder];
                self.datePickerShowing = NO;
            }
        }
    }];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.contentView.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius
{
    return self.contentView.layer.cornerRadius;
}
- (NSString *)phonePrefix
{
    if (self.type != EArtInputViewTypeNumberAndText) return nil;
    return self.phonePrexLabel.text;
}
- (void)setPhonePrefix:(NSString *)phonePrefix
{
    if (self.type != EArtInputViewTypeNumberAndText) return;
    self.phonePrexLabel.text = phonePrefix;
}
- (void)setIconImage:(UIImage *)iconImage
{
    if (self.type != EArtInputViewTypeText) {
        return;
    }
    if (!iconImage) {
        self.iconImageView.hidden = YES;
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(@(0));
            make.left.equalTo(@(18.5 * kArtLRScaleFactor));
            make.right.equalTo(@(-18.5 * kArtLRScaleFactor));
        }];
        return;
    }
    self.iconImageView.image = iconImage;
    self.iconImageView.hidden = NO;
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18.5 * kArtLRScaleFactor));
        make.width.and.height.equalTo(@(24 * kArtLRScaleFactor));
        make.centerY.equalTo(self.contentView);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(@(0));
        make.left.equalTo(self.iconImageView.mas_right).offset(17 * kArtLRScaleFactor);
        make.right.equalTo(@(-18.5 * kArtLRScaleFactor));
    }];
}
- (UIImage *)iconImage
{
    return self.iconImageView.image;
}
- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
}

//MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.highlighted = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.highlighted = NO;
}

//
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length < range.location + range.length) {
        return NO;
    }
    if (self.textType == EArtLRInputType_All) {
        return YES;
    }
    BOOL result = [self isValidWithString:string type:self.textType];
    return result;
//    if (UI_IS_IPAD && self.type == EArtInputViewTypeNumberAndText && string.length > 0) {
//        return [self isPureInt:string];
//    }
//    return YES;
}
- (BOOL)isValidWithString:(NSString *)text type:(int)type
{
    if (text.length <= 0 || (type & EArtLRInputType_All) == EArtLRInputType_All) {
        return YES;
    }
    NSMutableString *pattern = [NSMutableString stringWithString:@"[^"];
    if (type & EArtLRInputType_HanZi) {
        [pattern appendString:kLRReg_hanzi];
    }
    if (type & EArtLRInputType_Alphabet) {
        [pattern appendString:kLRReg_alphabet];
    }
    if (type & EArtLRInputType_Number) {
        [pattern appendString:kLRReg_number];
    }
    [pattern appendString:kLRReg_nine];
    [pattern appendString:@"]+"];
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error || !reg) {
        NSLog(@"生成正则失败");
        return NO;
    }
    NSTextCheckingResult *result = [reg firstMatchInString:text options:NSMatchingAnchored range:NSMakeRange(0, text.length)];
    return result == nil;
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//MARK: UIPickerViewDataSource

//MARK: lazy
- (ArtLRTextField *)textField
{
    @weakify(self);
    if(!_textField){
        @strongify(self);
        _textField = [[ArtLRTextField alloc] initWithFrame:CGRectZero];
        _textField.inputAssistantItem.leadingBarButtonGroups = @[];
        _textField.inputAssistantItem.trailingBarButtonGroups = @[];
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:kArtLRScaleFontSize];
        _textField.tintColor = kArtLRSelectedColor;
        _textField.textColor = UIColorFromHexString(@"333333");
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.spellCheckingType = UITextSpellCheckingTypeNo;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

- (UITextField *)tmpField
{
    if(!_tmpField){
        _tmpField = [[UITextField alloc] initWithFrame:CGRectZero];
        _tmpField.tintColor = [UIColor clearColor];
        _tmpField.autocorrectionType = UITextAutocorrectionTypeNo;
        _tmpField.spellCheckingType = UITextSpellCheckingTypeNo;
        _tmpField.inputAssistantItem.leadingBarButtonGroups = @[];
        _tmpField.inputAssistantItem.trailingBarButtonGroups = @[];
        [self.contentView addSubview:_tmpField];
    }
    return _tmpField;
}

- (UIButton *)selectionBtn
{
    if(!_selectionBtn){
        _selectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectionBtn.titleLabel.font = [UIFont systemFontOfSize:kArtLRScaleFontSize];
        [_selectionBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_selectionBtn setTitle:@"+86" forState:UIControlStateNormal];
        [_selectionBtn setImage:[UIImage imageNamed:@"art_lr_arrow"] forState:UIControlStateNormal];
        [self.contentView addSubview:_selectionBtn];
    }
    return _selectionBtn;
}
- (UILabel *)phonePrexLabel
{
    if (!_phonePrexLabel) {
        _phonePrexLabel = [UILabel new];
        _phonePrexLabel.text = @"+86";
        _phonePrexLabel.textColor = UIColorFromHexString(@"333333");
        _phonePrexLabel.font = [UIFont systemFontOfSize:kArtLRScaleFontSize];
        [self.contentView addSubview:_phonePrexLabel];
    }
    return _phonePrexLabel;
}
- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"art_lr_arrow"];
        [self.contentView addSubview:_arrowImageView];
    }
    return _arrowImageView;
}
- (UIView *)vLine
{
    if(!_vLine){
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"EDEDED"];
        [self.contentView addSubview:_vLine];
    }
    return _vLine;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UIPickerView*)makeAreaPicker
{
    UIPickerView *areaPicker = [UIPickerView new];
    areaPicker.dataSource = self;
    areaPicker.delegate = self;
    areaPicker.showsSelectionIndicator = YES;
    return areaPicker;
}
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentView;
}

- (void)dealloc
{
    _textField = nil;
    NSLog(@"%s",__func__);
}
@end
