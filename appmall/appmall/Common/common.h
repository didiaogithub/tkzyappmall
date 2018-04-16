//
//  common.h
//  MoveShoppingMall
//
//  Created by 庞宏侠 on 17/2/7.
//  Copyright © 2017年 ckys. All rights reserved.
//
#define common_h

/* 网络环境0：测试，1：生产 */
#define AppEnvironment 0
/* 银联与银联Apple Pay环境："00" 表示线上环境"01"表示测试环境 */
#define UnionPayEnvironment @"00"
/* 两次刷新的时间间隔 */
#define Interval 5

#define shareSDKAppID @"16f95f8fa566e"
#define weiBoAppkey @"4079281429"
#define weiBoSecrete @"86938fa31195ded301855bcb2394cb75"
#define qqAppID @"1105610041"
#define qqAppKey @"9CUGfw8PtfHyaSt1"






#define DeviceId_UUID_Value [NSString stringWithFormat:@"%@",[getUUID getUUID]]



#define Kmobile @"CKSC_phone"
#define KnickName @"CKSC_nickName"
/**openid(通过微信授权获得)*/
#define KopenID @"CKSC_appopenid"
/**unionid(通过微信授权获得)*/
#define Kunionid @"CKSC_unionid"
#define kheamImageurl @"CKSC_headImageUrl"

#define KMyCouponList @"CKSC_myCouponList"


#define KloginStatus @"loginSuccess"

/**微信授权之后 跳转登录*/
#define WeiXinAuthSuccess @"WeiXinAuthSuccess"
/* 微信支付回调 */
#define WeiXinPay_CallBack @"weixinpay"
#define Alipay_CallBack @"AlipayBack"
#define UnionPay_CallBack @"UnionpayCallBack"


#define USER_DefaultAddress @"YDSC_DefaultAddress"
#define MallintegralShowOrNot @"mallintegralshow"


//适配缩放
#define SCREEN_WIDTH_SCALE SCREEN_WIDTH / 375.0
#define SCREEN_HEIGHT_SCALE SCREEN_HEIGHT / 667.0

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define iOS7M ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
#define iOS8M ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
#define iOS9M ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0)


#define IPHONE_X [[SCCommon getCurrentDeviceModel] isEqualToString:@"iPhone_X"]

/**距离导航栏底部的距离*/
#define NaviHeight (IPHONE_X ? 88 : 64)
/**iphonex导航栏增加的高度*/
#define NaviAddHeight (IPHONE_X ? 24 : 0)
#define BOTTOM_BAR_HEIGHT (IPHONE_X ? 34 : 0)


//高度等于480
#define iphone4 ([UIScreen mainScreen].bounds.size.height == 480)
//高度大于480
#define iphone5 ([UIScreen mainScreen].bounds.size.height ==568)
//高度等于667
#define iphone6 ([UIScreen mainScreen].bounds.size.height ==667)
//高度大于667
#define iphone6Plus ([UIScreen mainScreen].bounds.size.height ==736)


/* --------------------字体配置-------------------- */
#define CHINESE_SYSTEM(x)       [UIFont systemFontOfSize:x]
#define CHINESE_SYSTEM_BOLD(x)  [UIFont boldSystemFontOfSize:x]

// 字体定义
#define MAIN_BODYTITLE_FONT [UIFont systemFontOfSize:15.0f]// 主标题 正文 文字
#define NORMAL_FONT       [UIFont systemFontOfSize:14.0f]// 主标题 正文 文字
#define MAIN_TITLE_FONT   [UIFont systemFontOfSize:15.0f]// 辅助文字
#define MAIN_SUBTITLE_FONT  [UIFont systemFontOfSize:13.0f]// 辅助说明文字

/* --------------------屏幕适配比例-------------------- */
//不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6系列 如果不是则根据实际情况修改）
#define kScreenWidthRatio       (SCREEN_WIDTH / 375.0)
#define kScreenHeightRatio      (SCREEN_HEIGHT / 667.0)
#define AdaptedWidth(x)         ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x)        ceilf((x) * kScreenHeightRatio)
/**主标题 正常字体 颜色*/
#define TitleColor CKYS_Color(50,53,56)
/**副标题 灰色字体颜色*/
#define SubTitleColor CKYS_Color(163,164,165)

//RGB color
#define CKYS_Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define KUserdefaults [NSUserDefaults standardUserDefaults]

#define APPKeyWindow [UIApplication sharedApplication].keyWindow
//通知
#define CKCNotificationCenter [NSNotificationCenter defaultCenter]



/**请求的参数openid */
#define USER_OPENID  [KUserdefaults objectForKey:@"USER_OPENID"]


/**判断ios是否在审核中*/
#define CheckSuccessCode @"200"
#define IsIosCheck_Url @"Wxmall/Login/isAppMaill3Check"

#define GetLoginType @"Wxmall/Login/getAppMallLoginType"




#define NetWorkNotReachable @"当前网络不可用，请检查你的网络设置"
#define NetWorkTimeout @"网络不给力，请稍后再试"



/**判空处理*/
#define IsNilOrNull(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]])  || ([(_ref) isKindOfClass:[NSNull class]]) || ([(_ref) isEqualToString:@"(null)"]) || ([(_ref) isEqualToString:@""]) || ([(_ref) isEqualToString:@"null"]) || ([(_ref) isEqualToString:@"<null>"]))


//debug状态输出log，release状态屏蔽log
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()




#endif /* common_h */
