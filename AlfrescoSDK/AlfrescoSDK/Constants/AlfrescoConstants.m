/*******************************************************************************
 * Copyright (C) 2005-2014 Alfresco Software Limited.
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

#import "AlfrescoConstants.h"

/**
 SDK Version constants - defined in AlfrescoSDK.xcconfig
 */
#if !defined(ALFRESCO_SDK_VERSION)
    #warning Missing AlfrescoSDK.xcconfig entries. Ensure the project configuration settings are correct.
    #define ALFRESCO_SDK_VERSION @"Unknown"
#endif
NSString * const kAlfrescoSDKVersion = ALFRESCO_SDK_VERSION;

/**
 Session parameter constants
 */
NSString * const kAlfrescoMetadataExtraction = @"org.alfresco.mobile.features.extractmetadata";
NSString * const kAlfrescoThumbnailCreation = @"org.alfresco.mobile.features.generatethumbnails";
NSString * const kAlfrescoAllowUntrustedSSLCertificate = @"org.alfresco.mobile.features.allowuntrustedsslcertificate";
NSString * const kAlfrescoConnectUsingClientSSLCertificate = @"org.alfresco.mobile.features.connectusingclientsslcertificate";
NSString * const kAlfrescoClientCertificateCredentials = @"org.alfresco.mobile.features.clientcertificatecredentials";

/**
 Thumbnail constants
 */
NSString * const kAlfrescoThumbnailRendition = @"doclib";

/**
 Sorting property constants
 */
NSString * const kAlfrescoSortByTitle = @"title";
NSString * const kAlfrescoSortByShortname = @"shortName";
NSString * const kAlfrescoSortByCreatedAt = @"createdAt";
NSString * const kAlfrescoSortByModifiedAt = @"modifiedAt";
NSString * const kAlfrescoSortByName = @"name";
NSString * const kAlfrescoSortByDescription = @"description";

/**
 Capabilities constants
 */
NSString * const kAlfrescoCapabilityLike = @"CapabilityLike";
NSString * const kAlfrescoCapabilityCommentsCount = @"CapabilityCommentsCount";
NSString * const kAlfrescoCapabilityPublicAPI = @"CapabilityPublicAPI";
NSString * const kAlfrescoCapabilityActivitiWorkflowEngine = @"CapabilityActivitiWorkflowEngine";
NSString * const kAlfrescoCapabilityJBPMWorkflowEngine = @"CapabilityJBPMWorkflowEngine";

/**
 File Attribute Constants
 */
NSString * const kAlfrescoFileSize = @"fileSize";
NSString * const kAlfrescoFileLastModification = @"lastModificationDate";
NSString * const kAlfrescoIsFolder = @"isFolder";

/**
 Custom Network Provider
 */
NSString * const kAlfrescoNetworkProvider = @"org.alfresco.mobile.session.networkprovider";
NSString * const kAlfrescoCMISBindingURL = @"org.alfresco.mobile.session.cmisbindingurl";

/**
 Workflow Task Constants
 */
NSString * const kAlfrescoWorkflowTaskComment = @"org.alfresco.mobile.task.comment";
NSString * const kAlfrescoWorkflowTaskReviewOutcome = @"org.alfresco.mobile.task.reviewoutcome";

NSString * const kAlfrescoWorkflowTaskTransitionApprove = @"Approve";
NSString * const kAlfrescoWorkflowTaskTransitionReject = @"Reject";

NSString * const kAlfrescoWorkflowProcessStateAny = @"org.alfresco.mobile.process.state.any";
NSString * const kAlfrescoWorkflowProcessStateActive = @"org.alfresco.mobile.process.state.active";
NSString * const kAlfrescoWorkflowProcessStateCompleted = @"org.alfresco.mobile.process.state.completed";

NSString * const kAlfrescoWorkflowProcessDescription = @"org.alfresco.mobile.process.create.description";
NSString * const kAlfrescoWorkflowProcessPriority = @"org.alfresco.mobile.process.create.priority";
NSString * const kAlfrescoWorkflowProcessSendEmailNotification = @"org.alfresco.mobile.process.create.sendemailnotification";
NSString * const kAlfrescoWorkflowProcessDueDate = @"org.alfresco.mobile.process.create.duedate";
NSString * const kAlfrescoWorkflowProcessApprovalRate = @"org.alfresco.mobile.process.create.approvalrate";
