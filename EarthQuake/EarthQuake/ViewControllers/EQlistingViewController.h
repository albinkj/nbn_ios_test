//
//  EQlistingViewController.h
//  EarthQuake
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EQlistingViewController : UIViewController

@property (strong, nonatomic) NSArray* mEQdDetailsArray;
-(void)setData;
-(NSString*)getTime:(double)timeStamp;

@end

