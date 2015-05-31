//
//  ViewController.m
//  RottenMangoes
//
//  Created by Ian Tsai on 2015-05-27.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "Theater.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL initialLocation;

@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) CLPlacemark *placemark;

@property (nonatomic, strong) NSString *postalCode;

@property (nonatomic, strong) Movie *movie;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.initialLocation = NO;
    
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    
//    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D ianApartmentLocation;
//    ianApartmentLocation.latitude = 49.202955;
//    ianApartmentLocation.longitude = -122.915554;
//    marker.coordinate = ianApartmentLocation;
//    marker.title = @"My apartment";
    
//    [self.mapView addAnnotation:marker];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
   
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMovieItem:(Movie *)movie {
    if (_movie != movie) {
        _movie = movie;
        

    }
}

-(void)loadTheater:(NSString *)postalcode {
    
    NSString *movieTitle = [self.movie.title stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@", postalcode, movieTitle];
    
    NSLog(@"%@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSLog(@"%@", dataDictionary);
        
        self.theaterArray = [dataDictionary valueForKeyPath:@"theatres"];
        
        for (NSDictionary *dictionary in self.theaterArray) {
            
            Theater *theater = [[Theater alloc] init];
            theater.name = [dictionary objectForKey:@"name"];
            theater.lat = [[dictionary objectForKey:@"lat"] floatValue];
            theater.lng = [[dictionary objectForKey:@"lng"] floatValue];
            theater.address = [dictionary objectForKey:@"address"];
            theater.image = [theater theaterName];
            
            [tempArray addObject:theater];
            
        }
        
        self.theaterArray = tempArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self configure];
            
        });
        
    }];
    
    [task resume];
    
}


#pragma CLlocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Got error %@", [error localizedDescription]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations firstObject];
    
    
    if (!self.initialLocation) {
        MKCoordinateRegion startingRegion;
        CLLocationCoordinate2D loc = location.coordinate;
        startingRegion.center = loc;
        startingRegion.span.latitudeDelta = 0.02;
        startingRegion.span.longitudeDelta = 0.02;
        [self.mapView setRegion:startingRegion];
        
        self.initialLocation = YES;
        
    }
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks firstObject];
            
            NSLog(@"postal code %@", self.postalCode);
            NSLog(@"placemark postalcode %@", self.placemark.postalCode);
            
            [self loadTheater:self.placemark.postalCode];
            
        }
    }];
    
}

-(void)configure {
   
    for (Theater *theater in self.theaterArray) {
        
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(theater.lat, theater.lng);
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate: centerCoordinate];
        [annotation setTitle:theater.name];

        [self.mapView addAnnotation:annotation];
    }
    
}

#pragma MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    NSArray *imageArray = @[
                            [UIImage imageNamed:@"cineplex.jpg"],
                            [UIImage imageNamed:@"landmark.jpg"],
                            [UIImage imageNamed:@"scotiabank.png"],
                            [UIImage imageNamed:@"silvercity.png"]
                            ];
    
    if (annotation == self.mapView.userLocation) {
        return nil;
    }
    
    static NSString *annotationIdentifier = @"theaterIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
 
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.calloutOffset = CGPointMake(-7, 0);
    
    if ([annotation.title containsString:@"Cineplex"]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[0]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [pinView addSubview:imageView];
    
    }
    else if ([annotation.title containsString:@"Landmark"]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[1]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [pinView addSubview:imageView];
    
    }
    else if ([annotation.title containsString:@"Scotiabank"]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[2]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [pinView addSubview:imageView];
    
    }
    else if ([annotation.title containsString:@"SilverCity"]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[3]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [pinView addSubview:imageView];
    
    }
    else {
        
        return nil;
        
    }
    
    
    
//    pinView.image = theater.image;
    
    return pinView;
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Click" message:@"You Done Clicked" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];
}


@end
