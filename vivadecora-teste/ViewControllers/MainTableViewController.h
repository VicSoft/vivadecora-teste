//
//  MainTableViewController.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "BusinessConstants.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface MainTableViewController : UITableViewController <UIAlertViewDelegate>

- (void)makeGETRequest:(NSString *)url completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
- (void)showAlertMessage:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle anotherTitle:(NSString *)anotherTitle;

@end
