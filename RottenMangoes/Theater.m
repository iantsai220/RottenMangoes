//
//  Theater.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-28.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "Theater.h"

@interface Theater ()

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation Theater

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        _imageArray = @[
                        [UIImage imageNamed:@"cineplex.jpg"],
                        [UIImage imageNamed:@"landmark.jpg"],
                        [UIImage imageNamed:@"scotiabank.png"],
                        [UIImage imageNamed:@"silvercity.png"]
                        ];
        
    }
    return self;
}

-(UIImage *)theaterName {
    
    if ([self.name containsString:@"Cineplex"]) {
        return self.imageArray[0];
    }
    else if ([self.name containsString:@"Landmark"]) {
        return self.imageArray[1];
    }
    else if ([self.name containsString:@"Scotiabank"]) {
        return self.imageArray[2];
    }
    else if ([self.name containsString:@"SilverCity"]) {
        return self.imageArray[3];
    }
    else {
        return nil;
    }
    
    //find if theater image name is in theater name
    //if found set theater image to theater
    
    
}

@end
