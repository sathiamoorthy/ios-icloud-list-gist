//
//  List.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//

#import <UIKit/UIKit.h>

@protocol ListDelegate;

@interface List : UIDocument

@property (nonatomic, strong) NSString *text;
@property (nonatomic, weak) id <ListDelegate> delegate;

- (id)initWithFileURL:(NSURL *)url;
- (void)notifyDelegate;

@end

@protocol ListDelegate <NSObject>

@required
- (void)disableEditing:(List *)sender;
- (void)enableEditing:(List *)sender;
- (void)contentsUpdated:(List *)sender;

@end