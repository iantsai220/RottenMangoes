//
//  DetailViewController.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "DetailViewController.h"
#import "Review.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

-(void)viewDidLoad{
    
   [self configureView];
    
}

- (void)setMovieItem:(Movie *)movie {
    if (_movieItem != movie) {
        _movieItem = movie;
        
        
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    
    
    if (self.movieItem) {
        
        
        
        
        self.titleLabel.text = self.movieItem.title;
        self.detailLabel.text = self.movieItem.detail;
        self.image.image = self.movieItem.image;
        [self fetch];
        
    }
}

-(void)fetch {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *string = [self.movieItem.review stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *reviewString = [string stringByAppendingString:@"?apikey=sr9tdu3checdyayjz85mff8j&page_limit=3"];
    
    NSURL *reviewURL = [[NSURL alloc] initWithString:reviewString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:reviewURL];
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        
        self.reviews = [dataDictionary valueForKeyPath:@"reviews"];
        
        for (NSDictionary *dictionary in self.reviews) {
            
            Review *review = [[Review alloc] init];
            
            review.critic = [dictionary objectForKey:@"critic"];
            review.freshness = [dictionary objectForKey:@"freshness"];
            review.date = [dictionary objectForKey:@"date"];
            review.quote = [dictionary objectForKey:@"quote"];
            
            [tempArray addObject:review];
            
        }
        
        self.reviews = tempArray;
        NSLog(@"self dictionary: %@", dataDictionary);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.reviewLabel.text = [[self.reviews firstObject] quote];

        });
        
    }];
    
    [task resume];  
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
