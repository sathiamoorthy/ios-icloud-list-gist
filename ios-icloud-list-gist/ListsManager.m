//
//  ListsManager.h
//  ios-icloud-list-gist
//
//  Created by Brian Hill on 1/4/12.
//

#import "ListsManager.h"
#import "List.h"

@implementation ListsManager

static NSString *SampleFilename = @"List 1.txt";

@synthesize singularDocumentsPath = _singularDocumentsPath;
@synthesize singularDocumentsURL = _singularDocumentsURL;
@synthesize ubiquityDocumentsURL = _ubiquityDocumentsURL;
@synthesize singularDocuments = _singularDocuments;
@synthesize ubiquityDocuments = _ubiquityDocuments;

- (id)init {
    if (nil != (self = [super init])) {
        self.singularDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.singularDocumentsURL = [NSURL fileURLWithPath:self.singularDocumentsPath isDirectory:YES];
        self.ubiquityDocumentsURL = [[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents" isDirectory:YES];
        // discover the non-ubiquity documents
        self.singularDocuments = [self scanForFileNames:self.singularDocumentsURL];
        // discover the ubuiquity documents
        if (nil != self.ubiquityDocumentsURL) {
            self.ubiquityDocuments = [self scanForFileNames:self.ubiquityDocumentsURL];
        } else {
            self.ubiquityDocuments = [NSMutableArray array];
        }
    }
    return self;
}

- (void)createSampleIfNeeded {
    if (0 == [self.singularDocuments count] && 0 == [self.ubiquityDocuments count]) {
        [self documentForFilename:SampleFilename isSingular:YES];
        [self.singularDocuments addObject:SampleFilename];
    }
}

- (NSMutableArray *)scanForFileNames:(NSURL *)documentsURL {
    NSMutableArray *documents = [NSMutableArray array];
    NSError *error;
    NSArray *fileURLs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:documentsURL includingPropertiesForKeys:[NSArray array] options:0 error:&error];
    if (fileURLs != nil) {
        NSEnumerator *e = [fileURLs objectEnumerator];
        NSURL *fileURL;
        while (nil != (fileURL = [e nextObject])) {
            NSString *extension = [fileURL pathExtension];
            if ([@"txt" isEqualToString:extension]) {
                [documents addObject:[fileURL lastPathComponent]];
            }
        }
    } else {
        NSLog(@"Error scanning for documents in directory %@: %@", documentsURL, error);
    }
    return documents;
}

- (List *)documentForFilename:(NSString *)filename isSingular:(BOOL)isSingular {
    NSURL *documentsURL = isSingular ? self.singularDocumentsURL : self.ubiquityDocumentsURL;
    NSURL *fileURL = [documentsURL URLByAppendingPathComponent:filename isDirectory:NO];
    List *detailItem = [[List alloc] initWithFileURL:fileURL];
    NSString *localFilePath = [fileURL path];
    BOOL localFileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
    if (!localFileExists) {
        [detailItem saveToURL:fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [detailItem notifyDelegate];
            }
        }];
    } else {
        [detailItem openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [detailItem notifyDelegate];
            }
        }];
    }
    return detailItem;
}

- (BOOL)downloadFileIfNecessary:(NSString *)fileName {
    NSNumber *isUbiquitous = nil;
    NSURL *ubiquitousFileURL = [self.ubiquityDocumentsURL URLByAppendingPathComponent:fileName];
    if ([ubiquitousFileURL getResourceValue:&isUbiquitous forKey:NSURLIsUbiquitousItemKey error:nil]) {
        // If the item is in iCloud, see if it is downloaded.
        if ([isUbiquitous boolValue]) {
            NSNumber* isDownloaded = nil;
            if ([ubiquitousFileURL getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemIsDownloadedKey error:nil]) {
                if ([isDownloaded boolValue]) {
                    return YES;
                } else {
                    NSFileManager* fm = [NSFileManager defaultManager];
                    [fm startDownloadingUbiquitousItemAtURL:ubiquitousFileURL error:nil];
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (void)moveFileToiCloud:(NSString *)fileName {
    NSURL *sourceURL = [self.singularDocumentsURL URLByAppendingPathComponent:fileName];
    NSURL *destinationURL = [self.ubiquityDocumentsURL URLByAppendingPathComponent:fileName];
    dispatch_queue_t q_default;
    q_default = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q_default, ^(void) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error = nil;
        BOOL success = [fileManager setUbiquitous:YES itemAtURL:sourceURL destinationURL:destinationURL error:&error];
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_main, ^(void) {
            if (success) {
                [self.ubiquityDocuments addObject:fileName];
                [self.singularDocuments removeObject:fileName];
                NSLog(@"Moved file to cloud: %@", fileName);
            }
            if (!success) {
                NSLog(@"Couldn't move file to iCloud: %@, %@", fileName, error);
            }
        });
    });
}

@end
