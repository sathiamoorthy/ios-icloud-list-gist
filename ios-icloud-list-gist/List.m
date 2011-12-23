//
//  List.m
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//
// http://developer.apple.com/library/ios/#documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html

#import "List.h"
#import "DetailViewController.h"

@implementation List

@synthesize text = _text;
@synthesize listDelegate = _listDelegate;

- (id)initWithFileURL:(NSURL *)url listDelegate:(DetailViewController *)listDelegate {
    self.listDelegate = listDelegate;
    return [super initWithFileURL:url];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
    if ([contents length] > 0) {
        self.text = [[NSString alloc] initWithData:contents encoding:NSUTF8StringEncoding];
    } else {
        self.text = @"Wheaties";
    }
    
    [self.listDelegate contentsUpdated:self];
    return TRUE;
}

- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
    if (self.text == nil) {
        return [@"" dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        return [self.text dataUsingEncoding:NSUTF8StringEncoding];
    }
}

- (void)disableEditing {
    [self.listDelegate disableEditing:self];
}

- (void)enableEditing {
    [self.listDelegate enableEditing:self];
}

@end
