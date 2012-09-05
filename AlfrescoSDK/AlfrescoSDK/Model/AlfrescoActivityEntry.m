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

#import "AlfrescoActivityEntry.h"
#import "AlfrescoInternalConstants.h"
#import "AlfrescoISO8601DateFormatter.h"

@interface AlfrescoActivityEntry ()
@property (nonatomic, strong, readwrite) NSString *identifier;
@property (nonatomic, strong, readwrite) NSDate *createdAt;
@property (nonatomic, strong, readwrite) NSString *createdBy;
@property (nonatomic, strong, readwrite) NSString *siteShortName;
@property (nonatomic, strong, readwrite) NSString *type;
@property (nonatomic, strong, readwrite) NSDictionary *data;
@property (nonatomic, strong) AlfrescoISO8601DateFormatter * dateFormatter;
- (void)setOnPremiseProperties:(NSDictionary *)properties;
- (void)setCloudProperties:(NSDictionary *)properties;
@end

@implementation AlfrescoActivityEntry
@synthesize dateFormatter = _dateFormatter;

@synthesize identifier = _identifier;
@synthesize createdAt = _createdAt;
@synthesize createdBy = _createdBy;
@synthesize siteShortName = _siteShortName;
@synthesize type = _type;
@synthesize data = _data;

/**
 Cloud and OnPremise sessions have slightly different JSON response types
 Cloud: postedAt OnPremise: postDate
 Cloud: postPersonID OnPremise: postUserId
 Cloud: siteId OnPremise: siteNetwork
 */

- (id)initWithProperties:(NSDictionary *)properties
{
    self = [super init];
    if (nil != self && nil != properties)
    {
        self.dateFormatter = [[AlfrescoISO8601DateFormatter alloc] init];
        if ([[properties allKeys] containsObject:kAlfrescoJSONIdentifier])
        {
            self.identifier = [properties valueForKey:kAlfrescoJSONIdentifier];
        }
        if ([[properties allKeys] containsObject:kAlfrescoJSONActivityType])
        {
            self.type = [properties valueForKey:kAlfrescoJSONActivityType];
        }
        if ([[properties allKeys] containsObject:kAlfrescoJSONActivitySummary])
        {
            id summary = [properties valueForKey:kAlfrescoJSONActivitySummary];
            if ([summary isKindOfClass:[NSDictionary class]])
            {
                self.data = (NSDictionary *)summary;
            }
            else
            {
                NSError *error = nil;
                self.data = [NSJSONSerialization JSONObjectWithData:[[properties valueForKey:kAlfrescoJSONActivitySummary]
                                                                     dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&error];                
            }
        }

        [self setOnPremiseProperties:properties];
        [self setCloudProperties:properties];        
    }
    return self;
}

- (void)setOnPremiseProperties:(NSDictionary *)properties
{
    //OnPremise Response
    if ([[properties allKeys] containsObject:kAlfrescoJSONActivityPostUserID])
    {
        self.createdBy = [properties valueForKey:kAlfrescoJSONActivityPostUserID];
    }
    //On Premise Response
    if ([[properties allKeys] containsObject:kAlfrescoJSONActivityPostDate])
    {
        NSString *rawDateString = [properties valueForKey:kAlfrescoJSONActivityPostDate];
        if (nil != rawDateString)
        {
            self.createdAt = [self.dateFormatter dateFromString:rawDateString];
        }
    }
    //On Premise Response
    if ([[properties allKeys] containsObject:kAlfrescoJSONActivitySiteNetwork])
    {
        self.siteShortName = [properties valueForKey:kAlfrescoJSONActivitySiteNetwork];
    }
    
}
- (void)setCloudProperties:(NSDictionary *)properties
{
    //Cloud Response - Activity Person/User Id
    if ([[properties allKeys] containsObject:kAlfrescoJSONActivityPostPersonID])
    {
        self.createdBy = [properties valueForKey:kAlfrescoJSONActivityPostPersonID];
    }
    
    //Cloud Response - Activity Posting date
    if ([[properties allKeys] containsObject:kAlfrescoJSONPostedAt])
    {
        NSString *rawDateString = [properties valueForKey:kAlfrescoJSONPostedAt];
        if (nil != rawDateString)
        {
            self.createdAt = [self.dateFormatter dateFromString:rawDateString];
        }
    }
    //Cloud Response - Activity Network/Site Id
    if ([[properties allKeys] containsObject:kAlfrescoJSONSiteID])
    {
        self.siteShortName = [properties valueForKey:kAlfrescoJSONSiteID];
    }
    
}


@end