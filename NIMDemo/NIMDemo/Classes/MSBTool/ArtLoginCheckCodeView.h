//
//  ArtLoginCheckCodeView.h
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import "ArtLoginBaseView.h"

@interface ArtLoginCheckCodeView : ArtLoginBaseView
@property (nonatomic, strong) ArtLoginInputView *checkCodeInputView;
@property (nonatomic, strong) UIButton *checkCodeBtn;

- (void)resetCheckBtn;
- (void)checkBtnForCountDown:(NSInteger)aCountDown;
@end
