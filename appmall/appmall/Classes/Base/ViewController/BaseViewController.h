//
//  BaseViewController.h
//  happyLottery
//
//  Created by 王博 on 2017/12/1.
//  Copyright © 2017年 onlytechnology. All rights reserved.asd
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



#import "JGProgressHUD.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong) JGProgressHUD *viewNetError;
- (void) showPromptViewWithText: (NSString *) text ;
- (void) showPromptViewWithText: (NSString *) text hideAfter: (NSTimeInterval) interval ;
- (void) showPromptText: (NSString *) text hideAfterDelay: (NSTimeInterval) interval;
- (void) showLoadingViewWithText: (NSString *) text
                  withDetailText: (NSString *) sText;
- (void) showLoadingText: (NSString *) text;
- (void) showLoadingViewWithText: (NSString *) text
                  withDetailText: (NSString *) sText
                        autoHide: (NSTimeInterval) interval;
- (void) showLoadingViewWithText: (NSString *) text;
- (void) showPromptText: (NSString *) text;
- (void) hidePromptText;
- (void) hideLoadingView;
//添加提示view
- (void)showNoticeView:(NSString*)title;
@end
