//
//  RegisterViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "RegisterViewController.h"
#import "CustomTextField.h"
#import "CustomButton.h"
#import "ClientRequest.h"
#import "Util.h"
#import "User.h"

@interface RegisterViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet CustomTextField *nameTextfield;
@property (nonatomic, weak) IBOutlet CustomTextField *emailTextField;
@property (nonatomic, weak) IBOutlet CustomTextField *passwordTextField;
@property (nonatomic, weak) IBOutlet CustomButton *createAccountButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = self.backButton;
    [self setTitle:@"Register"];
}

- (void)resetInputField{
    self.nameTextfield.text = @"";
    self.emailTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (void)setupUI{
    //[self.createAccountButton setColorBoder:kEnumRedColorType];
}

#pragma mark - Events
- (IBAction)createAnAccount:(id)sender{
    NSString *name = [self.nameTextfield text];
    NSString *email = [self.emailTextField text];
    NSString *password = [self.passwordTextField text];
    BOOL (^validate)(void) = ^{
        if (name.length == 0) {
            [self showAlert:@"Validate" message:@"Please enter your name!"];
            return NO;
        }
        if (email.length !=0) {
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
        }
        return YES;
    };
    
    if (validate()) {
        [self showHud];
        [[ClientRequest share] createUser:@{@"name": name,
                                            @"email": email,
                                            @"password": password} complete:^(User *user) {
            [self hideHud];
            if (user) {
                self.CompleteBlock(user);
                self.CompleteBlock = nil;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Create a account success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        } error:^(NSError *error) {
            [self hideHud];
            [self showAlert:@"Validate" message:[[error userInfo] objectForKey:@"mess"]];
        }];
    }
}

#pragma mark - UITextfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{    [self.navigationController popViewControllerAnimated:YES];
}

@end
