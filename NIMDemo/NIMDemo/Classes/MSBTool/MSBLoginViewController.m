//
//  MSBLoginViewController.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBLoginViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Art.h"
#import "MSBContant.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ArtLoginView.h"

@interface MSBLoginViewController ()
@property (nonatomic, strong) ArtLoginView *loginView;
@property(nonatomic, strong) UIButton * acceptCheckBtn;
@property(nonatomic, strong) UIView * acceptCheckUnderLine;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgetPwdBtn;
//@property (nonatomic, strong) ArtLoginPWViewModel *pwVM;
//@property (nonatomic, strong) ArtCheckCodeViewModel *ckVM;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;
@property (nonatomic,strong) UIImageView  *teacherLogoImageView;
@property (nonatomic,strong) UIImageView  *studentLogoImageView;
@property (nonatomic,  copy) NSString  *area;
@end

@implementation MSBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self makeUI];
//    [self addObserver];
    [self bindViewModel];
    //
    UISwipeGestureRecognizer *swipeGesture;
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    //
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)makeUI
{
    if (1) {
        [self.view addSubview:self.teacherLogoImageView];
        [self.view addSubview:self.acceptCheckBtn];
//        [self.view addSubview:self]
        [self.teacherLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kArtLRScalePageTop));
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(160 * kArtLRScaleFactor, 69 * kArtLRScaleFactor));
        }];
//        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(kArtLRScalePageMargin));
//            make.right.equalTo(@(-kArtLRScalePageMargin));
//            make.top.equalTo(self.teacherLogoImageView.mas_bottom)
//            .offset(34 * kArtLRScaleFactor);
//        }];
        [self.acceptCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(28);
            make.bottom.mas_equalTo(-100);
        }];
        
        [self.view layoutIfNeeded];
        //单边边框(右边)
        CALayer *deleteBtnBorder = [CALayer layer];
        float height = self.acceptCheckBtn.bounds.size.height;
        float width = self.acceptCheckBtn.titleLabel.bounds.size.width;
        deleteBtnBorder.frame = CGRectMake(self.acceptCheckBtn.titleLabel.frame.origin.x - 1, height - 0.5, width + 2, 0.5);
        deleteBtnBorder.backgroundColor = [UIColor colorWithRGBHex:0xC7C7C7].CGColor;
         
        [self.acceptCheckBtn.layer addSublayer:deleteBtnBorder];
        
    }else{
       
        
        [self.view addSubview:self.studentLogoImageView];
        [self.studentLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kArtLRScalePageTop));
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(160 * kArtLRScaleFactor, 45 * kArtLRScaleFactor));
        }];
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kArtLRScalePageMargin));
            make.right.equalTo(@(-kArtLRScalePageMargin));
            make.top.equalTo(self.studentLogoImageView.mas_bottom)
            .offset(43 * kArtLRScaleFactor);
        }];
        [self.view addSubview:self.registerBtn];
        [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loginView).offset(20 * kScaleFactor);
            make.top.equalTo(self.loginView.mas_bottom).offset(15 * kScaleFactor);
        }];
        [self.view addSubview:self.forgetPwdBtn];
        [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.loginView).offset(-20 * kScaleFactor);
            make.top.equalTo(self.loginView.mas_bottom).offset(15 * kScaleFactor);
        }];
    }
}
- (void)bindViewModel
{
//    [self bindCheckCodeViewModel];
//    [self bindPWViewModel];
//    [self bindAction];
}

