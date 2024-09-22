// YourViewController.m

#import "ThirdViewController.h"
#import <WebKit/WebKit.h>

@interface ThirdViewController () <WKNavigationDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.navigationDelegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_webView];
    [self addDismissButton];

    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
    
    if (_urlString) {
        NSURL *url = [NSURL URLWithString:_urlString];
        if (url) {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_webView loadRequest:request];
            [_activityIndicator startAnimating];
        } else {
            NSLog(@"Invalid URL: %@", _urlString);
        }
    } else {
        NSLog(@"URL string is nil");
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_activityIndicator stopAnimating];
    [_activityIndicator removeFromSuperview];
}

- (void)addDismissButton {
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dismissButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dismissButton.backgroundColor = [UIColor systemRedColor];
    dismissButton.frame = CGRectMake(20, self.view.bounds.size.height - 70, self.view.bounds.size.width - 40, 50);
    [dismissButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
