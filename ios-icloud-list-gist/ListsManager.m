//
//  ListsManager.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 1/4/12.
//

#import "ListsManager.h"

@implementation ListsManager

static NSString *SampleFilename = @"List 1.txt";

@synthesize singularDocumentsPath = _singularDocumentsPath;
@synthesize singularDocumentsURL = _singularDocumentsURL;
@synthesize ubiquityDocumentsURL = _ubiquityDocumentsURL;

- (id)init {
    if (nil != (self = [super init])) {
        self.singularDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.singularDocumentsURL = [NSURL fileURLWithPath:self.singularDocumentsPath isDirectory:YES];
        self.ubiquityDocumentsURL = [[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents" isDirectory:YES];
    }
    return self;
}

@end
