//
//  RNQuickLookManager.m
//
//  Created by Rahul Jiresal on 7/15/16.
//  Copyright © 2016 Air Computing Inc. All rights reserved.
//

#import "RNQuickLookManager.h"
#import "RNQuickLookView.h"

#import <QuickLook/QuickLook.h>

@implementation RNQuickLookManager

RCT_EXPORT_MODULE(RNQuickLook)

- (UIView *) view  {
    return [[RNQuickLookView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(url, NSString)
RCT_EXPORT_VIEW_PROPERTY(assetFileName, NSString)
RCT_EXPORT_VIEW_PROPERTY(base64, NSDictionary)

@end
