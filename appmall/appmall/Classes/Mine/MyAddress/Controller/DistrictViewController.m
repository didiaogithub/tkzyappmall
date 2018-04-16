//
//  DistrictViewController.m
//  TinyShoppingCenter
//
//  Created by 庞宏侠 on 16/9/14.
//  Copyright © 2016年 ckys. All rights reserved.
//

#import "DistrictViewController.h"
#import "AddAddressViewController.h"
@interface DistrictViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SelecteAreaModel *districtModel;

}
@property(nonatomic,strong)UITableView *districtTableView;
@property(nonatomic,strong)NSMutableArray *districtArray;


@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择地区";
    [self createTableView];
    [self createCollectedListData];
}
-(NSMutableArray *)districtArray{
    if (_districtArray == nil) {
        _districtArray = [[NSMutableArray alloc] init];
    }
    return _districtArray;
}

#pragma mark-地区列表数据
-(void)createCollectedListData{
    //    地区类型（0：省   1：市    2：县（区））
    NSString *codestr = [NSString stringWithFormat:@"%@",self.areaModel.code];
    if (IsNilOrNull(codestr)) {
       codestr = @"";
    }
    NSDictionary *pramaDic = @{@"areaCode":codestr};
//    NSString *districtUrl = [NSString stringWithFormat:@"%@%@", WebServiceAPI, GetAreaUrl];
//    [HttpTool getWithUrl:districtUrl params:pramaDic success:^(id json) {
//        NSDictionary *dict = json;
//        if([dict[@"code"] integerValue] != 200){
//            [self showNoticeView:dict[@"codeinfo"]];
//        }
//        NSArray *districtArr = dict[@"arealist"];
//        for (NSDictionary *districtDict in districtArr) {
//            districtModel = [[SelecteAreaModel alloc] init];
//            [districtModel setValuesForKeysWithDictionary:districtDict];
//            [self.districtArray addObject:districtModel];
//        }
//        [self.districtTableView reloadData];
//    } failure:^(NSError *error) {
//        if (error.code == -1009) {
//            [self showNoticeView:NetWorkNotReachable];
//        }else{
//            [self showNoticeView:NetWorkTimeout];
//        }
//    }];
    
}
-(void)createTableView{
    //选择地区
    if (@available(iOS 11.0, *)) {
        _districtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64+2+NaviAddHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-NaviAddHeight-BOTTOM_BAR_HEIGHT) style:UITableViewStylePlain];
    }else{
        _districtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, SCREEN_HEIGHT-2) style:UITableViewStylePlain];
    }
    _districtTableView.delegate  = self;
    _districtTableView.dataSource = self;
    _districtTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_districtTableView];
}

#pragma mark-tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.districtArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lineLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 49, SCREEN_WIDTH-15, 1)];
    lineLable.backgroundColor = [UIColor tt_lineBgColor];
    [cell addSubview:lineLable];
    if ([self.districtArray count]) {
        districtModel  = self.districtArray[indexPath.row];
    }
    cell.textLabel.text = districtModel.name;
    return cell;
}
#pragma mark-点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.districtArray count]) {
        districtModel  = self.districtArray[indexPath.row];
    }
    
    NSString *string = [NSString stringWithFormat:@" %@",districtModel.name];
    NSString *areaStr = [self.areaString stringByAppendingString:string];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:[AddAddressViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

    [CKCNotificationCenter postNotificationName:@"bank" object:areaStr];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
@end
