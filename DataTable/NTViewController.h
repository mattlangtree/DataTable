//
//  NTViewController.h
//  DataTable
//
//  Created by Matt Langtree on 18/09/11.
//  Copyright (c) 2011 North of Three. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    NSString *pageName;
}

@property (nonatomic,retain) NSString *pageName;

@end
