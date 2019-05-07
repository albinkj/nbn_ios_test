//
//  EQlistingViewController.m
//  EarthQuake
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import "EQlistingViewController.h"
#import "AFHTTPSessionManager.h"
#import "EQMapViewController.h"
#import "EQTableViewCell.h"


#define URL @"https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
#define FEATURES @"features"

#define EQTABLECELL_IDENTIFIER @"EQTableViewCell"
#define EQTMAPVIEW_IDENTIFIER @"EQMapViewController"

#define CELL_HEIGHT 100

#define EQPROPERTIES @"properties"
#define EQPLACE @"place"
#define EQTYPE @"type"
#define EQTIME @"time"
#define EQMAGNITUDE @"mag"


@interface EQlistingViewController ()
{
    NSArray* mEQdDetailsArray;
}

@property (weak, nonatomic) IBOutlet UITableView *mEQListingTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *mNoDataLabel;

@end

@implementation EQlistingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setData];
   
}

-(void)setData
{
    [_mNoDataLabel setHidden:true];
    [_mActivityIndicator setHidden:false];
    [_mEQListingTable setHidden:true];
    [_mActivityIndicator startAnimating];
    [self getDataFromServer:^(NSDictionary* result) {
        self->mEQdDetailsArray = [[NSArray alloc]initWithArray:[result valueForKey:FEATURES]];
        NSLog(@"deatils :- %@",self->mEQdDetailsArray);
        [self->_mEQListingTable reloadData];
        [self->_mEQListingTable setHidden:false];
        [self->_mActivityIndicator setHidden:true];
        [self->_mActivityIndicator stopAnimating];
    } failure:^(NSError* error) {
        [self->_mNoDataLabel setHidden:false];
        [self->_mActivityIndicator setHidden:true];
        [self->_mActivityIndicator stopAnimating];
    }];
}

/**
 Get earthquake details from the server.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:completionHandler:
 */
-(void)getDataFromServer:(void (^)(NSDictionary* result))success failure:(void (^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(nil);
    }];
}

#pragma TableViewDelegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mEQdDetailsArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQTableViewCell *cell = (EQTableViewCell*)[tableView dequeueReusableCellWithIdentifier:EQTABLECELL_IDENTIFIER];
    
    NSString* place = [[[mEQdDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    NSString* type = [[[mEQdDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTYPE];
    double time = [[[[mEQdDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTIME] doubleValue];
    NSString* magnitude = [[[[mEQdDetailsArray objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQMAGNITUDE] stringValue];

    cell.mPlace.text = place;
    cell.mType.text = type;
    cell.mTime.text = [self getTime:time];
    cell.mMagnitude.text = [NSString stringWithFormat:@"Magnitude : %@", magnitude];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self performSegueWithIdentifier:EQTMAPVIEW_IDENTIFIER sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EQTMAPVIEW_IDENTIFIER])
    {
//        EQMapViewController *pDetailViewController = segue.destinationViewController;
//        NSIndexPath* pIndexPath = (NSIndexPath*)sender;
//        pDetailViewController.mpLoanDetails =  [mpResultArray objectAtIndex:pIndexPath.row];
    }
}

-(NSString*)getTime:(double)timeStamp
{
    NSTimeInterval timeInterval=timeStamp/1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd/MM/yyy hh:mm a"];
    NSString *dateString=[dateformatter stringFromDate:date];
    return dateString;
}


@end
