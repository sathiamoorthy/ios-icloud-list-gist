//
//  List.m
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 12/14/11.
//
// http://developer.apple.com/library/ios/#documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html

#import "List.h"

@implementation List

@synthesize text = _text;
@synthesize delegate = _delegate;

- (id)initWithFileURL:(NSURL *)url {
    return [super initWithFileURL:url];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
    if ([contents length] > 0) {
        self.text = [[NSString alloc] initWithData:contents encoding:NSUTF8StringEncoding];
    } else {
        self.text = @"Wheaties";
    }
    
    [self.delegate contentsUpdated:self];
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
    [self.delegate disableEditing:self];
}

- (void)enableEditing {
    [self.delegate enableEditing:self];
}

- (void)notifyDelegate {
    [self.delegate contentsUpdated:self];
}

@end
