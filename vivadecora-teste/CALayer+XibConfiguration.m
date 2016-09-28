//
//  CALayer+XibConfiguration.m
//  vivocorp-ios
//
//  Created by Victor Barbosa on 4/22/14.
//  Copyright (c) 2014 VicSoft. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end