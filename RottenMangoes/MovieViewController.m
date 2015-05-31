//
//  MovieViewController.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    NSURL *movies = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=1"];
    
//    NSData *urlData = [NSData dataWithContentsOfURL:movies];
    
//    NSError *error = nil;
    
//    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:movieURL options:0 error:&error];
//
//    NSLog(@"%@", dataDictionary);
//    
//    NSArray *dataArray = [dataDictionary objectForKey:@"movies"];
//    
//    for (NSDictionary *dictionary in dataArray) {
//        Movie *movie = [[Movie alloc] initWithTitle:[dictionary objectForKey:@"title"] detail:[dictionary objectForKey:@"synopsis"] review:[dictionary objectForKey:@"audience_score"] image:[dictionary objectForKey:@"thumbnail"]];
//        
//        [self.movies addObject:movie];
//    }
//    
//    NSLog(@"%@", self.movies);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *movieURL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=3"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:movieURL];
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        
        self.movies = [dataDictionary valueForKeyPath:@"movies"];
        
        for (NSDictionary *dictionary in self.movies) {
            
            Movie *movie = [[Movie alloc] initWithTitle:[dictionary objectForKey:@"title"] detail:[dictionary objectForKey:@"synopsis"] review:[[dictionary objectForKey:@"links"] objectForKey:@"reviews" ] image:[[dictionary objectForKey:@"posters"] objectForKey:@"thumbnail"]];
            
            [tempArray addObject:movie];
        }
        
        self.movies = tempArray;
        NSLog(@"self dictionary: %@", dataDictionary);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    
    }];
    
    [task resume];
    
    
    
    
    
    
    
 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        Movie *movie = self.movies[indexPath.row];
        [[segue destinationViewController] setMovieItem:movie];
        
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    
    cell.movieTitle.text = movie.title;
    
    [cell configureImage:movie];

    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
