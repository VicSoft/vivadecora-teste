//
//  DummyVenueView.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DummyVenueView : UIView

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionTeamDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsCountingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerIndicator;

@property (nonatomic, strong) id venue;

- (DummyVenueView *)init;
- (instancetype)initWithVenue:(id)venue usingFrame:(CGRect)frame;

@end
