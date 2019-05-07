//
//  EQTableViewCell.h
//  EarthQuake
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EQTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mPlace;
@property (weak, nonatomic) IBOutlet UILabel *mType;
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mMagnitude;

@end

NS_ASSUME_NONNULL_END
