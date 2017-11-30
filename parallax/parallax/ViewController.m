//
//  ViewController.m
//  parallax
//
//  Created by ls on 2017/11/30.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import "ViewController.h"
#import "MoreInfoView.h"

#define Screen_Width  [UIScreen mainScreen].bounds.size.width
#define Screen_Height  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, assign) CGFloat        k;
@property (nonatomic, assign) CGFloat        b;

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 计算斜率
    [self linearFunctionPointA:CGPointMake(0, 0)
                        pointB:CGPointMake(Screen_Width, Screen_Width)];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
   
    NSArray *imageArray = @[
                            [UIImage imageNamed:@"1"],
                            [UIImage imageNamed:@"2"],
                            [UIImage imageNamed:@"3"],
                            [UIImage imageNamed:@"4"]
                            ];
    
    for (NSInteger i = 0; i<imageArray.count ; i++) {
        
        MoreInfoView *infoView = [[MoreInfoView alloc]initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, Screen_Height)];
        
        infoView.imageView.image = imageArray[i];
        
        [self.scrollView addSubview:infoView];
        
    }
    
    
    self.scrollView.contentSize = CGSizeMake(imageArray.count * Screen_Width, Screen_Height);
 
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat X = scrollView.contentOffset.x;
    
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[MoreInfoView class]]) {
            
            MoreInfoView *temp = (MoreInfoView *)obj;
            // 产生视差效果
            CGRect rect = temp.imageView.frame;
            rect.origin.x = _k * (X - idx*Screen_Width) + _b;
            temp.imageView.frame = rect;
        }
        
    }];
    
}

- (void)linearFunctionPointA:(CGPoint)pointA
                      pointB:(CGPoint)pointB
{
    CGFloat x1 = pointA.x; CGFloat y1 = pointA.y;
    CGFloat x2 = pointB.x; CGFloat y2 = pointB.y;
    
    _k = calculateSlope(x1, y1, x2, y2);
    _b = calculateConstant(x1, y1, x2, y2);
}

// 计算用
CGFloat calculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2)
{
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2)
{
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}


@end
