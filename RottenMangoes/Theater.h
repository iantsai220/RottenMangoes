//
//  Theater.h
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-28.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Theater : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, assign) float lat;

@property (nonatomic, assign) float lng;

@property (nonatomic, strong) UIImage *image;

-(UIImage *)theaterName;


@end
