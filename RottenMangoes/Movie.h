//
//  Movie.h
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSString *review;

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, strong) UIImage *image;

-(instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail review:(NSString *)review image:(NSString *)image;

@end