/*
- (void)bindCheckCodeViewModel
{
    //最大20位限制
    @weakify(self);
    RAC(self.loginView.ckView.mobileInputView.textField, text) = [[self.loginView.ckView.mobileInputView.textField.rac_textSignal filter:^BOOL(NSString *value) {
        @strongify(self);
//        if ([self.ckVM.areaCode isEqualToString:@"+86"]) {
//            return value.length > 11;
//        }
        return value.length > kPhoneNumberMax;
    }] map:^id(NSString *value) {
        @strongify(self);
//        if ([self.ckVM.areaCode isEqualToString:@"+86"]) {
//            return [value substringToIndex:11];
//        }
        return [value substringToIndex:kPhoneNumberMax];
    }];
    
    //验证码最大6位限制
    RAC(self.loginView.ckView.checkCodeInputView.textField, text) = [[self.loginView.ckView.checkCodeInputView.textField.rac_textSignal filter:^BOOL(NSString *value) {
        return value.length > kCheckCodeNumberMax;
    }] map:^id(NSString *value) {
        return [value substringToIndex:kCheckCodeNumberMax];
    }];
    
    RAC(self.ckVM,areaCode) = RACObserve(self.loginView.ckView.mobileInputView.selectionBtn.titleLabel, text);
    RAC(self.ckVM,mobile) = [RACSignal merge:@[RACObserve(self.loginView.ckView.mobileInputView.textField, text),self.loginView.ckView.mobileInputView.textField.rac_textSignal]];
    RAC(self.ckVM,checkCode) = [RACSignal merge:@[RACObserve(self.loginView.ckView.checkCodeInputView.textField, text),self.loginView.ckView.checkCodeInputView.textField.rac_textSignal]];
    [RACObserve(self.ckVM, checkCodeSeleted) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.loginView.ckView.checkCodeBtn.selected = x.boolValue;
    }];
    
    [RACObserve(self.ckVM, enterSeleted) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.loginView.ckView.enterBtn.selected = x.boolValue;
    }];
    // Loading
    [RACObserve(self.ckVM, isRequestExecuting) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self showLoading];
        }else{
            [self dismissLoading];
        }
    }];
    [RACObserve(self.pwVM, isRequestExecuting) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self showLoading];
        }else{
            [self dismissLoading];
        }
    }];
    /// 数据成功
    [self.ckVM.loginCommand.executionSignals.switchToLatest
     subscribeNext:^(NSDictionary * x) {
        @strongify(self);
        [self.ckVM stopTimer];
        [self loginOrRegisterComplete:x];
    }];
    /// 错误信息
    [self.ckVM.loginCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.ckVM stopTimer];
        [self showErrorText:error.localizedDescription];
    }];
    
    [self.ckVM.checkCodeCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
        NSLog(@"[登录]获取验证码,输入后,进行下一步");
    }];
    
    [self.ckVM.checkCodeCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.ckVM stopTimer];
        [self showErrorText:error.localizedDescription];
    }];
    
    [[RACObserve(self.ckVM, countDown) skip:1] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.integerValue == 60) {//获取验证码
            [self.loginView.ckView resetCheckBtn];
        } else {
            [self.loginView.ckView checkBtnForCountDown:x.integerValue];
        }
    }];
    __weak typeof(self) weakSelf = self;
    [[self.loginView.ckView.mobileInputView.selectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        [weakSelf showCountriesWithAreaCode:btn.titleLabel.text area:weakSelf.area selectionBlock:^(NSString *areaCode,NSString *area) {
            weakSelf.area = area;
            [btn setTitle:areaCode forState:UIControlStateNormal];
            weakSelf.loginView.ckView.mobileInputView.phonePrefix = areaCode;
        }];
    }];
}
*/
//- (void)bindPWViewModel
//{
//    @weakify(self);
//    //最大20位限制
//    RAC(self.loginView.pwView.mobileInputView.textField, text) = [[self.loginView.pwView.mobileInputView.textField.rac_textSignal filter:^BOOL(NSString *value) {
//        @strongify(self);
//        if ([self.pwVM.areaCode isEqualToString:@"+86"]) {
//            return value.length > 11;
//        }
//        return value.length > kPhoneNumberMax;
//    }] map:^id(NSString *value) {
//        @strongify(self);
//        if ([self.pwVM.areaCode isEqualToString:@"+86"]) {
//            return [value substringToIndex:11];
//        }
//        return [value substringToIndex:kPhoneNumberMax];
//    }];
//    
//    //密码最大16位限制
//    RAC(self.loginView.pwView.passwordInputView.textField, text) = [[self.loginView.pwView.passwordInputView.textField.rac_textSignal filter:^BOOL(NSString *value) {
//        return value.length > kPasswordMax;
//    }] map:^id(NSString *value) {
//        return [value substringToIndex:kPasswordMax];
//    }];
//    
//    
//    RAC(self.pwVM,areaCode) = RACObserve(self.loginView.pwView.mobileInputView.selectionBtn.titleLabel, text);
//    RAC(self.pwVM,mobile) = [RACSignal merge:@[RACObserve(self.loginView.pwView.mobileInputView.textField, text),self.loginView.pwView.mobileInputView.textField.rac_textSignal]];
//    RAC(self.pwVM,password) = [RACSignal merge:@[RACObserve(self.loginView.pwView.passwordInputView.textField, text),self.loginView.pwView.passwordInputView.textField.rac_textSignal]];
//    
//    [RACObserve(self.pwVM, enterSeleted) subscribeNext:^(NSNumber *x) {
//        @strongify(self);
//        self.loginView.pwView.enterBtn.selected = x.boolValue;
//    }];
//    
//    /// 数据成功
//    [self.pwVM.loginCommand.executionSignals.switchToLatest
//     subscribeNext:^(NSDictionary * x) {
//        @strongify(self);
//        [self loginOrRegisterComplete:x];
//    }];
//    
//    /// 错误信息
//    [self.pwVM.loginCommand.errors subscribeNext:^(NSError *error) {
//        @strongify(self);
//        [self showErrorText:error.localizedDescription];
//    }];
//    __weak typeof(self) weakSelf = self;
//    [[self.loginView.pwView.mobileInputView.selectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
//        [weakSelf showCountriesWithAreaCode:btn.titleLabel.text area:weakSelf.area selectionBlock:^(NSString *areaCode,NSString *area) {
//            weakSelf.area = area;
//            [btn setTitle:areaCode forState:UIControlStateNormal];
//            weakSelf.loginView.pwView.mobileInputView.phonePrefix = areaCode;
//        }];
//    }];
//}

