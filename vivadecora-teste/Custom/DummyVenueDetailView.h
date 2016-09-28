//
//  DummyVenueDetailView.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/26/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DummyVenueDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionTeamDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionStatsLabel;
@property (weak, nonatomic) IBOutlet UIButton *accessSiteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerIndicator;


@property (nonatomic, strong) id venue;

- (DummyVenueDetailView *)init;
- (instancetype)initWithVenue:(id)venue usingFrame:(CGRect)frame;

@end
