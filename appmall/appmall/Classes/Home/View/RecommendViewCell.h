//
//  RecommendViewCell.h
//  appmall
//
//  Created by 王博 on 15/04/2018.
//  Copyright © 2018 com.tcsw.tkzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommendViewCellDelegate<NSObject>
-(void)recommendViewCellDelegateMore:(NSInteger)index;
@end

@interface RecommendViewCell : UITableViewCell

@property(weak,nonatomic)id <RecommendViewCellDelegate>delegate;
-(void)setCollection:(NSInteger )index;

-(CGFloat)getCollectionHeight:(NSInteger)index;
@end
