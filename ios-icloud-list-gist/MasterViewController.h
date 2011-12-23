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
@property (strong, nonatomic) NSString *localDocumentsPath;
@property (strong, nonatomic) NSURL *localDocumentsURL;
@property (strong, nonatomic) NSURL *ubiquitousDocumentsURL;

@end
