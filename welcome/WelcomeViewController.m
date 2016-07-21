//
//  WelcomeViewController.m
//  welcome
//
//  Created by spare on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WelcomeViewController.h"
#import "iCarousel.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


@interface WelcomeViewController ()<iCarouselDelegate,iCarouselDataSource>
@property(nonatomic)iCarousel *ic;
@property(nonatomic)UIPageControl *pc;

/**<#属性描述#> */
@property (nonatomic) NSArray *imageNames;
@end

@implementation WelcomeViewController

//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
//    if (option == iCarouselOptionShowBackfaces) {
//        value = NO;
//    }
//    return  value;
//}


-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    NSLog(@"%ld",self.imageNames.count);

    return  self.imageNames.count;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    
//            for (int i = 0; i < self.imageNames.count; i++) {
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            UIImageView *imageView = [UIImageView new];
            [view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(0);
            }];
            imageView.tag = 100;
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.userInteractionEnabled = YES;
                if (index == 4) {
                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 200)];
                    [imageView addSubview:btn];
                    [btn setTitle:@"开始新的旅程" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
                    
                }
    
//        UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
        NSString *imageName = self.imageNames[index];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
        NSString *imagePath = [path stringByAppendingPathComponent:imageName];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    

    
      return view;
    
}
-(void)clickBtn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tbc = [sb instantiateViewControllerWithIdentifier:@"main"];
    self.view.window.rootViewController = tbc;
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSString *version = infoDic[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"Runversion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   }
- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageNames];
    [self ic];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (iCarousel *)ic {
	if(_ic == nil) {
		_ic = [[iCarousel alloc] init];
        [self.view addSubview:_ic];
        _ic.scrollSpeed = .2;
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.right.bottom.equalTo(0);
        }];
        _ic.delegate = self;
        _ic.dataSource = self;
//        _ic.type = 1;
        _pc = [UIPageControl new];
        [_ic addSubview: _pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(0);
           
        }];
        _pc.numberOfPages = self.imageNames.count;
        
	}
	return _ic;
}
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = _ic.currentItemIndex;
}
- (NSArray *)imageNames {
	if(_imageNames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
        _imageNames = [[NSFileManager defaultManager]subpathsAtPath:path];
	}
	return _imageNames;
}

@end
