/*******************************************************************************
 * Copyright (C) 2005-2012 Alfresco Software Limited.
 * 
 * This file is part of the Alfresco Mobile SDK.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *  
 *  http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ******************************************************************************/

#import "AlfrescoBaseTest.h"
#import "AlfrescoContentFile.h"

NSString * const kAlfrescoTestDataFolder = @"SDKTestDataFolder";

@interface AlfrescoBaseTest ()
@property (nonatomic, strong) NSString * testPassword;
- (void) uploadTestDocument:(NSString *)filePath;
- (void) removeTestDocument;
- (void) resetTestRunVariables;
- (void) parseEnvironmentDictionary:(NSDictionary *)plistDictionary;
+ (NSString *)testFileNameFromEnviroment:(NSString *)filename;
- (void) setUpTestImageFile:(NSString *)filePath;
- (void) setUpTestChildFolder;
@end

@implementation AlfrescoBaseTest

@synthesize isCloud = _isCloud;
@synthesize callbackCompleted = _callbackCompleted;
@synthesize lastTestSuccessful = _lastTestSuccessful;
@synthesize lastTestFailureMessage = _lastTestFailureMessage;
@synthesize testAlfrescoDocument = _testAlfrescoDocument;
@synthesize alfrescoDocumentFolderService = _alfrescoDocumentFolderService;
@synthesize currentRootFolder = _currentRootFolder;
@synthesize testDocFolder = _testDocFolder;
@synthesize currentSession = _currentSession;
@synthesize userName = _userName;
@synthesize firstName = _firstName;
@synthesize testSiteName = _testSiteName;
@synthesize server = _server;
@synthesize testPassword = _testPassword;
@synthesize testSearchFileName = _testSearchFileName;
@synthesize textKeyWord = _textKeyWord;
@synthesize unitTestFolder = _unitTestFolder;
@synthesize testChildFolder = _testChildFolder;
@synthesize testChildFolderName = _testChildFolderName;
@synthesize testFolderPathName = _testFolderPathName;
@synthesize fixedFileName = _fixedFileName;
@synthesize testImageFile = _testImageFile;
#pragma mark unit test internal methods


+ (NSString *)testFileNameFromEnviroment:(NSString *)filename
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd'T'HH-mm-ss-Z'"];
    NSString *newName = [filename stringByReplacingOccurrencesOfString:@".txt" withString:[formatter stringFromDate:[NSDate date]]];
    return [NSString stringWithFormat:@"%@.txt",newName]; 
}


- (void) uploadTestDocument:(NSString *)filePath
{
    __block NSURL *fileUrl = [NSURL URLWithString:filePath];

    __block NSString *newName = [AlfrescoBaseTest testFileNameFromEnviroment:[fileUrl lastPathComponent]];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    __block AlfrescoContentFile *textContentFile = [[AlfrescoContentFile alloc] initWithData:fileData mimeType:@"text/plain"];

    AlfrescoDocumentFolderService *docFolderService = [[AlfrescoDocumentFolderService alloc] initWithSession:self.currentSession];
    [docFolderService createDocumentWithName:newName
                              inParentFolder:self.testDocFolder
                                 contentFile:textContentFile
                                  properties:nil
                             completionBlock:^(AlfrescoDocument *document, NSError *error){
                                 if (nil == document)
                                 {
                                     log(@"We failed uploading the document with name %@",newName);
                                     self.lastTestSuccessful = NO;
                                     self.lastTestFailureMessage = [NSString stringWithFormat:@"Could not upload test document. Error %@",[error localizedDescription]];
                                 }
                                 else
                                 {
                                     STAssertNotNil(document, @"document should not be nil");
                                     self.lastTestSuccessful = YES;
                                     self.testAlfrescoDocument = document;
                                     log(@"<<<<< Test Document nodeID is %@ >>>>>>",document.identifier);
                                     if (!self.isCloud)
                                     {
                                         self.testSearchFileName = self.testAlfrescoDocument.name;
                                     }
                                 }
                                 self.callbackCompleted = YES;
                             }
                               progressBlock:^(NSInteger bytesTransferred, NSInteger bytesTotal){}];
    [self waitForCompletion:15];
    STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
    STAssertTrue(self.lastTestSuccessful, @"uploadTestDocument failed");
}

