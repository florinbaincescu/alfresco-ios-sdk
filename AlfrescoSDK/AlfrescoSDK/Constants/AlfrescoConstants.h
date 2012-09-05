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
/** The AlfrescoErrors error definitions for Mobile SDK.
 
 Author: Peter Schmidt (Alfresco)
 */

#import <Foundation/Foundation.h>
#import "AlfrescoPagingResult.h"
#import "AlfrescoListingContext.h"
#import "AlfrescoContentFile.h"
#import "AlfrescoPermissions.h"
#import "AlfrescoPerson.h"
#import "AlfrescoSite.h"
#import "AlfrescoNode.h"
#import "AlfrescoDocument.h"
#import "AlfrescoCloudSignupRequest.h"
#import "AlfrescoComment.h"

@protocol AlfrescoSession;

/**
 Block definitions
 */
typedef void (^AlfrescoArrayCompletionBlock)(NSArray *array, NSError *error);
typedef void (^AlfrescoBOOLCompletionBlock)(BOOL succeeded, NSError *error);
typedef void (^AlfrescoNumberCompletionBlock)(NSNumber *count, NSError *error);
typedef void (^AlfrescoURLCompletionBlock)(NSURL *url, NSError *error);
typedef void (^AlfrescoDataCompletionBlock)(NSData *data, NSError *error);
typedef void (^AlfrescoFolderCompletionBlock)(AlfrescoFolder *folder, NSError *error);
typedef void (^AlfrescoNodeCompletionBlock)(AlfrescoNode *node, NSError *error);
typedef void (^AlfrescoDocumentCompletionBlock)(AlfrescoDocument *document, NSError *error);
typedef void (^AlfrescoPagingResultCompletionBlock)(AlfrescoPagingResult *pagingResult, NSError *error);
typedef void (^AlfrescoProgressBlock)(NSInteger bytesTransferred, NSInteger bytesTotal);
typedef void (^AlfrescoContentFileCompletionBlock)(AlfrescoContentFile *contentFile, NSError *error);
typedef void (^AlfrescoPermissionsCompletionBlock)(AlfrescoPermissions *permissions, NSError *error);
typedef void (^AlfrescoPersonCompletionBlock)(AlfrescoPerson *person, NSError *error);
typedef void (^AlfrescoSiteCompletionBlock)(AlfrescoSite *site, NSError *error);
typedef void (^AlfrescoCloudSignupRequestCompletionBlock)(AlfrescoCloudSignupRequest *signupRequest, NSError *error);
typedef void (^AlfrescoSessionCompletionBlock)(id<AlfrescoSession> session, NSError *error);
typedef void (^AlfrescoCommentCompletionBlock)(AlfrescoComment *comment, NSError *error);


/**
 Session parameter constants
 */
extern NSString * const kAlfrescoMetadataExtraction;
extern NSString * const kAlfrescoThumbnailCreation;
extern NSString * const kAlfrescoThumbnailRenditionFromAPI;

extern NSString * const kAlfrescoOnPremiseActivityStreamServiceExtension;
extern NSString * const kAlfrescoOnPremiseRatingServiceExtension;
extern NSString * const kAlfrescoOnPremiseSiteServiceExtension;
extern NSString * const kAlfrescoOnPremiseCommentServiceExtension;
extern NSString * const kAlfrescoOnPremiseTaggingServiceExtension;
extern NSString * const kAlfrescoOnPremisePersonServiceExtension;

extern NSString * const kAlfrescoCloudActivityStreamServiceExtension;
extern NSString * const kAlfrescoCloudRatingServiceExtension;
extern NSString * const kAlfrescoCloudSiteServiceExtension;
extern NSString * const kAlfrescoCloudCommentServiceExtension;
extern NSString * const kAlfrescoCloudTaggingServiceExtension;
extern NSString * const kAlfrescoCloudPersonServiceExtension;

/**
 Thumbnail constants
 */
extern NSString * const kAlfrescoThumbnailRendition;

/**
 Sorting property constants
 */
extern NSString * const kAlfrescoSortByTitle;
extern NSString * const kAlfrescoSortByShortname;
extern NSString * const kAlfrescoSortByCreatedAt;
extern NSString * const kAlfrescoSortByModifiedAt;
extern NSString * const kAlfrescoSortByName;
extern NSString * const kAlfrescoSortByDescription;

/**
 Capabilities constants
 */
extern NSString * const kAlfrescoCapabilityLike;
extern NSString * const kAlfrescoCapabilityCommentsCount;

