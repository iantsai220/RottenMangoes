//
//  MovieCell.h
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"


@interface MovieCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;


@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

-(void)configureImage:(Movie *)movie;



@end
