//
//  EQMapViewController.h
//  EarthQuake
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface EQMapViewController :  UIViewController <MKMapViewDelegate>

@property (weak, nonatomic)  NSDictionary *mEQdeatils;

@end