- (void) removeTestDocument
{
    if (nil == self.testAlfrescoDocument)
    {
        return;
    }
    AlfrescoDocumentFolderService *docFolderService = [[AlfrescoDocumentFolderService alloc] initWithSession:self.currentSession];
    [docFolderService deleteNode:self.testAlfrescoDocument completionBlock:^(BOOL succeeded, NSError *error){
        if (!succeeded)
        {
            log(@"We failed to delete the document on the server");
            self.lastTestSuccessful = NO;
            self.lastTestFailureMessage = [NSString stringWithFormat:@"Could not delete test document. Error %@",[error localizedDescription]];
        }
        else
        {
            log(@"We succeeded to delete the document on the server");
            self.lastTestSuccessful = YES;
        }
        self.callbackCompleted = YES;
    }];
    
    [self waitForCompletion:15];
    STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
    STAssertTrue(self.lastTestSuccessful, @"removeTestDocument failed");
    self.testAlfrescoDocument = nil;
}



- (void)authenticateOnPremiseServer
{
    [AlfrescoRepositorySession connectWithUrl:[NSURL URLWithString:self.server]
                                     username:self.userName
                                     password:self.testPassword
                                     parameters:nil
                              completionBlock:^(id<AlfrescoSession> session, NSError *error){
                                  if (nil == session)
                                  {
                                      self.lastTestSuccessful = NO;
                                      self.lastTestFailureMessage = [NSString stringWithFormat:@"Session could not be authenticated. Error %@",[error localizedDescription]];
                                  }
                                  else
                                  {
                                      self.currentSession = nil;
                                      STAssertNotNil(session,@"Session should not be nil");
                                      self.lastTestSuccessful = YES;
                                      self.currentSession = session;
                                  }
                                  self.callbackCompleted = YES;
    }];
    
    
    [self waitForCompletion:15];
    STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
    STAssertTrue(self.lastTestSuccessful, @"OnPremise Session authentication failed");
}


- (void)authenticateCloudServer
{
    log(@"In authenticateCloudServer");
    [AlfrescoCloudSession connectWithEmailAddress:self.userName
                                         password:self.testPassword
                                           apiKey:nil
                                       parameters:nil
                                  completionBlock:^(id<AlfrescoSession> cloudSession, NSError *error){
        if (nil == cloudSession)
        {
            log(@"AlfrescoBaseTest::authenticateCloudServer - cloudSession returns NIL");
            self.lastTestSuccessful = NO;
            self.lastTestFailureMessage = [NSString stringWithFormat:@"Cloud session could not be authenticated. Error %@",[error localizedDescription]];
        }
        else
        {
            self.currentSession = nil;
            STAssertNotNil(cloudSession, @"Cloud session should not be nil");
            log(@"AlfrescoBaseTest::authenticateCloudServer - cloudSession returns **NOT** NIL");
            self.lastTestSuccessful = YES;
            self.currentSession = cloudSession;
        }
        self.callbackCompleted = YES;
    }];

    [self waitForCompletion:15];
    STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
    STAssertTrue(self.lastTestSuccessful, @"Cloud authentication failed");
}





- (void)retrieveAlfrescoTestFolder
{
         
    if (self.isCloud)
    {
        STAssertTrue([self.currentSession isKindOfClass:[AlfrescoCloudSession class]], @"expected cloud session");
        AlfrescoSiteService *siteService = [[AlfrescoSiteService alloc] initWithSession:self.currentSession];
        [siteService retrieveDocumentLibraryFolderForSite:self.testSiteName completionBlock:^(AlfrescoFolder *folder, NSError *error){
            if (nil == folder)
            {
                log(@"AlfrescoBaseTest::retrieveAlfrescoTestFolder - documentLibrary folder for cloud returns nil");
                self.lastTestSuccessful = NO;
                self.lastTestFailureMessage = [NSString stringWithFormat:@"Could not get the root folder in the DocLib for site %@. Error %@",self.testSiteName, [error localizedDescription]];
            }
            else
            {
                STAssertNotNil(folder, @"DocLib root folder should not be nil");
                self.lastTestSuccessful = YES;
                self.testDocFolder = folder;
            }
            self.callbackCompleted = YES;
        }];
        [self waitForCompletion:15];
        STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
        STAssertTrue(self.lastTestSuccessful, @"Cloud authentication failed");
    }
    else
    {
        STAssertTrue([self.currentSession isKindOfClass:[AlfrescoRepositorySession class]], @"expected OnPremise session");
        self.testDocFolder = self.currentSession.rootFolder;
    }
}

