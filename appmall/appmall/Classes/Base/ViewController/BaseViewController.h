//
//  BaseViewController.h
//  happyLottery
//
//  Created by 王博 on 2017/12/1.
//  Copyright © 2017年 onlytechnology. All rights reserved.asd
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"




@interface BaseViewController : UIViewController

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

@end
