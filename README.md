# JZNewVersionDemo
版本新特性,可以任意自定义自己想要的东西


// 进入体验的按钮点击block
-(void)newVersionViewEnterBlock:(JZNewVersionViewEnterBtnBlock)enterBlock;


/**
 初始化方法

 @param frame 传入frame
 @param datas 传入图片数组
 @return 返回JZNewVersionView
 */
- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas;


/**
 本地图片数组
 */
@property(nonatomic,weak)NSArray * jz_localImages;


/**
 网络图片Url
 */
@property(nonatomic,weak)NSArray * jz_netUrls;


/**
 pageControl的默认颜色 默认：灰色
 */
@property(nonatomic,strong) UIColor * jz_pageControlNormalColor;


/**
 pageControl的选中颜色 默认：红色
 */
@property(nonatomic,strong) UIColor * jz_pageControlCurrentColor;


/**
 隐藏pageControl 默认显示(显示yes，隐藏no)
 */
@property(nonatomic,assign) BOOL jz_pageControlShow;


/**
 进入体验按钮的显示文字 默认：进入体验
 */
@property(nonatomic,copy) NSString * jz_enterBtnTitle;


/**
 进入体验按钮的背景颜色 默认：黑色
 */
@property(nonatomic,strong) UIColor * jz_enterBtnBackColor;


/**
 进入按钮的边框颜色 默认：绿色
 */
@property(nonatomic,strong) UIColor * jz_enterBtnBorderColor;


/**
 进入按钮的圆角 默认：6px
 */
@property(nonatomic,assign) CGFloat jz_enterBtnCornerRadius;


/**
 进入按钮的文字颜色 默认：白色
 */
@property(nonatomic,strong) UIColor * jz_enterBtnTitleColor;


/**
 进入按钮的字体大小 默认：40px
 */
@property(nonatomic,assign) CGFloat jz_enterBtnTitleFont;
