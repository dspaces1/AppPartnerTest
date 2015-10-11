//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"
#import "Constants.h"
#import "RESTfulHelper.h"

@interface LoginSectionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginSectionViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendLoginRequest:(id)sender
{
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    if ([self isFieldEmpty:username] && [self isFieldEmpty:password]) {
        [self checkIfUserIsValid:username password:password];
    } else {
        [self displayBlankFieldAlert];
    }
}

- (BOOL) isFieldEmpty: (NSString *)testString
{
    BOOL flag = true;
    
    NSString *trimmedString = [testString stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if ([trimmedString isEqual: @""]) {
        flag = false;
    }
    return flag;
}

- (void) displayBlankFieldAlert
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:errorTitle message:BlankSpaceField preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertView animated:true completion:nil];
}

- (void) checkIfUserIsValid: (NSString *)name password:(NSString *)password
{
    NSDictionary *jsonParameter = @{usernameString:name, passwordString:password};
    
    //API start timer
    NSDate *methodStart = [NSDate date];
    
    [RESTfulHelper postRequestWithDictionary:jsonParameter url:loginUrl completionBlock:^(NSError *error, NSDictionary *response) {
        
        //API end timer
        NSDate *methodFinish = [NSDate date];
        NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
        NSString *executionTimeMessage = [NSString stringWithFormat:@"\nThis api call took %f ms",executionTime];
        
        if (error == nil) {
            if (![response[responseCode] isEqualToString:errorTitle]) {
                [self displaySuccessfulLogin:executionTimeMessage];
            } else {
                [self displayFailedLogin:[response[message] stringByAppendingString:executionTimeMessage]];
            }
        } else {
            [self displayNetworkError:executionTimeMessage];
        }
    }];
}

- (void) displaySuccessfulLogin: (NSString *)message
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:successTitle message:[successfulLogin stringByAppendingString:message] preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alertView animated:true completion:nil];
}

- (void) displayFailedLogin: (NSString *)message
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:errorTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertView animated:true completion:nil];
}

- (void) displayNetworkError: (NSString *)message
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:errorTitle message:networkError preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertView animated:true completion:nil];
}

@end
