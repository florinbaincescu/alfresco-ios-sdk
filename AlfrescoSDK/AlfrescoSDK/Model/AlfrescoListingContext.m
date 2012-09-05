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

#import "AlfrescoListingContext.h"

@implementation AlfrescoListingContext

@synthesize sortProperty = _sortProperty;
@synthesize sortAscending = _sortAscending;
@synthesize maxItems = _maxItems;
@synthesize skipCount = _skipCount;

- (id)init
{
    return [self initWithMaxItems:50 skipCount:0 sortProperty:nil sortAscending:YES];
}

- (id)initWithMaxItems:(int)maxItems skipCount:(int)skipCount
{
    return [self initWithMaxItems:maxItems skipCount:skipCount sortProperty:nil sortAscending:YES];
}

- (id)initWithSortProperty:(NSString *)sortProperty sortAscending:(BOOL)sortAscending
{
    return [self initWithMaxItems:50 skipCount:0 sortProperty:sortProperty sortAscending:sortAscending];
}

- (id)initWithMaxItems:(int)maxItems skipCount:(int)skipCount sortProperty:(NSString *)sortProperty sortAscending:(BOOL)sortAscending
{
    self = [super init];
    if (self)
    {
        self.sortProperty = sortProperty;
        self.maxItems = maxItems;
        self.skipCount = skipCount;
        self.sortAscending = sortAscending;
    }
    return self;
    
}


@end