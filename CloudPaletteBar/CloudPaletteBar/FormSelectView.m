//
//  FormSelectView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FormSelectView.h"
#import "DVSwitch.h"
#import "CloudPaletteBar.h"

@interface FormSelectView()<UIScrollViewDelegate>{

    UIScrollView *scrollViewContent;
}
@property (nonatomic,strong) NSMutableArray *vcArray;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@property (nonatomic,strong) NSMutableArray *lineArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation FormSelectView

// 导入数据
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles LineArray:(NSMutableArray *)lineArray ImageNameArray:(NSMutableArray *)imageNameArray{
    self.vcArray = [[NSMutableArray alloc]init];
    [self.vcArray addObjectsFromArray:vc];
    self.titlesArray = [NSMutableArray array];
    [self.titlesArray addObjectsFromArray:titles];
    self.lineArray=lineArray;
    self.imageArray=imageNameArray;
    [self initContentScrollview];
    [self initScrollviewWithTitles:titles lineArray:lineArray ImageNameArray:imageNameArray];
    
    
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
    [self.superview addSubview:scrollViewContent];
    NSLog(@"%ld",(long)self.selectIndex);
    NSLog(@"%f",self.superview.frame.size.width);
    [scrollViewContent setContentOffset:CGPointMake(self.selectIndex*self.superview.frame.size.width, 0) animated:YES];//contentOffset=CGPointMake(self.selectIndex*self.superview.frame.size.width, 0);
}

- (void)initScrollviewWithTitles:(NSArray *)titles lineArray:(NSMutableArray *)lineArray ImageNameArray:(NSMutableArray *)imageNameArray{
    NSLog(@"%f-----%f",self.frame.size.width,self.frame.size.height);
    for (int i=0; i<titles.count; i++) {
        [self addChildViewController:self.vcArray[i] title:titles[i]];
        [ self _initView:CGRectMake(self.frame.size.width/titles.count*i, 0, self.frame.size.width/titles.count, self.frame.size.height) ButtonTitle:[titles objectAtIndex:i] DataBlackImageName:[imageNameArray objectAtIndex:i] ButtonTag:1000+i LineImageName:[lineArray objectAtIndex:i] ImageTag:200+i];
        [self addChildView:i];
    }
}

-(void)_initView:(CGRect)frame ButtonTitle:(NSString *)title DataBlackImageName:(NSString *)imageName ButtonTag:(int)buttonTag LineImageName:(NSString *)lineImageName ImageTag:(NSInteger)imageTag{
//    UIView *view=[[UIView alloc]initWithFrame:frame];
//    view.backgroundColor = [UIColor redColor];
//    [self addSubview:view];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((frame.size.width-50)/2+frame.origin.x, 0, 50, 50);
    [button addTarget:self action:@selector(Clock:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    [button setBackgroundImage:OdeSetImageName(imageName) forState:UIControlStateNormal];
    button.tag=buttonTag;
    if (self.selectIndex==buttonTag-1000) {
        button.selected=YES;
    }
    [button setBackgroundImage:OdeSetImageName(@"select_Image") forState:UIControlStateSelected];
    [button setBackgroundImage:OdeSetImageName(@"select_Image") forState:UIControlStateHighlighted];
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:OdeSetImageName(lineImageName)];
    imageView.frame=CGRectMake(frame.size.width-(frame.size.width-50)/2+frame.origin.x, 25, frame.size.width-50, 4);
    imageView.tag=imageTag;
    [self addSubview:button];
    [self addSubview:imageView];
    
}

-(void)Clock:(id)sender{
    UIButton *button=(UIButton *)sender;
    self.ClockTitle(button.tag-1000);
    [self disSelectButton];
    if (button.selected) {
        button.selected=NO;
    }else{
        button.selected=YES;
    }
    [button setBackgroundImage:OdeSetImageName([self.imageArray objectAtIndex:button.tag-1000]) forState:UIControlStateNormal];
    scrollViewContent.contentOffset=CGPointMake((button.tag-1000)*self.superview.frame.size.width, 0);
    self.selectIndex=button.tag-1000;
}

-(void)disSelectButton{
    for (int i=0; i<self.imageArray.count; i++) {
        UIButton *button1=[self viewWithTag:1000+self.imageArray.count-1-i];
        button1.selected=NO;
    }
}

// 添加子控制器视图
- (void)addChildView:(NSInteger)index{
    UIViewController *superVC = [self findViewController:self];
    UIViewController *vc = superVC.childViewControllers[index];
    CGRect frame = scrollViewContent.bounds;
    frame.origin.x = self.superview.frame.size.width * index;
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
//    dVSwitch.selectedIndex=index;
    self.ClockTitle(index);
    NSLog(@"%f",scrollView.contentOffset.x/screen_width);
    [self disSelectButton];
    UIButton *button= [self viewWithTag:index+1000];
    button.selected=YES;
    [self addChildView:index];
    self.selectIndex=index;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/screen_width;
    //    dVSwitch.selectedIndex=index;
    self.ClockTitle(index);
    NSLog(@"%f",scrollView.contentOffset.x/screen_width);
    [self disSelectButton];
    UIButton *button= [self viewWithTag:index+1000];
    button.selected=YES;
//    [self addChildView:index];
    self.selectIndex=index;
}
@end
