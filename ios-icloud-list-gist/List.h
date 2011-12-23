//
//  List.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface List : UIDocument

@property (strong) NSString *text;
@property (weak) DetailViewController *listDelegate;

- (id)initWithFileURL:(NSURL *)url listDelegate:(id)listDelegate;

@end
