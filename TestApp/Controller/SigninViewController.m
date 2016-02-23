//
//  SigninViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "SigninViewController.h"
#import "RegisterViewController.h"
#import "CustomButton.h"
#import "CustomTextField.h"
#import "ClientRequest.h"
#import "Util.h"
#import "MainViewController.h"
#import "Define.h"
#import "AppDelegate.h"
#import "Global.h"
#import "User.h"

@interface SigninViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet CustomTextField *emailTextField;
@property (nonatomic, weak) IBOutlet CustomTextField *passwordTextField;
@property (nonatomic, weak) IBOutlet CustomButton *siginButton;
@property (nonatomic, weak) IBOutlet CustomButton *registerButton;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupUI{
    //[self.siginButton setColorBoder:kEnumBlueColorType];
    //[self.registerButton setColorBoder:kEnumRedColorType];
}

#pragma - Events
- (IBAction)signin:(id)sender{
    NSString *email = [self.emailTextField text];
    NSString *password = [self.passwordTextField text];
    BOOL (^validate)(void) = ^{
        if (email.length != 0) {
            if (![Util validateEmail:email]) {
                [self showAlert:@"Validate" message:@"Please check your email!"];
                return NO;
            }
        }else{
            [self showAlert:@"Validate" message:@"Please enter your email. Email field can not empty!"];
            return NO;
        }
        
        if (password.length == 0) {
            [self showAlert:@"Validate" message:@"Please enter your password!"];
            return NO;
        }
        return YES;
    };
    
    if (validate()) {
        [self showHud];
        [[ClientRequest share] signIn:@{@"email": email,
                                        @"password": password}
                             complete:^(User *user) {
            [self hideHud];
            if (user) {
                [[Global share] setShareToken:user.token];
                [SharedAppDelegate setupMainRootView];
            }
        } error:^(NSError *error) {
            [self hideHud];
            [self showAlert:@"Validate" message:[[error userInfo] objectForKey:@"mess"]];
        }];
    }
}

- (IBAction)registerUser:(id)sender{
    RegisterViewController *registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RegisterViewController class])];
    [registerViewController setCompleteBlock:^(User *user) {
        [SharedAppDelegate addUser:user];
    }];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

#pragma mark - UITextfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
