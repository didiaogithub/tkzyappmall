//
//  AddAddressViewController.m
//  TinyShoppingCenter
//
//  Created by 庞宏侠 on 16/8/5.
//  Copyright © 2016年 ckys. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressModel.h"
#import "SelectedProviceViewController.h"
#import "ChangeMyAddressViewController.h"

@interface AddAddressViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    UIView *_bankView;
    UITextField *contentTf;
    UITextField *_nameTextFiedld;
    UITextField *_telePhoneFiedld;
    UITextField *_detailedAddressFiedld;//详细地址
    UIButton *_addAddressButton;

    
    //选择地址
    NSString *title;
    UITextField *_cityTextField;
    UILabel *_cityLabel;
    UITextView *_addrTv;
    UILabel *_placeholder;
    
    UIPickerView *pickView;
    UIToolbar *toolBar;
    
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *cityName;
    UIButton *rightButton;
    UIButton *leftButton;
    NSString *_addressStr;
    NSString *_addressId;
    
}
@property(nonatomic,strong)UIView *bottomView;

@property (nonatomic, strong) UIButton *defaultBtn;

@end

@implementation AddAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.areaNameStr) {
        _cityLabel.textColor = TitleColor;
        _cityLabel.text = self.areaNameStr;
    }
}
-(void)transName:(NSNotification *)notice{
    NSLog(@"%@",notice.object);
    self.areaNameStr = notice.object;
}
-(void)setPlaceBlock:(TransBlock)placeBlock{
    _placeBlock = placeBlock;
 
}
-(UIView*)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收货地址";

    [CKCNotificationCenter addObserver:self selector:@selector(transName:) name:@"bank" object:nil];
    [self createOtherViews];
    [self refreshData];
    
    if (self.addressIdString && self.addressIdString.length > 0) {
         [self getAddressInfoData];
    }
}
#pragma mark-通过id获取地址
-(void)getAddressInfoData{
    if(IsNilOrNull(self.addressIdString)){
     self.addressIdString = @"";
    }
    
//    NSDictionary *pramaDic = @{@"openid": USER_OPENID};
//    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", WebServiceAPI, GetAddrListUrl];
//
//    [HttpTool getWithUrl:requestUrl params:pramaDic success:^(id json) {
//        NSDictionary *dict = json;
//        NSString *code  = [NSString stringWithFormat:@"%@",dict[@"code"]];
//        if (![code isEqualToString:@"200"]) {
//            [self showNoticeView:dict[@"msg"]];
//            return ;
//        }
//        _addressModel = [[AddressModel alloc] init];
//        [_addressModel setValuesForKeysWithDictionary:dict];
//        [self refreshWithModel:_addressModel];
//
//    } failure:^(NSError *error) {
//        if (error.code == -1009) {
//            [self showNoticeView:NetWorkNotReachable];
//        }else{
//            [self showNoticeView:NetWorkTimeout];
//        }
//    }];
}
-(void)refreshWithModel:(AddressModel *)addressModel{
    NSString *name = [NSString stringWithFormat:@"%@",addressModel.name];
    NSString *mobile = [NSString stringWithFormat:@"%@",addressModel.mobile];
    NSString *threeAddress = [NSString stringWithFormat:@"%@",addressModel.area];
    NSString *detailAddress = [NSString stringWithFormat:@" %@",addressModel.address];
    if (IsNilOrNull(name)) {
        name = @"";
    }
    if (IsNilOrNull(mobile)){
        mobile = @"";
    }
    if (IsNilOrNull(threeAddress)) {
        threeAddress = @"";
    }
    if (IsNilOrNull(detailAddress)) {
        detailAddress = @"";
    }
    _addressStr = [NSString stringWithFormat:@"%@ %@",threeAddress,detailAddress];
    _nameTextFiedld.text = name;
    _telePhoneFiedld.text = mobile;
    if (self.areaNameStr){
        _cityLabel.text = self.areaNameStr;
    }else{
        _cityLabel.text = threeAddress;
    }
    _detailedAddressFiedld.text = detailAddress;
    
}

