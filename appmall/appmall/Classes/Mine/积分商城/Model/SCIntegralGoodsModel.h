//
//  SCIntegralGoodsModel.h
//  TinyShoppingCenter
//
//  Created by ForgetFairy on 2017/10/9.
//  Copyright © 2017年 ckys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCIntegralGoodsModel : NSObject

/**商品id*/
@property (nonatomic, copy) NSString *itemid;
/**图片路径*/
@property (nonatomic, copy) NSString *path;
/**商品名称*/
@property (nonatomic, copy) NSString *name;
/**规格*/
@property (nonatomic, copy) NSString *spec;
/**销售价格*/
@property (nonatomic, copy) NSString *costprice;
/**原价*/
@property (nonatomic, copy) NSString *salesprice;
/**消耗积分*/
@property (nonatomic, copy) NSString *consumeintegral;

@end
