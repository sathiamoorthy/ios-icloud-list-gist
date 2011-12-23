//
//  MasterViewController.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSString *localContainerPath;
@property (strong, nonatomic) NSURL *localContainerURL;
@property (strong, nonatomic) NSURL *ubiquityContainerURL;

@end
