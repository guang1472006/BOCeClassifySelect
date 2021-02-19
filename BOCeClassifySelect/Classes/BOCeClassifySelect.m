//
//  BOCeClassifySelect.m
//  Industrial
//
//  Created by boce on 2020/7/10.
//  Copyright © 2020 boce. All rights reserved.
//

#import "BOCeClassifySelect.h"

@interface BOCeClassifySelect()<UITableViewDelegate,UITableViewDataSource,
UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)UIView *spearView;

@property(strong,nonatomic)UICollectionViewFlowLayout *layout;

@property(strong,nonatomic)UIButton *ClickButton;

@property(strong,nonatomic)UIButton *CancleButton;

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UITableView *tableView;

@end

@implementation BOCeClassifySelect

-(CGSize)intrinsicContentSize{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
}

-(id)init{
    if (self=[super init]){
        //分割线
        [self.spearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(1);
            make.top.equalTo(self);
        }];
        
        //取消
        [self.CancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(8);
        }];
        //标题
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.CancleButton);
            make.centerX.equalTo(self);
        }];
        //确定
        [self.ClickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-8);
            make.centerY.equalTo(self.CancleButton);
        }];
        //已选择的数据
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.CancleButton.mas_bottom).offset(8);
            make.height.mas_equalTo(45);
        }];
        //选择列表
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectView.mas_bottom);
            make.left.right.equalTo(self.collectView);
            make.bottom.equalTo(self);
        }];
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor whiteColor];
        UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
        self.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,300);
        [window addSubview:self];
    }
    return self;
}

-(void)show{
    BOCeClassifySelect *BOCeClassify=nil;
    UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
    for (UIView *subView in window.subviews){
        if ([subView isKindOfClass:[self class]]) {
            BOCeClassify=(BOCeClassifySelect *)subView;
        }
    }
    if (!BOCeClassify){
        BOCeClassify=self;
        UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
        BOCeClassify.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,300);
        [window addSubview:BOCeClassify];
        [self.CollectDataArray removeAllObjects];
        [self.collectView reloadData];
    }
    if ([self statusBarHight]==44){
        [UIView animateWithDuration:0.5 animations:^{
            BOCeClassify.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-334, [UIScreen mainScreen].bounds.size.width,300);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            BOCeClassify.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-300, [UIScreen mainScreen].bounds.size.width,300);
        }];
    }
}

-(CGFloat)statusBarHight{
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    }
    else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return 0;
}

-(void)disMiss{
    UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
    BOCeClassifySelect *BOCeClassify=nil;
    for (UIView *view in window.subviews){
        if ([view isKindOfClass:[BOCeClassifySelect class]]) {
            BOCeClassify=(BOCeClassifySelect *)view;
        }
    }
    if (BOCeClassify) {
        [UIView animateWithDuration:0.5 animations:^{
            BOCeClassify.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        } completion:^(BOOL finished) {
            [BOCeClassify removeFromSuperview];
        }];
    }
}

#pragma mark TableView

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ss"];
    cell.textLabel.text=self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name=self.dataArray[indexPath.row];
    if (self.CollectDataArray.count<4){
        [self.CollectDataArray addObject:name];
        [self.collectView reloadData];
        if (_delegate&&[_delegate respondsToSelector:@selector(BOCeClassifyCellDidSelect:)]) {
            [_delegate BOCeClassifyCellDidSelect:name];
        }
    }
}

#pragma mark CollectView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.CollectDataArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    BOCeClassifyCollectCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    cell.titleLable.text=self.CollectDataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate&&[_delegate respondsToSelector:@selector(BOCeClassifyButtonDidCancle:)]) {
        [_delegate BOCeClassifyButtonDidCancle:self.CollectDataArray[indexPath.row]];
    }
}

#pragma mark Lazy

-(UIView *)spearView{
    if (!_spearView) {
        _spearView=[UIView new];
        _spearView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self addSubview:_spearView];
    }
    return _spearView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ss"];
        _tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(UICollectionView *)collectView{
    if (!_collectView) {
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        [_collectView registerClass:[BOCeClassifyCollectCell class] forCellWithReuseIdentifier:@"ss"];
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.showsHorizontalScrollIndicator=NO;
        [self addSubview:_collectView];
    }
    return _collectView;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout=[[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing=5;
        _layout.minimumLineSpacing=5;
        _layout.sectionInset=UIEdgeInsetsMake(5,5,5,5);
        _layout.estimatedItemSize=CGSizeMake(100,35);
    }
    return _layout;
}

-(UIButton *)ClickButton{
    if (!_ClickButton) {
        _ClickButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_ClickButton setTitle:@"确定" forState:UIControlStateNormal];
        [_ClickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ClickButton.layer setBorderWidth:1];
        [_ClickButton.layer setBorderColor:[UIColor blackColor].CGColor];
        [_ClickButton.layer setCornerRadius:5];
        [_ClickButton setClipsToBounds:YES];
        _ClickButton.titleLabel.font=[UIFont systemFontOfSize:15];
         _ClickButton.contentEdgeInsets=UIEdgeInsetsMake(5, 10, 5, 10);
        [_ClickButton addTarget:self action:@selector(ClickBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_ClickButton];
    }
    return _ClickButton;
}

-(UIButton *)CancleButton{
    if (!_CancleButton) {
        _CancleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_CancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_CancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CancleButton.layer setBorderWidth:1];
        [_CancleButton.layer setBorderColor:[UIColor blackColor].CGColor];
        [_CancleButton.layer setCornerRadius:5];
        [_CancleButton setClipsToBounds:YES];
         _CancleButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_CancleButton addTarget:self action:@selector(cancleBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        _CancleButton.contentEdgeInsets=UIEdgeInsetsMake(5,5,5,5);
        [self addSubview:_CancleButton];
    }
    return _CancleButton;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[UILabel new];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.text=@"选择分类";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(NSMutableArray *)CollectDataArray{
    if (!_CollectDataArray) {
        _CollectDataArray=[[NSMutableArray alloc]init];
    }
    return _CollectDataArray;
}

#pragma mark Action
-(void)cancleBtnAct:(UIButton *)button{
    [self disMiss];
}

-(void)ClickBtnAct:(UIButton *)button{
    if (self.CollectDataArray.count>4||self.CollectDataArray.count<2) {
        if (_delegate&&[_delegate respondsToSelector:@selector(BOCeClassifyButtonDidError:)]) {
            [_delegate BOCeClassifyButtonDidError:@"分类最少2级,最多4级"];
        }
    }else{
        [self disMiss];
        if (_delegate&&[_delegate respondsToSelector:@selector(BOCeClassifyButtonDidSelect:)]) {
            [_delegate BOCeClassifyButtonDidSelect:self.CollectDataArray];
        }
    }
}

@end

@implementation BOCeClassifyCollectCell

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]){
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    CGSize size =[self.titleLable.text sizeWithAttributes:@{NSFontAttributeName:self.titleLable.font}];
    UICollectionViewLayoutAttributes *att=[super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    att.frame=CGRectMake(att.frame.origin.x,att.frame.origin.y,size.width+20,25);
    return att;
}

-(BOCeLabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[BOCeLabel new];
        [self.contentView addSubview:_titleLable];
    }
    return _titleLable;
}

@end

@implementation BOCeLabel

-(void)drawRect:(CGRect)rect{
    [self.text drawInRect:CGRectMake(rect.origin.x+10,rect.origin.y+3, CGRectGetWidth(rect),CGRectGetHeight(rect)) withAttributes:@{NSFontAttributeName:self.font}];
}

@end


