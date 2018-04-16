//
//  MineViewController.m
//  appmall
//
//  Created by 王博 on 15/04/2018.
//  Copyright © 2018 com.tcsw.tkzy. All rights reserved.
//

#import "MineViewController.h"
//#import "SCMineInfoViewController.h"
//#import "SetUpViewController.h"
#import "SCMineTableViewCell.h"
#import "SCUserInfoModel.h"
@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>//, SCUserInfoSignUpDelegate, SCMineOrderCellDelegate>
@property (nonatomic, strong) UITableView *mineTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SCUserInfoModel *userInfoM;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = [UIColor blueColor];
    [self createUIView];

}

- (void)createUIView {
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+NaviAddHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-NaviAddHeight - BOTTOM_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mineTableView.rowHeight = UITableViewAutomaticDimension;
    _mineTableView.estimatedRowHeight = 0;
    _mineTableView.estimatedSectionFooterHeight = 0;
    _mineTableView.estimatedSectionHeaderHeight = 0;
    _mineTableView.delegate  = self;
    _mineTableView.dataSource = self;
    _mineTableView.separatorColor = [UIColor tt_grayBgColor];
    _mineTableView.backgroundColor = [UIColor tt_grayBgColor];
    [self.view addSubview:_mineTableView];
    
    [self bindMineData];
    
}

-(void)bindMineData{
    self.dataArray = [NSMutableArray array];
    CellModel *userInfoM = [self createCellModel:[SCUserInfoCell class] userInfo:self.userInfoM height:180];
    userInfoM.delegate = self;
    SectionModel *section0 = [self createSectionModel:@[userInfoM] headerHeight:0.1 footerHeight:0.1];
    [self.dataArray addObject:section0];
    
    CellModel *orderCellM = [self createCellModel:[SCMineOrderCell class] userInfo:nil height:115];
    orderCellM.delegate = self;
    SectionModel *section1 = [self createSectionModel:@[orderCellM] headerHeight:0.1 footerHeight:10];
    [self.dataArray addObject:section1];
    
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *mallintegralshow = [NSString stringWithFormat:@"%@", [KUserdefaults objectForKey:MallintegralShowOrNot]];
    if ([mallintegralshow isEqualToString:@"ture"] || [mallintegralshow isEqualToString:@"1"]) {
        [titleArray addObjectsFromArray:@[@"我的收藏", @"优惠券", @"欠款管理", @"分期还款", @"发票管理", @"收货地址", @"关于我们", @"设置"]];
        [imageArray addObjectsFromArray:@[@"collected", @"score", @"recommondReward", @"minemall", @"addressred",  @"minehelp", @"ckysred", @"minesetup"]];
    }else{
        [titleArray addObjectsFromArray:@[@"我的收藏", @"我的积分", @"推荐有奖", @"我的地址", @"问题帮助", @"关于我们", @"设置"]];
        [imageArray addObjectsFromArray:@[@"collected", @"score", @"recommondReward", @"addressred",  @"minehelp", @"ckysred", @"minesetup"]];
        
    }
    //控制消息中心显示不显示  0:不显示，1：显示
    NSString *msgshow = [NSString stringWithFormat:@"%@", [KUserdefaults objectForKey:@"YDSC_msgShow"]];
    if ([msgshow isEqualToString:@"ture"] || [msgshow isEqualToString:@"1"]) {
        [titleArray insertObject:@"消息中心" atIndex:1];
        [imageArray insertObject:@"messageCenter" atIndex:1];
    }
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        CellModel *functionM = [self createCellModel:[SCMineFunctionCell class] userInfo:@{@"title":titleArray[i], @"image": imageArray[i]} height:55];
        SectionModel *section2 = [self createSectionModel:@[functionM] headerHeight:0.1 footerHeight:0.1];
        [self.dataArray addObject:section2];
    }
    
    [self.mineTableView reloadData];
}

-(CellModel*)createCellModel:(Class)cls userInfo:(id)userInfo height:(CGFloat)height {
    CellModel *model = [[CellModel alloc] init];
    model.selectionStyle = UITableViewCellSelectionStyleNone;
    model.userInfo = userInfo;
    model.height = height;
    model.className = NSStringFromClass(cls);
    return model;
}

-(SectionModel*)createSectionModel:(NSArray<CellModel*>*)items headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight {
    SectionModel *model = [SectionModel sectionModelWithTitle:nil cells:items];
    model.headerhHeight = headerHeight;
    model.footerHeight = footerHeight;
    return model;
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_dataArray){
        return _dataArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    if(s.cells) {
        return s.cells.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SectionModel *s = _dataArray[indexPath.section];
    CellModel *item = s.cells[indexPath.row];
    
    SCMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.reuseIdentifier];
    if(!cell) {
        cell = [[NSClassFromString(item.className) alloc] initWithStyle:item.style reuseIdentifier:item.reuseIdentifier];
    }
    cell.selectionStyle = item.selectionStyle;
    cell.accessoryType = item.accessoryType;
    cell.delegate = item.delegate;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SectionModel *s = _dataArray[indexPath.section];
    CellModel *item = s.cells[indexPath.row];
    
    if(item.title) {
        cell.textLabel.text = item.title;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithRed:0.294 green:0.298 blue:0.302 alpha:1.00];
    }
    if(item.subTitle) {
        cell.detailTextLabel.text = item.subTitle;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.294 green:0.298 blue:0.302 alpha:1.00];
    }
    
    SEL selector = NSSelectorFromString(@"fillData:");
    if([cell respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [cell performSelector:selector withObject:item.userInfo];
#pragma clang diagnostic pop
    }
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *s = _dataArray[indexPath.section];
    CellModel *item = s.cells[indexPath.row];
    return item.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.headerhHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.footerHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}


@end
