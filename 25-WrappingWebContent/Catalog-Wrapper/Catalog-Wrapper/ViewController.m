//
//  ViewController.m
//  Catalog-Wrapper
//
//  Created by Rojiani, Navid on 4/22/16.
//  Copyright © 2016 Rojiani, Navid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSURL        *indexURL;
@property (strong, nonatomic) NSURLRequest *request;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        _indexURL = [NSURL URLWithString:@"http://localhost:5000"];
        _request  = [NSURLRequest requestWithURL:_indexURL];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the request
    [self.webView loadRequest:self.request];

//    UIRegion *region = [[UIRegion alloc] init]; // iOS 9+. nil if <= iOS 8
//    NSLog(@"%@", region);
//
//    [@"badget" localizedStandardContainsString:@"mushroom"]; // runtime exception if < iOS 9
//    // can check using [<object> respondsToSelector:] 
}

// MARK: - WebView Delegate

@end
