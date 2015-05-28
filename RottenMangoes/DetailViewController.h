//
//  DetailViewController.h
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Movie *movieItem;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;

@property (nonatomic, strong) NSMutableArray *reviews;




@end
