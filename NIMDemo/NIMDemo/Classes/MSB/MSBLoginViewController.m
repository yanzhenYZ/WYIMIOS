//
//  MSBLoginViewController.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBLoginViewController.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "MSBHttpTool.h"
#import "NTESLoginManager.h"
#import "NTESService.h"
#import "NTESMainTabController.h"

@interface MSBLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *mobileView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation MSBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    self.mobileView.layer.cornerRadius = 25;
    self.passwordView.layer.cornerRadius = 25;
    self.loginBtn.layer.cornerRadius = 25;
    self.loginBtn.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)login:(id)sender {
    if (_accountTF.text.length == 0) {
        [self.view makeToast:@"请输入账号" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    if (_passwordTF.text.length == 0) {
        [self.view makeToast:@"请输入密码" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    [_accountTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [SVProgressHUD show];
    
    [MSBHttpTool msbLogin:_accountTF.text identity:_passwordTF.text completion:^(NSDictionary *obj, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self.view makeToast:error.localizedDescription duration:2.0 position:CSToastPositionCenter];
        } else {
            NSDictionary *payload = obj[@"payload"];
            NSString *userId = payload[@"imId"];
            NSString *token = payload[@"token"];
            if (userId.length > 0 && token.length > 0) {
                [self nimSDKLogin:userId token:token];
            } else {
                [self.view makeToast:@"用户不存在" duration:2.0 position:CSToastPositionCenter];
            }
            NSLog(@"success: %@", payload);
        }
    }];
}

- (void)nimSDKLogin:(NSString *)loginAccount token:(NSString *)loginToken {
    [[[NIMSDK sharedSDK] loginManager] login:loginAccount
                                       token:loginToken
                                  completion:^(NSError *error) {
                                      [SVProgressHUD dismiss];
                                      if (error == nil)
                                      {
                                          NTESLoginData *sdkData = [[NTESLoginData alloc] init];
                                          sdkData.account   = loginAccount;
                                          sdkData.token     = loginToken;
                                          [[NTESLoginManager sharedManager] setCurrentLoginData:sdkData];
                                          
                                          [[NTESServiceManager sharedManager] start];
                                          NTESMainTabController * mainTab = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
                                          [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
                                      }
                                      else
                                      {
                                          NSString *toast = [NSString stringWithFormat:@"%@ code: %zd",@"登录失败".ntes_localized, error.code];
                                          [self.view makeToast:toast duration:2.0 position:CSToastPositionCenter];
                                      }
                                  }];
}
@end