/**刷新数据*/
-(void)refreshData{
    if (!IsNilOrNull(self.addressModel.name)) {
         _nameTextFiedld.text = self.addressModel.name;
    }else{
        _nameTextFiedld.text = @"";
    }
    if (!IsNilOrNull(self.addressModel.mobile)) {
        _telePhoneFiedld.text = self.addressModel.mobile;
    }else{
        _telePhoneFiedld.text = @"";
    }
    if (!IsNilOrNull(self.addressModel.area)) {
        _cityLabel.textColor = TitleColor;
        _cityLabel.text = self.addressModel.area;
    }else{
        _cityLabel.textColor = CKYS_Color(189, 187, 195);
        _cityLabel.text = @"请选择";
    }
    if (!IsNilOrNull(self.addressModel.address)) {
        _detailedAddressFiedld.text =  self.addressModel.address;
    }else{
        _detailedAddressFiedld.text = @"";
    }
    
    if ([self.actionName isEqualToString:@"Add"]) {
        _defaultBtn.selected = NO;
    }else{
        NSString *isdefault = [NSString stringWithFormat:@"%@",_addressModel.isdefault];
        if ([isdefault isEqualToString:@"0"] || [isdefault isEqualToString:@"false"]) {
            _defaultBtn.selected = NO;
        }else{
            _defaultBtn.selected = YES;
            _defaultBtn.userInteractionEnabled = NO;
        }
    }
    
}

-(void)createOtherViews{
    
    _bankView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+10+NaviAddHeight, SCREEN_WIDTH, AdaptedHeight(330))];
    [_bankView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_bankView];
    float h = 0;
    NSArray * titleArr = @[@"  收件人：",@"  手机号码：",@"  所在地区：",@"  详细地址："];
    for (int i = 0; i<4; i++) {
        UIButton * bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(AdaptedWidth(15), h, SCREEN_WIDTH-AdaptedWidth(30), AdaptedHeight(50))];
        [bgBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        bgBtn.titleLabel.font = MAIN_TITLE_FONT;
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [bgBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        bgBtn.tag = 100+i;
        [bgBtn addTarget:self action:@selector(editAddressMsgClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bankView addSubview:bgBtn];
        
        //中间的分割线
        UILabel *lineL = [UILabel creatLineLable];
        lineL.frame = CGRectMake(AdaptedWidth(15),CGRectGetMaxY(bgBtn.frame), SCREEN_WIDTH-AdaptedWidth(30), 1);
        [_bankView addSubview:lineL];
      
        //可输入文字的textfield
        contentTf = [[UITextField alloc] initWithFrame:CGRectMake(AdaptedWidth(100),0, SCREEN_WIDTH-AdaptedWidth(135),AdaptedHeight(50))];
        contentTf.delegate = self;
        contentTf.tag = 200+i;
        contentTf.textColor = TitleColor;
        contentTf.font = MAIN_TITLE_FONT;
        contentTf.textAlignment = NSTextAlignmentRight;
        [bgBtn addSubview:contentTf];
        
        if (bgBtn.tag == 102) { //选择地区按钮
            _cityLabel = [UILabel configureLabelWithTextColor:CKYS_Color(189, 187, 195) textAlignment:NSTextAlignmentRight font:MAIN_TITLE_FONT];
            _cityLabel.frame = CGRectMake(AdaptedWidth(100),0, SCREEN_WIDTH-AdaptedWidth(135), AdaptedHeight(50));
            [bgBtn addSubview:_cityLabel];
            _cityLabel.text = @"请选择";
        }
    
//        UIImageView * imgView = [[UIImageView alloc] init];
//        imgView.frame = CGRectMake(SCREEN_WIDTH-AdaptedWidth(15), 15, 18, 20);
//        imgView.image = [UIImage imageNamed:@"address"]; //点击 选择
//        imgView.backgroundColor =[UIColor redColor];
//        imgView.hidden = YES;
//        [bgBtn addSubview:imgView];
        switch (i) {
            case 0:
            {
                _nameTextFiedld = contentTf;
                _nameTextFiedld.placeholder = @"未填写";
            }
                break;
            case 1:
            {
                _telePhoneFiedld = contentTf;
                _telePhoneFiedld.placeholder = @"未填写";
            }
                break;
            case 2:
            {
//               imgView.hidden = NO;
                _cityLabel.text = @"请选择";
                _cityLabel.textColor = CKYS_Color(189, 187, 195);
                contentTf.enabled = NO;
            }
                break;
            case 3:
            {
                _detailedAddressFiedld = contentTf;
                _detailedAddressFiedld.placeholder = @"未填写";
            }
               
                break;
                default:
                break;
        }
        h+=51;
    }
    
    _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultBtn setImage:[UIImage imageNamed:@"selectedgray"] forState:UIControlStateNormal];
    [_defaultBtn setImage:[UIImage imageNamed:@"selectedred"] forState:UIControlStateSelected];
    [_bankView addSubview:_defaultBtn];
    [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailedAddressFiedld.mas_bottom);
        make.left.mas_offset(AdaptedWidth(10));
        make.height.width.mas_equalTo(AdaptedWidth(35));
    }];
    
    [_defaultBtn addTarget:self action:@selector(isSelectDefaultAddr) forControlEvents:UIControlEventTouchUpInside];

    UILabel *label = [UILabel new];
    label.text = @"设为默认";
    [_bankView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailedAddressFiedld.mas_bottom);
        make.left.equalTo(_defaultBtn.mas_right);
        make.right.mas_offset(-AdaptedWidth(35));
        make.height.mas_offset(AdaptedHeight(40));
    }];
