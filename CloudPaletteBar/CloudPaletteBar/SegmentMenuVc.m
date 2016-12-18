//
//  SegmentMenuVc.m
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SegmentMenuVc.h"
#import "DVSwitch.h"
#import "CloudPaletteBar.h"

@interface SegmentMenuVc ()<UIScrollViewDelegate>{
    UIScrollView *scrollViewContent;
    DVSwitch *dVSwitch;
}
@property (nonatomic,strong) NSMutableArray *vcArray;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@end

@implementation SegmentMenuVc

// 导入数据
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles{
    self.vcArray = [[NSMutableArray alloc]init];
    [self.vcArray addObjectsFromArray:vc];
    self.titlesArray = [NSMutableArray array];
    [self.titlesArray addObjectsFromArray:titles];
    [self initContentScrollview];
    [self initScrollviewWithTitles:titles];
    
    
}

// 初始化ContentScrollview
- (void)initContentScrollview{
    
    scrollViewContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), self.superview.frame.size.width, self.superview.frame.size.height - CGRectGetMaxY(self.frame))];
    scrollViewContent.delegate = self;
    scrollViewContent.bounces = NO;
    scrollViewContent.contentSize = CGSizeMake(self.superview.frame.size.width * self.vcArray.count,  self.superview.frame.size.height - CGRectGetMaxY(self.frame));
    scrollViewContent.showsHorizontalScrollIndicator = NO;
    scrollViewContent.showsVerticalScrollIndicator = NO;
    scrollViewContent.pagingEnabled = YES;
     NSLog(@"%@",self.superview);
    [self.superview addSubview:scrollViewContent];
}

- (void)initScrollviewWithTitles:(NSArray *)titles{
    for (int i=0; i<titles.count; i++) {
        [self addChildViewController:self.vcArray[i] title:titles[i]];
    }
    dVSwitch = [DVSwitch switchWithStringsArray:titles];
    dVSwitch.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    dVSwitch.font = [UIFont systemFontOfSize:14];
    dVSwitch.sliderColor = TASK;
    dVSwitch.backgroundColor=[UIColor whiteColor];
    dVSwitch.selectedIndex=self.selectIndex;
    dVSwitch.layer.borderWidth=1.0;
    dVSwitch.layer.borderColor=[TASK CGColor];
    [self addSubview:dVSwitch];
    [self addChildView:self.selectIndex];
    dVSwitch.selectedIndex=self.selectIndex;
    __weak typeof(self)weakSelf=self;
    [dVSwitch setWillBePressedHandler:^(NSUInteger index) {
        [scrollViewContent setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:YES];
        [weakSelf addChildView:index];
    }];
   
    
    
}

// 添加子控制器视图
- (void)addChildView:(NSInteger)index{
    UIViewController *superVC = [self findViewController:self];
    UIViewController *vc = superVC.childViewControllers[index];
    CGRect frame = scrollViewContent.bounds;
    frame.origin.x = self.superview.frame.size.width * index;
    NSLog(@"%@",vc);
    vc.view.frame = frame;
    [scrollViewContent addSubview:vc.view];
}
// 添加子子控制器
-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
    UIViewController *superVC = [self findViewController:self];
    childVC.title = vcTitle;
    [superVC addChildViewController:childVC];
}
// 视图控制器
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


// scrollView滚动监听
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index=scrollView.contentOffset.x/screen_width;
    dVSwitch.selectedIndex=index;
    NSLog(@"%f",scrollView.contentOffset.x/screen_width);
    [self addChildView:index];
}







@end
