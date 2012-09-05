/*
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
 */

#import <Foundation/Foundation.h>
#import "CMISRepositoryInfo.h"

@class CMISTypeDefinition;

@protocol CMISRepositoryService <NSObject>

/**
* Returns an array of CMISRepositoryInfo objects representing the repositories available at the endpoint.
*/
- (NSArray *)retrieveRepositoriesAndReturnError:(NSError **)outError;

/**
* Returns the repository info for the repository with the given id
*/
- (CMISRepositoryInfo *)retrieveRepositoryInfoForId:(NSString *)repositoryId error:(NSError **)outError;

- (CMISTypeDefinition *)retrieveTypeDefinition:(NSString *)typeId error:(NSError **)outError;

@end