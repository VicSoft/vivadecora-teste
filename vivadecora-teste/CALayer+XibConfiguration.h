//
//  CALayer+XibConfiguration.h
//  vivocorp-ios
//
//  Created by Victor Barbosa on 4/22/14.
//  Copyright (c) 2014 VicSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property (nonatomic, assign) UIColor* borderUIColor;

@end