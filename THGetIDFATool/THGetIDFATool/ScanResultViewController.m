//
//  ScanResultViewController.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/25.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "ScanResultViewController.h"
#import <WebKit/WebKit.h>

@interface ScanResultViewController ()
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:0
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    // Do any additional setup after loading the view.
}
- (void)setupNavigationItem{
    // 后退按钮
    UIButton * goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
    goBackButton.frame = CGRectMake(0, 0, 35, 35);
    goBackButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    UIBarButtonItem * goBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:goBackButton];
    self.navigationItem.leftBarButtonItems = @[goBackButtonItem];
}

- (void)goBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Getter

- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 1, self.view.frame.size.width, 2)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
       
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.scanString]];
        [_webView loadRequest:request];
//        //页面后退
//        [_webView goBack];
//        //页面前进
//        [_webView goForward];
//        //刷新当前页面
        [_webView reload];
    }
    return _webView;
}

//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
        NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }
    else if([keyPath isEqualToString:@"title"]
            && object == _webView){
        self.navigationItem.title = _webView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
- (void)dealloc{
    //移除观察者
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
}
@end
