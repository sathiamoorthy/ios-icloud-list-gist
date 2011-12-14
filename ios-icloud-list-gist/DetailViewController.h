//
//  DetailViewController.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
