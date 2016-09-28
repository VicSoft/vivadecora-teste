//
//  DummyVenueView.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "DummyVenueView.h"
#import "Venue+Service.h"
#import "BusinessConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DummyVenueView

- (DummyVenueView *)init {
    DummyVenueView *result = nil;
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
    DummyVenueView *view = [[DummyVenueView alloc] init];
    
    view.frame = frame;
    view.venue = venue;
    
    [view loadData];
    
    return view;
}

- (void)loadData {
    Venue *entity = self.venue;
    NSURL *url = [NSURL URLWithString:[BASE_URL_IMAGE_SINGLE stringByAppendingString:[entity imageUrl]]];
    
    NSString *section = [@"Section " stringByAppendingString:[entity section]];
    NSString *row = [@", Row " stringByAppendingString:[entity row]];
    NSString *seat = [@", Seat " stringByAppendingString:[entity seat]];
    NSString *contentsSectionDescriptionLabel = [section stringByAppendingString:[row stringByAppendingString:seat]];
    
    NSString *home = [entity home];
    NSString *away = [entity away];
    NSString *contentsTeamDescriptionLabel = [home stringByAppendingString:[@", " stringByAppendingString:away]];
    
    [self.mainView.layer setCornerRadius:5.f];
    
    [self.titleLabel setText:[entity name]];
    [self.sectionDescriptionLabel setText:contentsSectionDescriptionLabel];
    [self.sectionTeamDescriptionLabel setText:contentsTeamDescriptionLabel];
    [self.viewsCountingLabel setText:[[entity views] stringValue]];
    
    if ([entity image]) {
        self.coverImageView.image = [UIImage imageWithData:[entity image]];
        
        [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.spinnerIndicator stopAnimating];
    } else {
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
