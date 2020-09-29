//
//  MSBLoginViewController.m
//  NIM
//
//  Created by yanzhen on 2020/9/28.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "MSBLoginViewController.h"

@interface MSBLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *mobileView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

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

- (IBAction)login:(id)sender {
    
}

@end