//- (void)bindAction
//{
//    @weakify(self);
//
//    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.ckVM stopTimer];
//        if (self.loginView.isCurrentCK) {
//            [ArtStatisticAnalysisService event:@"1_4_0_click_idecodelogin_register"];
//        } else {
//            [ArtStatisticAnalysisService event:@"1_4_0_click_passwordlogin_register"];
//        }
//        UIViewController *controller = nil;
//        for (UIViewController *obj in self.navigationController.viewControllers) {
//            if ([obj isKindOfClass:ArtRegisterViewController.class]) {
//                controller = obj; break;
//            }
//        }
//        if (controller != nil) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }else {
//
//            //老师没有注册
//            if (self.identity == ArtLoginUserIdentityTypeStudent) {
//                ArtRegisterViewController *registerVC = [ArtRegisterViewController controllerWIthIdentity:self.identity regsiterType:EArtRegisterTypeDefault callbackAfterDismiss:self.callbackAfterDismiss complection:self.successCallback];
//                registerVC.appkey = self.appkey;
//                registerVC.secret = self.secret;
//                registerVC.countries = self.countries;
//                registerVC.agreementURLString = self.agreementURLString;
//                registerVC.privacyURLString = self.privacyURLString;
//                registerVC.customSuccessAction = self.customSuccessAction;
//                if (self.navigationController) {
//                    [self.navigationController pushViewController:registerVC animated:YES];
//                } else {
//                    [self presentViewController:registerVC animated:YES completion:nil];
//                }
//            }
//        }
//    }];
//    [[self.forgetPwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.ckVM stopTimer];
//        ArtForgetPasswordViewController *controller = [ArtForgetPasswordViewController new];
//        controller.successCallback = self.successCallback;
//        controller.identity = self.identity;
//        if (self.navigationController) {
//            [self.navigationController pushViewController:controller animated:YES];
//        } else {
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//    }];
//    //CK
//    [[self.loginView.ckView.enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [ArtStatisticAnalysisService event:@"1_4_0_click_idecodelogin_login"];
//        [self.ckVM.loginCommand execute:nil];
//    }];
//
//    [[self.loginView.ckView.checkCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [ArtStatisticAnalysisService event:@"1_4_0_click_idecodelogin_getcode"];
//        [self.ckVM.checkCodeCommand execute:nil];
//    }];
//
//    //PW
//    [[self.loginView.pwView.enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [ArtStatisticAnalysisService event:@"1_4_0_click_passwordlogin_login"];
//        [self.pwVM.loginCommand execute:nil];
//    }];
//
//}

