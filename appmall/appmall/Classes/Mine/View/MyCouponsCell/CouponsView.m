//
//  CouponsView.m
//  TinyShoppingCenter
//
//  Created by 庞宏侠 on 17/7/21.
//  Copyright © 2017年 ckys. All rights reserved.
//

#import "CouponsView.h"
@interface CouponsView()
{
    UIView *bankView;
    UIView *rightView;
    
}

@end
@implementation CouponsView

-(instancetype)initWithFrame:(CGRect)frame andType:(NSString *)type{
    self = [super initWithFrame:frame];
    if(self){
        [self createUIViewType:type];
    }
    return self;
}
-(void)createUIViewType:(NSString *)type{

    //上面的View
    _topCotentView = [[UIView alloc] init];
    [self addSubview:_topCotentView];
    [_topCotentView setBackgroundColor:[UIColor whiteColor]];
    
    float topH = 0;
    if ([type isEqualToString:@"0"]) {
        topH = 0;
    }else{
        topH = 10;
    }
    [_topCotentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topH);
        make.left.right.mas_equalTo(0);
        self.aConstrain = make.bottom.mas_equalTo(0);
    }];
    
    bankView = [[UIView alloc] init];
    [self.topCotentView addSubview:bankView];
    bankView.backgroundColor = [UIColor tt_blueColor];
    [bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH/3);
    }];
    
    
    //价格
    _priceLable = [UILabel configureLabelWithTextColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:CHINESE_SYSTEM_BOLD(16)];
    [bankView addSubview:_priceLable];
    [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(30);
        make.left.right.mas_offset(0);
    }];
    
    //满多少返多少
    _rebateLable = [UILabel configureLabelWithTextColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:MAIN_SUBTITLE_FONT];
    [bankView addSubview:_rebateLable];
    [_rebateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLable.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-25);
    }];
    
    
    rightView = [[UIView alloc] init];
    [self.topCotentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bankView);
        make.right.mas_offset(0);
        make.left.equalTo(bankView.mas_right);
    }];
    
    //全场通用
    _titleLable = [UILabel configureLabelWithTextColor:TitleColor textAlignment:NSTextAlignmentLeft font:MAIN_BODYTITLE_FONT];
    [rightView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.left.mas_equalTo(10);
    }];
    
    //时间
    _timeLable = [UILabel configureLabelWithTextColor:SubTitleColor textAlignment:NSTextAlignmentLeft font:MAIN_TITLE_FONT];
    [rightView addSubview:_timeLable];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(5);
        make.right.mas_offset(-10);
        make.left.equalTo(_titleLable.mas_left);
    }];
    
    //横线
    UILabel *line = [UILabel creatLineLable];
    [rightView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLable.mas_bottom).offset(8);
        make.left.right.equalTo(_timeLable);
        make.height.mas_offset(1);
    }];
    
    UILabel *leftLable = [UILabel configureLabelWithTextColor:SubTitleColor textAlignment:NSTextAlignmentCenter font:MAIN_TITLE_FONT];
    [rightView addSubview:leftLable];
    leftLable.text = @"详细信息";
    [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(_titleLable.mas_left);
        make.bottom.mas_offset(0);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    [rightView addSubview:rightImageView];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightImageView setImage:[UIImage imageNamed:@"bottomarrow"]];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLable.mas_top).offset(5);
        make.bottom.mas_offset(-5);
        make.right.mas_offset(-8);
        make.width.mas_offset(25);
    }];
    
    _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightView addSubview:_detailButton];
    _detailButton.selected = NO;
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLable.mas_top);
        make.left.right.bottom.mas_offset(0);
    }];
    [_detailButton addTarget:self action:@selector(clickDetialButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //点击弹出的View
    self.detailContentView = [[UIView alloc] init];
    [self addSubview:self.detailContentView];
    self.detailContentView.backgroundColor = [UIColor whiteColor];
    [self.detailContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topCotentView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    //详情
    _detailLable = [UILabel configureLabelWithTextColor:SubTitleColor textAlignment:NSTextAlignmentLeft font:MAIN_TITLE_FONT];
    [self.detailContentView addSubview:_detailLable];
    _detailLable.numberOfLines = 0;
    [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-10);
    }];
    _titleLable.text = @"全场通用";
    _priceLable.text = @"¥30.00";
    _rebateLable.text = @"全场满500减100";
    _timeLable.text = @"2020.12.12-2020.12.12";
    _detailLable.text = @"测试爱UI和说你呢奥术大师多啥都好说的还是啥都好啥好的哈哈说的";

}
-(void)clickDetialButton:(UIButton *)button{
    
    button.selected = !button.selected;
    if (!button.selected) {
        self.detailContentView.hidden = YES;
        [self.bConstrain uninstall];
        [self.aConstrain install];
        NSLog(@"没选中");
    }else{
        self.detailContentView.hidden = NO;
        [self.aConstrain uninstall];
        [self.bConstrain install];
        NSLog(@"选中");
    }

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshUIWithBtn:)]) {
        [self.delegate refreshUIWithBtn:button];
    }

}
@end
