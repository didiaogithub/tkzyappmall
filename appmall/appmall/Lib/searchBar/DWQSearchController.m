
//
//  Created by 杜文全 on 16/8/14.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//
/******* 屏幕尺寸 *******/
#define DWQMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define DWQMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define DWQMainScreenBounds [UIScreen mainScreen].bounds
#import "DWQSearchController.h"
#import "DWQSearchBar.h"
#import "DWQTagView.h"
#import "HistorySearchCell.h"
#import "HotSerachCell.h"

static NSString *const HotCellID = @"HotCellID";
static NSString *const HistoryCellID = @"HistoryCellID";

@interface DWQSearchController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DWQTagViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) DWQSearchBar *searchBar;
/** 历史搜索数组 */
@property (nonatomic, strong) NSMutableArray *historyArr;
/** 热门搜索数组 */
@property (nonatomic, strong) NSMutableArray *HotArr;
/** 得到热门搜索TagView的高度 */
@property (nonatomic ,assign) CGFloat tagViewHeight;
@property (nonatomic ,assign) CGFloat hisViewHeight;
@end

@implementation DWQSearchController
-(instancetype)init
{
    if (self = [super init]) {
        self.historyArr = [NSMutableArray array];
        self.HotArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self initData];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 245, 245);
    
}
-(void)initData{

    /**
     *  造热门搜索的假数据
     */
    self.historyArr = [NSMutableArray arrayWithObjects:@"C语言",@"C#",@"HTML5",@"objective-c?"@"Swift", nil];
    
    self.HotArr = [NSMutableArray arrayWithObjects:@"你想要搜索什么呢",@"web编程",@"JAVA8",@"JAVAVEE",@"Objective-c",@"SWift",@"iOS分享之路",@"MacBokPro",@"iOS直播",@"APPLE", nil];

}
-(void)createUI{

    self.view.backgroundColor=[UIColor whiteColor];
    DWQSearchBar *bar = [[DWQSearchBar alloc] initWithFrame:CGRectMake(0, 0, DWQMainScreenWidth, 30)];
    bar.layer.cornerRadius=4;
    bar.layer.masksToBounds=YES;
    bar.placeholder=@"输入你想要找的产品名称";
    _searchBar = bar;
    
    bar.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"取消" forState:0];
    [rightBtn setTitleColor:[UIColor grayColor] forState:0];
    [rightBtn addTarget:self  action:@selector(actionCancell) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.titleView = bar;

    
    [self.view addSubview:self.tableview];
}

-(void)actionCancell{
    [self .navigationController popViewControllerAnimated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.historyArr.count == 0) {
        return 1;
    }
    else
    {
        return 1;
    }
}
/** section的数量 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.historyArr.count == 0) {
        return 1;
    }
    else
    {
        return 2;
    }
}
/** 使第一个cell（热门搜索的cell不可编辑） */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleNone;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}
/** CELL */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.historyArr.count == 0) {
        HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
        
        hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
        hotCell.userInteractionEnabled = YES;
        hotCell.hotSearchArr = self.HotArr;
        hotCell.dwqTagV.delegate = self;
        /** 将通过数组计算出的tagV的高度存储 */
        self.tagViewHeight = hotCell.dwqTagV.frame.size.height ;
        return hotCell;
    }
    else
    {
        if (indexPath.section == 0) {
            HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
            hotCell.dwqTagV.delegate = self;
            hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            hotCell.userInteractionEnabled = YES;
            hotCell.hotSearchArr = self.historyArr;
            /** 将通过数组计算出的tagV的高度存储 */
            self.hisViewHeight = hotCell.dwqTagV.frame.size.height;
            return hotCell;
        }
        else
        {
            HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
            
            hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            hotCell.userInteractionEnabled = YES;
            hotCell.hotSearchArr = self.HotArr;
            hotCell.dwqTagV.delegate = self;
            /** 将通过数组计算出的tagV的高度存储 */
            self.tagViewHeight = hotCell.dwqTagV.frame.size.height;
            return hotCell;
        }
    }
}
/** HeaderView */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    headView.backgroundColor = [UIColor colorWithWhite:0.922 alpha:1.000];
    for (UILabel *lab in headView.subviews) {
        [lab removeFromSuperview];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 10, 45)];

   
    titleLab.textColor = [UIColor colorWithWhite:0.229 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLab];
    if (self.historyArr.count == 0) {
        
        titleLab.text = @"热门搜索";
        UILabel *backLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,1)];
        backLab.backgroundColor = RGBCOLOR(220, 220, 220);
        [headView addSubview:backLab];
    }
    else
    {
        if (section == 0) {
            
            UIButton *deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setFrame:CGRectMake(KscreenWidth - 55, 0, 44, 44)];
            [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:0];
            [headView addSubview:deleteBtn];
            UILabel *backLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,1)];
            backLab.backgroundColor = RGBCOLOR(220, 220, 220);
            [headView addSubview:backLab];
            [deleteBtn addTarget:self  action:@selector(removeAllHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
            titleLab.text = @"历史记录";
        }
        else
        {
            titleLab.text = @"热门搜索";
            UILabel *backLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,10)];
            backLab.backgroundColor = RGBCOLOR(220, 220, 220);
             [headView addSubview:backLab];
            
        }
    }
    
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}
/** FooterView */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
        return view;
    
}
/** 头部的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
/** cell的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.historyArr.count == 0) {
        
        return self.tagViewHeight + 40;
    }
    else
    {
        if (indexPath.section == 0) {
            return self.hisViewHeight + 40 ;
        }
        else
        {
            return self.tagViewHeight + 20;
        }
    }
}
/** FooterView的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.historyArr.count == 0) {
        return 0.1;
    }
    else
    {
        if (section == 0) {
            return 0.1;
        }
        else
        {
            return 46;
        }
    }
}
#pragma mark -- 实现点击热门搜索tag  Delegate
-(void)DWQTagView:(UIView *)dwq fetchWordToTextFiled:(NSString *)KeyWord
{
    NSLog(@"点击了%@",KeyWord);
    self.searchBar.text=KeyWord;
    
}

#pragma mark -- 删除单个搜索历史
-(void)removeSingleTagClick:(UIButton *)removeBtn
{
    [self.historyArr removeObjectAtIndex:removeBtn.tag - 250];
    
    [self.tableview reloadData];
}
#pragma mark -- 删除所有的历史记录
-(void)removeAllHistoryBtnClick
{
    [self.historyArr removeAllObjects];
    [self.tableview reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[HotSerachCell class] forCellReuseIdentifier:HotCellID];
        [_tableview registerNib:[UINib nibWithNibName:@"HistorySearchCell" bundle:nil] forCellReuseIdentifier:HistoryCellID];
        _tableview.backgroundColor = [UIColor colorWithWhite:0.934 alpha:1.000];
    }
    return _tableview;
}
//textfield的代理方法：自行写逻辑
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
       return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;{
    
    
    return YES;
}



@end
