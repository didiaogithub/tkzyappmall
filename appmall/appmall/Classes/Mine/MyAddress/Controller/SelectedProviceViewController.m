//
//  SelectedProviceViewController.m
//  TinyShoppingCenter
//
//  Created by 庞宏侠 on 16/9/14.
//  Copyright © 2016年 ckys. All rights reserved.
//

#import "SelectedProviceViewController.h"
#import "CityViewController.h"
#import "SelecteAreaModel.h"
@interface SelectedProviceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SelecteAreaModel *areaModel;
}
@property(nonatomic,strong) UILabel *lable;
@property(nonatomic,strong)UITableView *proviceTableView;
@property(nonatomic,strong)NSMutableArray *proviceArray;
@property (nonatomic, strong) NSMutableArray *oldFirstStrArr;//34个省首字母（所有的）
@property (nonatomic, strong) NSArray *provinceFirstStrArr;//省的首字母数组（排序并去重后的）

@end

@implementation SelectedProviceViewController


-(UILabel *)lable{
    if (_lable == nil) {
        _lable = [[UILabel alloc] init];
    }
    return _lable;
}
- (NSArray *)provinceFirstStrArr
{
    if (!_provinceFirstStrArr) {
        _provinceFirstStrArr = [[NSArray alloc] init];
    }
    return _provinceFirstStrArr;
}
- (NSMutableArray *)oldFirstStrArr
{
    if (!_oldFirstStrArr) {
        _oldFirstStrArr = [[NSMutableArray alloc] init];
    }
    return _oldFirstStrArr;
}
-(NSMutableArray *)proviceArray{
    if (_proviceArray == nil) {
        _proviceArray = [[NSMutableArray alloc] init];
    }
    return _proviceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择省份";
    [self createTableView];
    [self createCollectedListData];
}
#pragma mark-省列表数据
-(void)createCollectedListData{
//    地区类型（0：省   1：市    2：县（区））
    
//    NSDictionary *pramaDic = @{@"areaCode":@""};
//    NSString *provinceUrl = [NSString stringWithFormat:@"%@%@", WebServiceAPI, GetAreaUrl];
//    [HttpTool getWithUrl:provinceUrl params:pramaDic success:^(id json) {
//        NSDictionary *dict = json;
//        if([dict[@"code"] integerValue] != 200){
//            [self showNoticeView:dict[@"codeinfo"]];
//        }
//        NSArray *areaList = dict[@"arealist"];
//        for (NSDictionary *listdict in areaList) {
//            areaModel = [[SelecteAreaModel alloc] init];
//            [areaModel setValuesForKeysWithDictionary:listdict];
//            [self.proviceArray addObject:areaModel];
//        }
//        [self.proviceTableView reloadData];
//    } failure:^(NSError *error) {
//       [self showNoticeView:@"网络出错了"];
//    }];
    
}
//字母进行去重
- (NSArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        if ([categoryArray containsObject:[array objectAtIndex:i]] == NO) {
            [categoryArray addObject:[array objectAtIndex:i]];
        }
    }
    return categoryArray;
}
-(void)createTableView{
    //选择省
    if (@available(iOS 11.0, *)) {
        _proviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64+2+NaviAddHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-NaviAddHeight-BOTTOM_BAR_HEIGHT) style:UITableViewStylePlain];
    }else{
        _proviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, SCREEN_HEIGHT-2) style:UITableViewStylePlain];
    }
    
    _proviceTableView.delegate  = self;
    _proviceTableView.dataSource = self;
    _proviceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _proviceTableView.sectionIndexColor = [UIColor grayColor];
    [self.view addSubview:_proviceTableView];
}
#pragma mark-tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.proviceArray.count;
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
    
    if ([self.proviceArray count]) {
        areaModel = self.proviceArray[indexPath.row];
    }
    cell.textLabel.text = areaModel.name;
    return cell;
}
#pragma mark-点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityViewController *city = [[CityViewController alloc] init];
    if ([self.proviceArray count]) {
        areaModel = self.proviceArray[indexPath.row];
        city.typeStr = self.typeString;
        city.areaModel = areaModel;
    }
   
    [self.navigationController pushViewController:city animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}




@end
