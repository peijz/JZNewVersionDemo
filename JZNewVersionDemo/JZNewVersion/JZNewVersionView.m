//
//  JZNewVersionView.m
//  JZNewVersionDemo
//
//  Created by wanhongios on 2017/10/25.
//  Copyright © 2017年 wanhongios. All rights reserved.
//
#define JZScreenWidth [UIScreen mainScreen].bounds.size.width
#define JZScreenHeight [UIScreen mainScreen].bounds.size.height
#import "JZNewVersionView.h"
#import "JZNewVersionCell.h"
@interface JZNewVersionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView * jz_collectionView;
@property(nonatomic,weak)UIPageControl * jz_pageControl; // pageControl
@property(nonatomic,weak)UIButton * jz_enterBtn; // 进入按钮
@property(nonatomic,strong) NSArray * jz_datas;
@property(nonatomic,copy) JZNewVersionViewEnterBtnBlock enterBlock; // 进入按钮的block
@end
@implementation JZNewVersionView{
    NSInteger _jz_num;
    CGFloat _currentOffsetX;
}


- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas
{
    self = [super initWithFrame:frame];
    if (self) {
        if (datas.count>0) {
            self.jz_datas = [NSArray arrayWithArray:datas];
        }else{
            self.jz_datas = @[];
        }
        [self setupView];
    }
    return self;
}

-(void)setupView{
    _jz_num = 0;
    [self setupCollectionView];
    [self setupPageControl];
    [self setupEnterBtn];
}

#pragma mark - 设置UICollectionview
-(void)setupCollectionView{
    // 滚动视图
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing      = 0.0;
    //设置单元格的尺寸
    flowLayout.itemSize = CGSizeMake(JZScreenWidth, JZScreenHeight);
    //设置头视图高度
//    flowLayout.headerReferenceSize = CGSizeMake(0, 30);
    //flowlaout的属性，横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * jz_collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    jz_collectionView.bounces = YES;
    [jz_collectionView registerClass:[JZNewVersionCell class] forCellWithReuseIdentifier:@"JZNewVersionCell"];
    jz_collectionView.backgroundColor = [UIColor whiteColor];
    jz_collectionView.contentSize = CGSizeMake(JZScreenWidth, 0);
    jz_collectionView.contentOffset = CGPointMake(_currentOffsetX, 0);
    jz_collectionView.pagingEnabled = YES;
    jz_collectionView.alwaysBounceVertical = NO;
    //jz_collectionView.contentSize = CGSizeMake(self.jz_datas.count*JZScreenWidth, JZScreenHeight);
    jz_collectionView.showsHorizontalScrollIndicator = NO;
    jz_collectionView.showsVerticalScrollIndicator = NO;
    jz_collectionView.dataSource = self;
    jz_collectionView.delegate = self;
    jz_collectionView.scrollEnabled = YES;
    [self addSubview:jz_collectionView];
    self.jz_collectionView = jz_collectionView;
}

#pragma mark - 设置pageControl
-(void)setupPageControl{
    // pageControl
    UIPageControl * jz_pageControl = [[UIPageControl alloc]init];
    jz_pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    jz_pageControl.pageIndicatorTintColor = [UIColor grayColor];
    jz_pageControl.numberOfPages = self.jz_datas.count;
    jz_pageControl.currentPage = 0;
    [self addSubview:jz_pageControl];
    self.jz_pageControl = jz_pageControl;
}

#pragma mark - 设置进入按钮
-(void)setupEnterBtn{
    // 进入按钮
    UIButton * jz_enterBtn = [[UIButton alloc]init];
    jz_enterBtn.hidden = YES;
    jz_enterBtn.backgroundColor = [UIColor blackColor];
    jz_enterBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [jz_enterBtn setTitle:@"进入体验" forState:UIControlStateNormal];
    jz_enterBtn.layer.cornerRadius = 3;
    jz_enterBtn.layer.masksToBounds = YES;
    jz_enterBtn.layer.borderWidth = 0.5;
    jz_enterBtn.layer.borderColor = [UIColor redColor].CGColor;
    [jz_enterBtn addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:jz_enterBtn];
    self.jz_enterBtn = jz_enterBtn;
}

