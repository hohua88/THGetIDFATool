//
//  ViewController.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/18.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "ViewController.h"
#import <AdSupport/AdSupport.h>
#import "TableViewCell.h"
#import "UIResponder+Router.h"
#import "UIViewController+HUD.h"
#import "IDFASettingViewController.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.bounces = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"idfaCell"];
}


- (IBAction)shareButtonAction:(id)sender {
    NSString *textToShare = @"分享当前设备信息";
    
    NSString *shareInfo = [NSString stringWithFormat:@"IDFA=%@\nIDFV=%@\nSystemVersion=%@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],[[[UIDevice currentDevice] identifierForVendor] UUIDString],[[UIDevice currentDevice] systemVersion]];
    textToShare = [textToShare stringByAppendingString:shareInfo];
    NSArray *activityItems = @[textToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    UIPopoverPresentationController *popover = activityVC.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.shareButton;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idfaCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    if (indexPath.row == 0) {
        cell.title_Label.text = @"IDFA";
        cell.infoLabel.text = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else if(indexPath.row == 1) {
        cell.title_Label.text = @"IDFV";
        cell.infoLabel.text = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else {
        cell.title_Label.text = @"System Version";
        cell.infoLabel.text = [[UIDevice currentDevice] systemVersion];
    }
    return cell;
}

#pragma mark - routerEventWithName
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSLog(@"eventName: %@  userInfo: %@",eventName, userInfo);
  
    if ([userInfo[@"value"] integerValue] == 0) {
       
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSLog(@"idfa is opened");
            [self showHint:@"IDFA复制成功"];
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        }
        else {
            NSLog(@"idfa is closed");
            NSString *msg = @"IDFA未打开，是否设置";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                IDFASettingViewController *controller = [[IDFASettingViewController alloc] init];
                [self presentViewController:controller animated:NO completion:nil];
            }];
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else if([userInfo[@"value"] integerValue] == 1) {
        [self showHint:@"IDFV复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else {
        [self showHint:@"System复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
}

@end
