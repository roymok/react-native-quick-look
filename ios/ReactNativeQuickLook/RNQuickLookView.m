//
//  RNQuickLookView.m
//
//  Created by Rahul Jiresal on 7/15/16.
//  Copyright © 2016 Air Computing Inc. All rights reserved.
//

#import "RNQuickLookView.h"
#import <QuickLook/QuickLook.h>

@interface RNQuickLookView () <QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property UIView* previewView;
@property QLPreviewController* previewCtrl;

@end

@implementation RNQuickLookView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
    
}

- (instancetype)initWithPreviewItemUrl:(NSString*)url {
    NSAssert(url != nil, @"Preview Item URL cannot be nil");
    self = [super init];
    if (self) {
        _url = url;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.previewCtrl = [[QLPreviewController alloc] init];
    self.previewCtrl.delegate = self;
    self.previewCtrl.dataSource = self;
    self.previewView = self.previewCtrl.view;
    self.clipsToBounds = YES;
    [self addSubview:self.previewCtrl.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.previewView setFrame:self.frame];
}

- (void)setUrl:(NSString *)urlString {
    _url = [urlString stringByRemovingPercentEncoding];
    [self.previewCtrl refreshCurrentPreviewItem];
}

- (void)setAssetFileName:(NSString*)filename {
    _url = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:[filename pathExtension]];
    [self.previewCtrl refreshCurrentPreviewItem];
}

- (void)setBase64:(NSDictionary*)dict {
    NSString* base64String = dict[@"base64"];
    NSString* name = dict[@"fileName"];
    NSString* type = dict[@"fileType"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"data:application/octet-stream;base64,%@", base64String]];
    
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSString* fileName = [NSString stringWithFormat:@"%@%@%@", name, @".", type];
    
    NSString* tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSURL* tempFileUrl = [[NSURL alloc] initFileURLWithPath:tempPath];
    [data writeToURL:tempFileUrl atomically:YES];
    
    _url = tempFileUrl.absoluteString;
    [self.previewCtrl refreshCurrentPreviewItem];
}

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return [NSURL URLWithString:_url];
}

#pragma mark - QLPreviewControllerDelegate

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return YES;
}

@end
