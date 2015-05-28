//
//  MovieCell.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

-(void)configureImage:(Movie *)movie {
    
    NSURL *url = [NSURL URLWithString:movie.imageURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task =[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieImage.image = image;
            movie.image = image;
        });
 
    }];
        
    [task resume];
        
        


}


@end