//
//    //下一步
//    float buttonH = 4*AdaptedHeight(50)+AdaptedHeight(40);
//
    _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bankView addSubview:_addAddressButton];
    _addAddressButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_addAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addAddressButton.backgroundColor = [UIColor tt_redMoneyColor];
    _addAddressButton.layer.cornerRadius = 3.0;
    _addAddressButton.layer.masksToBounds = YES;
    [_addAddressButton setTitle:@"保存" forState:UIControlStateNormal];
    [_addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(15);
        make.left.equalTo(self.view.mas_left).offset(AdaptedWidth(15));
        make.right.equalTo(self.view.mas_right).offset(-AdaptedWidth(15));
        make.height.mas_equalTo(44);
    }];
    
    [_addAddressButton addTarget:self action:@selector(clickAddressButton) forControlEvents:UIControlEventTouchUpInside];

}

-(void)isSelectDefaultAddr {
    if (self.defaultBtn.isSelected) {
        [self.defaultBtn setSelected:NO];
        [_defaultBtn setImage:[UIImage imageNamed:@"selectedgray"] forState:UIControlStateNormal];

    } else {
        [self.defaultBtn setSelected:YES];
        [_defaultBtn setImage:[UIImage imageNamed:@"selectedred"] forState:UIControlStateSelected];

    }
}

-(void)editAddressMsgClick:(UIButton *)button{
    if (button.tag == 102) {
        SelectedProviceViewController *selecteProvice = [[SelectedProviceViewController alloc] init];
        selecteProvice.typeString = @"2";
        [self.navigationController pushViewController:selecteProvice animated:NO];
        
    }
}

