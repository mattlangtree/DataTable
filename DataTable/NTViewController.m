//
//  NTViewController.m
//  DataTable
//
//  Created by Matt Langtree on 18/09/11.
//  Copyright (c) 2011 North of Three. All rights reserved.
//

#import "NTViewController.h"

@implementation NTViewController

@synthesize pageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)webView:(UIWebView *)webView2 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType {
	
	NSString *requestString = [[request URL] absoluteString];
    // This allows you to create urls like myawesomeapp:dosomeaction to allow you to interact 
    // between the webpage and Objective-C
    
    //	NSArray *components = [requestString componentsSeparatedByString:@":"];
	    
    if ([webView isLoading] == NO) {
        
        NSLog(@"request string: %@",requestString);
        
        /* Open all mailto links in Mail.app */
        if ([requestString rangeOfString:@"mailto://"].location != NSNotFound) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: requestString]];
            return NO;
        }        
    }
	
	return YES; // Return YES to make sure regular navigation works as expected.
}

- (void)webViewDidStartLoad:(UIWebView *)wv 
{
    NSLog(@"started loading.");
}

- (void)webViewDidFinishLoad:(UIWebView *)wv 
{    
    NSLog(@"finished loading.");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [webView release];
    webView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    webView.backgroundColor = [UIColor whiteColor];
    
    NSString *templatePath= [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSLog(@"full Path: %@",templatePath);
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSError *err;
    NSString *bodyText;
    bodyText = [[NSString alloc] initWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:&err];
    
    NSString *pageText = @"";
    // Extract the text from the *.html file if available
    if (![pageName isEqualToString:@""]) {
        NSString *pagePath = [[NSBundle mainBundle] pathForResource:pageName ofType:@"html"];
        pageText = [[NSString alloc] initWithContentsOfFile:pagePath encoding:NSUTF8StringEncoding error:&err];
        if (pageText == nil) {
            pageText = @"";
        }
    }
    
    bodyText = [bodyText stringByReplacingOccurrencesOfString:@"{$body}" withString:pageText];
    
    [webView loadHTMLString:bodyText baseURL:baseURL];
    [webView setMultipleTouchEnabled:NO];
    [webView setScalesPageToFit:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}
@end
