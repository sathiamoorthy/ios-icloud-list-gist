//
//  ListsManager.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 1/4/12.
//

#import <UIKit/UIKit.h>

@interface ListsManager : NSObject

@property (strong, nonatomic) NSString *singularDocumentsPath;
@property (strong, nonatomic) NSURL *singularDocumentsURL;
@property (strong, nonatomic) NSURL *ubiquityDocumentsURL;

@end