#pragma mark-点击添加地址
-(void)clickAddressButton{
    [self resignTextfieldFirstRespoder];
    
    if(IsNilOrNull(_nameTextFiedld.text)){
        [self showNoticeView:@"请填写收货人姓名"];
        return;
    }
    
    if(IsNilOrNull(_telePhoneFiedld.text)){
        [self showNoticeView:@"请填写联系电话"];
        return;
    }
    
    if ([_telePhoneFiedld.text hasPrefix:@"1"]) {
        //1开头的默认为大陆号码，增加验证
//        if(![NSString isMobile:_telePhoneFiedld.text]){
//            [self showNoticeView:@"请输入正确的手机号码"];
//            return;
//        }
    }
    
    if (IsNilOrNull(_cityLabel.text) || [_cityLabel.text isEqualToString:@"请选择"])
    {
        [self showNoticeView:@"请选择所在地区"];
        return;
    }
    if (IsNilOrNull(_detailedAddressFiedld.text))
    {
        [self showNoticeView:@"请填写详细地址"];
        return;
    }
    if (IsNilOrNull(_cityTextField.text))
    {
        if (IsNilOrNull(_cityLabel.text)) {
            _cityLabel.text = self.areaNameStr;
        }
    }
        
    NSString *requestUrl = nil;
    NSDictionary *pramaDic = nil;
    if (IsNilOrNull(self.addressModel.ID)) {
       self.addressModel.ID = @"";
    }
    
    NSString *isdefault = @"false";
    if (_defaultBtn.selected == YES) {
        isdefault = @"true";
    }

    _detailedAddressFiedld.text = [NSString stringWithFormat:@" %@",_detailedAddressFiedld.text];
//    if (self.addressModel){ //修改
//        requestUrl = [NSString stringWithFormat:@"%@%@", WebServiceAPI, UpdateAddrUrl];
//        pramaDic = @{@"openid": USER_OPENID, @"name":_nameTextFiedld.text,@"mobile":_telePhoneFiedld.text,@"area":_cityLabel.text,@"address":_detailedAddressFiedld.text, @"isdefault":isdefault, @"id":self.addressModel.ID};
//    }else{
//        requestUrl = [NSString stringWithFormat:@"%@%@", WebServiceAPI, AddAddrUrl];
//        pramaDic = @{@"openid": USER_OPENID, @"name":_nameTextFiedld.text,@"mobile":_telePhoneFiedld.text,@"area":_cityLabel.text,@"address":_detailedAddressFiedld.text, @"isdefault":isdefault};
//    }
//
//        [self.view addSubview:self.loadingView];
//        [self.loadingView startAnimation];
//        [HttpTool postWithUrl:requestUrl params:pramaDic success:^(id json) {
//
//            [self.loadingView stopAnimation];
//            NSDictionary *dict = json;
//            if ([dict[@"code"] integerValue] != 200) {
//                [self showNoticeView:dict[@"msg"]];
//                return ;
//            }
//
//        _addressId = [NSString stringWithFormat:@"%@",dict[@"id"]];
//        //将地址传过去
//        NSString *string = [NSString stringWithFormat:@"%@ %@",_cityLabel.text,_detailedAddressFiedld.text];
//        if ([self.pushString isEqualToString:@"0"]) {
//            if (_placeBlock) {
//                _placeBlock(string,_addressId);
//            }
//        }
//         [self.navigationController popViewControllerAnimated:YES];
//
//        } failure:^(NSError *error) {
//            [self.loadingView stopAnimation];
//            if (error.code == -1009) {
//                [self showNoticeView:NetWorkNotReachable];
//            }else{
//                [self showNoticeView:NetWorkTimeout];
//            }
//        }];

}

#pragma mark-限制手机号输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _telePhoneFiedld) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (_telePhoneFiedld.text.length >= 20){
            _telePhoneFiedld.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}
-(void)resignTextfieldFirstRespoder{
    [_nameTextFiedld resignFirstResponder];
    [_telePhoneFiedld resignFirstResponder];
    [_detailedAddressFiedld resignFirstResponder];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _telePhoneFiedld) {
        //弹起数字键盘
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [_nameTextFiedld resignFirstResponder];
        [_detailedAddressFiedld resignFirstResponder];
    }
}
#pragma mark-添加单击手势  点击任意一处收回键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self resignTextfieldFirstRespoder];
}

-(void)dealloc{
    [CKCNotificationCenter removeObserver:self name:@"bank" object:nil];

}
@end
