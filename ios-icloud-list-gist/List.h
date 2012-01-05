//
//  List.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface List : UIDocument

@property (nonatomic, strong) NSString *text;
// THE FOLLOWING IS BOGUS (THAT THE LIST KNOWS ABOUT THE DETAILVIEWCONTROLLER API)
// NEED TO CREATE A SEPARATE DELEGATE PROTOCOL
@property (nonatomic, weak) DetailViewController *delegate;

- (id)initWithFileURL:(NSURL *)url;
- (void)notifyDelegate;

@end
