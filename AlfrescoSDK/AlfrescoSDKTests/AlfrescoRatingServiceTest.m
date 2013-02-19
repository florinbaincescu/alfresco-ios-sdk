/*******************************************************************************
 * Copyright (C) 2005-2013 Alfresco Software Limited.
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

#import "AlfrescoRatingServiceTest.h"
#import "AlfrescoRepositoryCapabilities.h"

@implementation AlfrescoRatingServiceTest
@synthesize ratingService = _ratingService;
/*
 */
/*
 @Unique_TCRef 12S1
 */

- (void)testRetrieveLikeCount
{
    
    [super runAllSitesTest:^{
        
        AlfrescoRepositoryCapabilities *capabilities = super.currentSession.repositoryInfo.capabilities;
        if (capabilities.doesSupportLikingNodes)
        {
            self.ratingService = [[AlfrescoRatingService alloc] initWithSession:super.currentSession];
            // get like count
            [self.ratingService retrieveLikeCountForNode:super.testAlfrescoDocument completionBlock:^(NSNumber *count, NSError *error)
             {
                 if (nil == count)
                 {
                     super.lastTestSuccessful = NO;
                     super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                 }
                 else
                 {
                     STAssertTrue([count intValue] == 0, @"Retrieve like count: expected like count of 0 but got count %d",[count intValue]);
                     super.lastTestSuccessful = YES;
                 }
                 super.callbackCompleted = YES;
             }];
            [super waitUntilCompleteWithFixedTimeInterval];
            STAssertTrue(super.lastTestSuccessful, super.lastTestFailureMessage);
        }
        else
        {
            super.lastTestSuccessful = YES;
        }
        
    }];
}

/*
 @Unique_TCRef 37S1
 @Unique_TCRef 38S1,38S2
 @Unique_TCRef 12S1
 */
- (void)testLikeAndUnlike
{
    [super runAllSitesTest:^{
        AlfrescoRepositoryCapabilities *capabilities = super.currentSession.repositoryInfo.capabilities;
        if (capabilities.doesSupportLikingNodes)
        {
            self.ratingService = [[AlfrescoRatingService alloc] initWithSession:super.currentSession];
            
            // get like count
            [self.ratingService likeNode:super.testAlfrescoDocument completionBlock:^(BOOL success, NSError *error)
             {
                 if (!success)
                 {
                     super.lastTestSuccessful = NO;
                     super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                     super.callbackCompleted = YES;
                 }
                 else
                 {
                     [self.ratingService retrieveLikeCountForNode:super.testAlfrescoDocument completionBlock:^(NSNumber *count, NSError *error)
                      {
                          if (nil == count)
                          {
                              super.lastTestSuccessful = NO;
                              super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                              super.callbackCompleted = YES;
                          }
                          else
                          {
                              STAssertTrue([count intValue] == 1, @"Retrieve like count: expected like count of 1 but got count %d",[count intValue]);
                              
                              [self.ratingService unlikeNode:super.testAlfrescoDocument completionBlock:^(BOOL success, NSError *error)
                               {
                                   
                                   if (!success)
                                   {
                                       super.lastTestSuccessful = NO;
                                       super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                                       super.callbackCompleted = YES;
                                   }
                                   else
                                   {
                                       [self.ratingService retrieveLikeCountForNode:super.testAlfrescoDocument completionBlock:^(NSNumber *count, NSError *error)
                                        {
                                            if (nil == count)
                                            {
                                                super.lastTestSuccessful = NO;
                                                super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                                            }
                                            else
                                            {
                                                STAssertTrue([count intValue] == 0, @"Retrieve like count: expected like count of 0 but got count %d", [count intValue]);
                                                super.lastTestSuccessful = YES;
                                            }
                                            super.callbackCompleted = YES;
                                        }];
                                   }
                                   
                               }];
                          }
                          
                      }];
                 }
                 
                 
             }];
            
            [super waitUntilCompleteWithFixedTimeInterval];
            STAssertTrue(super.lastTestSuccessful, super.lastTestFailureMessage);
        }
        else
        {
            super.lastTestSuccessful = YES;
        }
    }];
}

/*
 @Unique_TCRef 37S1
 @Unique_TCRef 38S2/S1
 @Unique_TCRef 39S1, 39S3
 */
- (void)testIsNodeLiked
{
    [super runAllSitesTest:^{
        
        AlfrescoRepositoryCapabilities *capabilities = super.currentSession.repositoryInfo.capabilities;
        if (capabilities.doesSupportLikingNodes)
        {
            self.ratingService = [[AlfrescoRatingService alloc] initWithSession:super.currentSession];
            
            // get like count
            [self.ratingService isNodeLiked:super.testAlfrescoDocument completionBlock:^(BOOL succeeded, BOOL isLiked, NSError *error)
             {
                 if (!succeeded)
                 {
                     super.lastTestSuccessful = NO;
                     super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                     super.callbackCompleted = YES;
                 }
                 else
                 {
                     STAssertFalse(isLiked, @"expected false");
                     
                     [self.ratingService likeNode:super.testAlfrescoDocument completionBlock:^(BOOL success, NSError *error)
                      {
                          
                          if (!success)
                          {
                              super.lastTestSuccessful = NO;
                              super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                              super.callbackCompleted = YES;
                          }
                          else
                          {
                              [self.ratingService isNodeLiked:super.testAlfrescoDocument completionBlock:^(BOOL succeeded, BOOL isLiked, NSError *error)
                               {
                                   if (!succeeded)
                                   {
                                       super.lastTestSuccessful = NO;
                                       super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                                       super.callbackCompleted = YES;
                                   }
                                   else
                                   {
                                       STAssertTrue(succeeded, @"expected true");
                                       
                                       [self.ratingService unlikeNode:super.testAlfrescoDocument completionBlock:^(BOOL success, NSError *error)
                                        {
                                            
                                            if (!success)
                                            {
                                                super.lastTestSuccessful = NO;
                                                super.lastTestFailureMessage = [NSString stringWithFormat:@"%@ - %@", [error localizedDescription], [error localizedFailureReason]];
                                            }
                                            else
                                            {
                                                super.lastTestSuccessful = YES;
                                            }
                                            super.callbackCompleted = YES;
                                            
                                        }];
                                   }
                                   
                               }];
                          }
                          
                      }];
                 }
                 
             }];
            
            [super waitUntilCompleteWithFixedTimeInterval];
            STAssertTrue(super.lastTestSuccessful, super.lastTestFailureMessage);
        }
        else
        {
            super.lastTestSuccessful = YES;
        }
    }];
}


@end
