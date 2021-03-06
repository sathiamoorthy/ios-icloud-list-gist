//
//  ListsManager.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 1/4/12.
//

#import <UIKit/UIKit.h>

@class List;

@interface ListsManager : NSObject

@property (strong, nonatomic) NSString *singularDocumentsPath;
@property (strong, nonatomic) NSURL *singularDocumentsURL;
@property (strong, nonatomic) NSURL *ubiquityDocumentsURL; // may be nil, indicating iCloud is unavailable
@property (strong, nonatomic) NSMutableArray *singularDocuments;
@property (strong, nonatomic) NSMutableArray *ubiquityDocuments;

- (NSMutableArray *)scanForFilenames:(NSURL *)documentsURL;
- (List *)documentForFilename:(NSString *)filename isSingular:(BOOL)isSingular;
- (void)createSamplesIfNeeded;

@end
