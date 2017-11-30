//
//  MoreInfoView.m
//  parallax
//
//  Created by ls on 2017/11/30.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import "MoreInfoView.h"

@implementation MoreInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth   = 0.5;
        self.layer.borderColor   = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        
        self.imageView.frame =frame;
        [self addSubview:self.imageView];
 
    }
    return self;
}


-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

@end
