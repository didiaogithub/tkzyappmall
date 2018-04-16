//
//  RecommendCollectionViewCell.m
//  appmall
//
//  Created by 王博 on 15/04/2018.
//  Copyright © 2018 com.tcsw.tkzy. All rights reserved.
//

#import "RecommendCollectionViewCell.h"
@interface RecommendCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgRecommend;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labWeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labTitleDisBottom;

@end

@implementation RecommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)isShowPrice:(BOOL)show{
    if (!show) {
        self.labTitleDisBottom.constant = -20;
        self.labPrice.hidden = YES;
        self.labWeight.hidden = YES;
    }else{
        self.labTitleDisBottom.constant = 10;
        self.labPrice.hidden = NO;
        self.labWeight.hidden = NO;
    }
}

@end