//- (void)loginOrRegisterComplete:(NSDictionary *)successInfo
//{
//    if (self.customSuccessAction) {
//        self.customSuccessAction();
//        return;
//    }
//    __weak typeof(self) weakSelf = self;
//    void(^complete)(void) = ^(){
//        if (weakSelf.successCallback) {
//            weakSelf.successCallback(YES, ArtLoginSuccessTypeLogin, successInfo);
//        }
//    };
//    if (self.callbackAfterDismiss) {
//        [self dismissVCCompletion:complete];
//    } else {
//        complete();
//        [self dismissVCCompletion:nil];
//    }
//}

- (void)dismissVCCompletion:(void(^)(void))completion
{
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:completion];
    });
    //在有键盘弹出的情况下才需要延时dismiss
//    if([IQKeyboardManager sharedManager].keyboardShowing) {
//        [self.view endEditing:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self dismissViewControllerAnimated:YES completion:completion];
//        });
//    } else {
//        [self dismissViewControllerAnimated:YES completion:completion];
//    }
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.loginView.switchToPW = YES;
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        self.loginView.switchToPW = NO;
    }
}
- (void)acceptCheckBtnClick:(UIButton *)sender {
//    if (self.acceptCheckBtnDidClick) self.acceptCheckBtnDidClick(sender, self.navigationController);
}
//MARK: lazy
- (ArtLoginView *)loginView
{
    if(!_loginView){
        _loginView = [[ArtLoginView alloc] init];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (UIButton *)acceptCheckBtn {
    if (!_acceptCheckBtn) {
        _acceptCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _acceptCheckBtn.titleLabel.font = [UIFont systemFontOfSize:14 * kArtLRScaleFactor];
        [_acceptCheckBtn setTitle:@"应聘考核课堂" forState:UIControlStateNormal];
        [_acceptCheckBtn setTitleColor:[UIColor colorWithRGBHex:0x999999] forState:UIControlStateNormal];
        [_acceptCheckBtn addTarget:self action:@selector(acceptCheckBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _acceptCheckBtn;
}
- (UIView *)acceptCheckUnderLine {
    if (!_acceptCheckUnderLine) {
        _acceptCheckUnderLine = [UIView new];
        _acceptCheckUnderLine.backgroundColor = [UIColor colorWithRGBHex:0x999999];
    }
    return _acceptCheckUnderLine;
}

- (UIButton *)registerBtn
{
    if(!_registerBtn){
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14 * kArtLRScaleFactor];
        [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:UIColorFromHexString(@"999999")  forState:UIControlStateNormal];
        //_registerBtn.art_extEdageInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return _registerBtn;
}
- (UIButton *)forgetPwdBtn
{
    if(!_forgetPwdBtn){
        _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14 * kArtLRScaleFactor];
        [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPwdBtn setTitleColor:UIColorFromHexString(@"999999") forState:UIControlStateNormal];
        //_forgetPwdBtn.art_extEdageInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return _forgetPwdBtn;
}
- (UIImageView *)teacherLogoImageView
{
    if (!_teacherLogoImageView) {
        _teacherLogoImageView = [UIImageView new];
        _teacherLogoImageView.image = [UIImage imageNamed:@"art_lr_teacher_logo"];
    }
    return _teacherLogoImageView;
}
- (UIImageView *)studentLogoImageView
{
    if (!_studentLogoImageView) {
        _studentLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"art_lr_stu_logo"]];
    }
    return _studentLogoImageView;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
