//
//  DetailViewController.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@class List;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, ListDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
