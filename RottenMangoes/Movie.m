//
//  Movie.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail review:(NSString *)review image:(NSString *)image {
    self = [super init];
    if (self) {
        _title = title;
        _detail = detail;
        _imageURL = image;
        _review = review;
        _image = nil;
        
    }
    
    return self;
}

//-(NSURL *)imageURL {
//    return [NSURL URLWithString:self.imageURL];
//}


@end
