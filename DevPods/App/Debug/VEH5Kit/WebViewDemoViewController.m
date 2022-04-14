//
//  WebViewDemoViewController.m
//  App
//
//  Created by bytedance on 2022/2/21.
//

#import "WebViewDemoViewController.h"
#import <VEH5Kit/VEH5Kit.h>
#import <OneKit/UIView+BTDAdditions.h>
#import "VEH5WebDebugViewController.h"
#import "BTDExampleAnotherActionMethod.h"
#import "BTDExampleSomeActionMethod.h"

@interface WebViewDemoViewController () <VEH5WebViewDelegate, VEH5WebViewActionDelegate>
@property (nonatomic ,strong) VEH5WebView *webView;
@property (nonatomic, strong) NSDate *startDate;

@end

@implementation WebViewDemoViewController

- (void)dealloc
{
    [[VEH5KitManager sharedInstance] clearDebugCache];
    
    // All kinds of data
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    // Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    // Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
       // Done
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self configWebView];
    [self addOnPublishButton];
    if (self.offlineEnable) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"离线记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configWebView {
    CGRect rect = CGRectMake(0, UIApplication.sharedApplication.keyWindow.safeAreaInsets.top + 44, self.view.bounds.size.width, self.view.bounds.size.height - UIApplication.sharedApplication.keyWindow.btd_safeAreaInsets.bottom - UIApplication.sharedApplication.keyWindow.btd_safeAreaInsets.top - 94);
    if (self.offlineEnable) {
        self.webView = [[VEH5WebView alloc] initWithFrame:rect withOfflineEnable:self.offlineEnable];
    } else {
        self.webView = [[VEH5WebView alloc] initWithFrame:rect];
    }
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.webView addDelegate:self];
    [self.webView addActionDelegate:self];
    [self.webView configWebViewBackgroundColor:[UIColor whiteColor]];
    [self.webView setBouncesEnable:YES];
    [self.webView setProgressViewHidden:NO];
    
    [self.view addSubview:self.webView];
    // Register a local method.
    BTDExampleSomeActionMethod *method = [BTDExampleSomeActionMethod new];
    [self.webView registerLocalMethod:method];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30]];
}

-(void)addOnPublishButton {
    CGRect rect = CGRectMake(20, self.view.bounds.size.height - 40 - 50, self.view.bounds.size.width -40, 50);
    NSString *title = @"打开Js弹窗";
    title = @"sendEvent(o.customEvent)";
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.layer setBorderWidth:1.0];
    [button addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)publish {
    NSString *name = @"o.customEvent";
    name = @"o.openJsDialog";
    VEH5BridgeEvent *event = [VEH5BridgeEvent eventWithEventName:name params:@{@"content": @"content"}];
    [[VEH5BridgeEventCenter sharedInstance] publishEvent:event];
}

- (void)rightBarButtonAction {
    VEH5WebDebugViewController *vc = [[VEH5WebDebugViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -- BTDWebViewDelegate
- (void)webViewDidStartLoad:(VEH5WebView *)webView
{
    self.startDate = [NSDate date];
}

- (void)webViewDidFinishLoad:(VEH5WebView *)webView
{
    NSTimeInterval loadTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
    if (self.finishBlock){
        self.finishBlock(loadTime);
    }
}

- (void)webViewDidTerminate:(VEH5WebView *)webView
{
    
}

- (void)webViewDidLayoutSubviews:(VEH5WebView *)webView
{
    
}

- (void)webView:(VEH5WebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (BOOL)webView:(VEH5WebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(BDWebViewNavigationType)navigationType
{
    return YES;
}

- (BOOL)webView:(VEH5WebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)response
{
    return YES;

}

- (void)webView:(VEH5WebView *)webView renderingProgressDidChange:(BDRenderingProgressEvents)progressEvents
{
    
}

- (void)webView:(VEH5WebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

- (void)webView:(VEH5WebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

- (void)webView:(VEH5WebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

- (void)webView:(VEH5WebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

- (void)webView:(VEH5WebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

- (BOOL)webView:(VEH5WebView *)webView shouldTryOpenUniversalLink:(NSURL *)url API_AVAILABLE(ios(9.0))
{
    return YES;
}

- (void)webView:(VEH5WebView *)webView didOpenUniversalLink:(NSURL *)url API_AVAILABLE(ios(10.0))
{
    
}


#pragma --BTDWebViewActionDelegate
- (void)webView:(VEH5WebView *)webView shouldDragBackDisbale:(BOOL)disable
{
    
}

- (void)webView:(VEH5WebView *)webView didStartLoadRequest:(NSURLRequest *)request
{
    
}

- (void)webView:(VEH5WebView *)webView didRefreshDataWithRequest:(NSURLRequest *)request
{
    
}

- (void)webView:(VEH5WebView *)webView didScrollToContentOffset:(CGPoint)contentOffset
{
    
}
@end