#pragma mark - 进入按钮的点击事件
-(void)enterBtnClick{
    if (_enterBlock) {
        _enterBlock();
    }
}

-(void)newVersionViewEnterBlock:(JZNewVersionViewEnterBtnBlock)enterBlock{
    _enterBlock = enterBlock;
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //获得页码
    CGFloat doublePage=scrollView.contentOffset.x / self.jz_collectionView.bounds.size.width;
    int intPage=(doublePage+0.5);
    
    //CGFloat _currentOffsetX = intPage*scrollView.frame.size.width;
    
    //设置页码
    self.jz_pageControl.currentPage=intPage;
    if (self.jz_pageControl.currentPage == self.jz_datas.count-1) {
        _currentOffsetX = intPage*scrollView.frame.size.width;
        self.jz_enterBtn.hidden = NO;
        if (_currentOffsetX < scrollView.contentOffset.x) { // 到最后一个 禁止继续右滑
            scrollView.contentOffset = CGPointMake(intPage*scrollView.frame.size.width, -64);
            return;
        }else{
            _currentOffsetX = scrollView.contentOffset.x;
            scrollView.contentOffset = CGPointMake(_currentOffsetX, -64);
            return;
        }
    }else{
        self.jz_enterBtn.hidden = YES;
    }
    if (self.jz_pageControl.currentPage == 0) { // 保证在第一个的时候  禁止左滑
        _currentOffsetX = 0;
        if (intPage*scrollView.frame.size.width >= scrollView.contentOffset.x) {
            scrollView.contentOffset = CGPointMake(intPage*scrollView.frame.size.width, -64);
            return;
        }else{
            _currentOffsetX = scrollView.contentOffset.x;
            scrollView.contentOffset = CGPointMake(_currentOffsetX, -64);
            return;
        }
    }
    
    
}

#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.jz_datas.count>0) {
        return self.jz_datas.count;
    }else{
        return 0;
    }
    
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JZNewVersionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JZNewVersionCell" forIndexPath:indexPath];
    cell.jz_imageName = self.jz_datas[indexPath.row];
    return cell;
}


#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JZScreenWidth, JZScreenHeight);
}


// 进入按钮的圆角
-(void)setJz_enterBtnCornerRadius:(CGFloat)jz_enterBtnCornerRadius{
    _jz_enterBtnCornerRadius = jz_enterBtnCornerRadius;
    if (jz_enterBtnCornerRadius>0) {
        self.jz_enterBtn.layer.cornerRadius = jz_enterBtnCornerRadius;
    }else{
        self.jz_enterBtn.layer.cornerRadius = 3;
    }
}

// 进入按钮的边框颜色
-(void)setJz_enterBtnBorderColor:(UIColor *)jz_enterBtnBorderColor{
    _jz_enterBtnBorderColor = jz_enterBtnBorderColor;
    if (jz_enterBtnBorderColor) {
        self.jz_enterBtn.layer.borderColor = jz_enterBtnBorderColor.CGColor;
    }else{
        self.jz_enterBtn.layer.borderColor = [UIColor redColor].CGColor;
    }
}

// 进入体验按钮的背景颜色
-(void)setJz_enterBtnBackColor:(UIColor *)jz_enterBtnBackColor{
    _jz_enterBtnBackColor = jz_enterBtnBackColor;
    if (jz_enterBtnBackColor) {
        self.jz_enterBtn.backgroundColor = jz_enterBtnBackColor;
    }else{
        self.jz_enterBtn.backgroundColor = [UIColor blackColor];
    }
}

// 进入体验按钮的显示文字
-(void)setJz_enterBtnTitle:(NSString *)jz_enterBtnTitle{
    _jz_enterBtnTitle = jz_enterBtnTitle;
    if (jz_enterBtnTitle.length>0) {
        [self.jz_enterBtn setTitle:jz_enterBtnTitle forState:UIControlStateNormal];
    }else{
        [self.jz_enterBtn setTitle:@"进入体验" forState:UIControlStateNormal];
    }
}

