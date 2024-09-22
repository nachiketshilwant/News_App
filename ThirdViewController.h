//
//  ThirdViewController.h
//  RSSReader
//
//  Created by Nachiket Shilwant on 23/08/24.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdViewController : UIViewController <WKNavigationDelegate, UIWebViewDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property NSString *urlString;
@end

NS_ASSUME_NONNULL_END
