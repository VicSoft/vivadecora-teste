//
//  MainTableViewController.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

#pragma mark - ViewController's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor alloc] initWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:.8f]];
    [SVProgressHUD setForegroundColor:[[UIColor alloc] initWithRed:0/255.0f green:90/255.0f blue:139/255.0f alpha:1.0f]];
    
    [[self.navigationController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class methods

- (void)showAlertMessage:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle anotherTitle:(NSString *)anotherTitle {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:self
                      cancelButtonTitle:cancelTitle
                      otherButtonTitles:anotherTitle, nil] show];
}

- (void)makeGETRequest:(NSString *)url completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:completionHandler];
    
    if ([dataTask state] == NSURLSessionTaskStateRunning) {
        [dataTask cancel];
    }
    
    [dataTask resume];
}

@end