// 进入按钮的文字颜色
-(void)setJz_enterBtnTitleColor:(UIColor *)jz_enterBtnTitleColor{
    _jz_enterBtnTitleColor = jz_enterBtnTitleColor;
    if (jz_enterBtnTitleColor) {
        [self.jz_enterBtn setTitleColor:jz_enterBtnTitleColor forState:UIControlStateNormal];
    }else{
        [self.jz_enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

// 进入按钮的字体大小
-(void)setJz_enterBtnTitleFont:(CGFloat)jz_enterBtnTitleFont{
    _jz_enterBtnTitleFont = jz_enterBtnTitleFont;
    if (jz_enterBtnTitleFont>0) {
        self.jz_enterBtn.titleLabel.font = [UIFont systemFontOfSize:jz_enterBtnTitleFont];
    }else{
        self.jz_enterBtn.titleLabel.font = [UIFont systemFontOfSize:jz_enterBtnTitleFont];
    }
}

// 隐藏pageControl 默认显示(显示yes，隐藏no)
-(void)setJz_pageControlShow:(BOOL)jz_pageControlShow{
    _jz_pageControlShow = jz_pageControlShow;
    if (jz_pageControlShow) {
        self.jz_pageControl.hidden = NO;
    }else{
        self.jz_pageControl.hidden = YES;
    }
}

// pageControl的选中颜色
-(void)setJz_pageControlCurrentColor:(UIColor *)jz_pageControlCurrentColor{
    _jz_pageControlCurrentColor = jz_pageControlCurrentColor;
    if (jz_pageControlCurrentColor) {
        self.jz_pageControl.currentPageIndicatorTintColor = jz_pageControlCurrentColor;
    }else{
        self.jz_pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
}

// pageControl的默认颜色
-(void)setJz_pageControlNormalColor:(UIColor *)jz_pageControlNormalColor{
    _jz_pageControlNormalColor = jz_pageControlNormalColor;
    if (jz_pageControlNormalColor) {
        self.jz_pageControl.pageIndicatorTintColor = jz_pageControlNormalColor;
    }else{
        self.jz_pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
}


// 本地图片数组
-(void)setJz_localImages:(NSArray *)jz_localImages{
    _jz_localImages = jz_localImages;
    if (jz_localImages.count>0) {
        self.jz_datas = jz_localImages;
    }else{
        self.jz_datas = @[];
    }
}

// 网络图片Url
-(void)setJz_netUrls:(NSArray *)jz_netUrls{
    _jz_netUrls = jz_netUrls;
    if (jz_netUrls.count>0) {
        
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat jz_collectionViewX = 0;
    CGFloat jz_collectionViewY = 0;
    CGFloat jz_collectionViewW = self.bounds.size.width;
    CGFloat jz_collectionViewH = self.bounds.size.height;
    self.jz_collectionView.frame = CGRectMake(jz_collectionViewX, jz_collectionViewY, jz_collectionViewW, jz_collectionViewH);
    
    
    
    CGFloat jz_enterBtnW = 120;
    CGFloat jz_enterBtnH = 40;
    CGFloat jz_enterBtnX = (self.bounds.size.width - jz_enterBtnW)/2;
    CGFloat jz_enterBtnY = self.bounds.size.height -jz_enterBtnH -50;
    self.jz_enterBtn.frame = CGRectMake(jz_enterBtnX, jz_enterBtnY, jz_enterBtnW, jz_enterBtnH); // 进入按钮
    
    // pageControl
    CGFloat jz_pageControlX = 0;
    CGFloat jz_pageControlY = jz_enterBtnY - 60;
    CGFloat jz_pageControlW = self.bounds.size.width;
    CGFloat jz_pageControlH = 80;
    self.jz_pageControl.frame = CGRectMake(jz_pageControlX, jz_pageControlY, jz_pageControlW, jz_pageControlH);
}

@end