- (void) setUpTestChildFolder
{
    if (self.isCloud)
    {
        AlfrescoDocumentFolderService *docService = [[AlfrescoDocumentFolderService alloc] initWithSession:self.currentSession];
        NSString *folderPath = [NSString stringWithFormat:@"%@%@",self.testFolderPathName, self.testChildFolderName];
        [docService retrieveNodeWithFolderPath:folderPath completionBlock:^(AlfrescoNode *node, NSError *error){
            if (nil == node)
            {
                log(@"AlfrescoBaseTest::retrieveAlfrescoTestFolder - couldn't find node in path %@",folderPath);
                self.lastTestSuccessful = NO;
                self.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
            }
            else
            {
                STAssertNotNil(node, @"node should not be nil");
                self.lastTestSuccessful = YES;
                self.testChildFolder = (AlfrescoFolder *)node;
                
            }
            self.callbackCompleted = YES;
        }];
        [self waitForCompletion:15];
        STAssertTrue(self.callbackCompleted, @"TIMED OUT: test returned before callback was complete");
        STAssertTrue(self.lastTestSuccessful, @"setUpTestChildFolder failed");
    }
    else
    {
        self.testChildFolder = self.currentSession.rootFolder;
    }
}


- (void) parseEnvironmentDictionary:(NSDictionary *)plistDictionary
{
    self.server = nil;
    self.userName = nil;
    self.firstName = nil;
    self.testPassword = nil;
    self.testSiteName = nil;
    self.testSearchFileName = nil;
    self.textKeyWord = nil;
    self.unitTestFolder = nil;
    self.fixedFileName = nil;
    self.testChildFolderName = nil;
    self.testFolderPathName = nil;
    
    self.server = [plistDictionary valueForKey:@"server"];
    self.userName = [plistDictionary valueForKey:@"username"];
    self.firstName = [plistDictionary valueForKey:@"firstName"];
    self.testSiteName = [plistDictionary valueForKey:@"testSite"];
    self.testPassword = [plistDictionary valueForKey:@"password"];
    self.testSearchFileName = [plistDictionary valueForKey:@"testSearchFile"];
    self.textKeyWord = [plistDictionary valueForKey:@"textKeyWord"];
    self.unitTestFolder = [plistDictionary valueForKey:@"testAddedFolder"];
    self.isCloud = [self.server isEqualToString:@"http://devapis.alfresco.com"];
    self.testChildFolderName= [plistDictionary valueForKey:@"testChildFolder"];
    self.fixedFileName = [plistDictionary valueForKey:@"fixedFileName"];
    self.testFolderPathName = [plistDictionary valueForKey:@"docFolder"];
}

- (void) runAllSitesTest:(AlfrescoTestBlock)sessionTestBlock
{
    for (NSBundle *bundle in [NSBundle allBundles]) {
        if([NSBundle mainBundle] != bundle)
        {
            
            NSString *envsPListPath = [bundle pathForResource:@"environments" ofType:@"plist"];
            NSString *testFilePath = [bundle pathForResource:@"test_file.txt" ofType:nil];
            NSString *testImagePath = [bundle pathForResource:@"millenium-dome.jpg" ofType:nil];
            log(@"test file path is %@",testFilePath);
            NSDictionary *environmentsDict = [[NSDictionary alloc] initWithContentsOfFile:envsPListPath];
            NSArray *environmentArray = [environmentsDict objectForKey:@"environments"];
            
            for (NSDictionary *environmentDict in environmentArray)
            {
                [self parseEnvironmentDictionary:environmentDict];

                if (self.isCloud)
                {
                    log(@"Should be Cloud Server with server: %@, username: %@, password: %@",self.server, self.userName, self.testPassword);
                    [self authenticateCloudServer];
                    [self resetTestRunVariables];
                }
                else
                {
                    log(@"Should be OnPremise Server with server: %@, username: %@, password: %@",self.server, self.userName, self.testPassword);
                    self.isCloud = NO;
                    [self authenticateOnPremiseServer];
                    [self resetTestRunVariables];
                }
                
                [self retrieveAlfrescoTestFolder];
                [self resetTestRunVariables];
                

                [self uploadTestDocument:testFilePath];
                [self resetTestRunVariables];
                
                [self setUpTestImageFile:testImagePath];
                [self resetTestRunVariables];
                
                [self setUpTestChildFolder];
                [self resetTestRunVariables];

                sessionTestBlock();
                
                [self removeTestDocument];
                [self resetTestRunVariables];
            }
            
            
        }
    }    
}

- (void)setUpTestImageFile:(NSString *)filePath
{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    AlfrescoContentFile *textContentFile = [[AlfrescoContentFile alloc] initWithData:fileData mimeType:@"image/jpeg"];
    self.testImageFile = textContentFile;
}

- (void) resetTestRunVariables
{
    self.callbackCompleted = NO;
    self.lastTestSuccessful = NO;
    self.lastTestFailureMessage = @"Test failed in runAllSitesTest method";
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!self.callbackCompleted);
    
    return self.callbackCompleted;
}




@end