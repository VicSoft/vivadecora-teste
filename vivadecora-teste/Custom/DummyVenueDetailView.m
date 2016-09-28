//
//  DummyVenueDetailView.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/26/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "DummyVenueDetailView.h"
#import "Venue+Service.h"
#import "BusinessConstants.h"
#import "AppDelegate.h"
#import <DTCoreText.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DummyVenueDetailView

#pragma mark - Actions

- (IBAction)accessWebSiteTouched:(id)sender {
    NSArray *strUrlParts = [[self.venue sameas] componentsSeparatedByString:@","];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[strUrlParts firstObject]]];
}


#pragma mark - Class methods

- (DummyVenueDetailView *)init {
    DummyVenueDetailView *result = nil;
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
    
    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            result = anObject;
            break;
        }
    }
    
    return result;
}

- (instancetype)initWithVenue:(id)venue usingFrame:(CGRect)frame {
    DummyVenueDetailView *view = [[DummyVenueDetailView alloc] init];
    
    view.frame = frame;
    view.venue = venue;
    
    [view loadData];
    
    return view;
}

- (void)loadData {
    Venue *entity = self.venue;
    
    NSString *section = [@"Section " stringByAppendingString:[entity section]];
    NSString *row = [@", Row " stringByAppendingString:[entity row]];
    NSString *seat = [@", Seat " stringByAppendingString:[entity seat]];
    NSString *contentsSectionDescriptionLabel = [section stringByAppendingString:[row stringByAppendingString:seat]];
    
    NSString *home = [entity home];
    NSString *away = [entity away];
    NSString *contentsTeamDescriptionLabel = [home stringByAppendingString:[@", " stringByAppendingString:away]];
    
    if ([entity stats] && [[entity stats] length] > 0) {
        NSString *html = [NSString stringWithFormat:@"<p style='font-size:14px; line-height: 20px;'><font color='#828282' face='Helvetica'>%@</font></p>", [entity stats]];
        NSDictionary *options = @{NSTextSizeMultiplierDocumentOption: [NSNumber numberWithFloat: 1.0],
                                  DTUseiOS6Attributes: [NSNumber numberWithBool:YES]};
        NSAttributedString *contentStats = [[NSAttributedString alloc] initWithHTMLData:[html dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:nil];
        [self.sectionStatsLabel setAttributedText:contentStats];
    } else {
        [self.sectionStatsLabel setText:@"No contents found"];
    }
    
    if (![self.venue sameas] || ![[self.venue sameas] length]) {
        [self.accessSiteButton setHidden:YES];
    }
    
    [self.titleLabel setText:[entity name]];
    [self.averageRangeLabel setText:[[[entity averageRating] stringValue] stringByReplacingOccurrencesOfString:@"." withString:@","]];
    [self.sectionDescriptionLabel setText:contentsSectionDescriptionLabel];
    [self.sectionTeamDescriptionLabel setText:contentsTeamDescriptionLabel];
    
    if ([entity image]) {
        self.coverImageView.image = [UIImage imageWithData:[entity image]];
        
        [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.spinnerIndicator stopAnimating];
    } else {
        NSURL *url = [NSURL URLWithString:[BASE_URL_IMAGE_SINGLE stringByAppendingString:[entity imageUrl]]];
        
        [self.coverImageView sd_setImageWithURL:url
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          
                                          if (image) {
                                              if (entity.image == nil) {
                                                  [Venue setVenueImage:entity image:UIImagePNGRepresentation(image)];
                                              }
                                              [self.spinnerIndicator stopAnimating];
                                              [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
                                          }
                                      }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
