//
//  ArtLoginView.h
//  ArtVideoWB
//
//  Created by lbq on 2018/6/29.
//  Copyright © 2018年 雷华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtLoginCheckCodeView.h"
#import "ArtLoginPasswordView.h"

@interface ArtLoginView : UIView
//@property (nonatomic, assign) ArtLoginUserIdentityType identity;
@property (nonatomic, assign) BOOL switchToPW;
@property (nonatomic, assign, readonly) BOOL isCurrentCK;//当前界面是验证码登录
@property (nonatomic, strong) ArtLoginCheckCodeView *ckView;
@property (nonatomic, strong) ArtLoginPasswordView *pwView;
@end
