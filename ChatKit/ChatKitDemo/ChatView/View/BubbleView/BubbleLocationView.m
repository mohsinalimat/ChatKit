//
//  BubbleLocationView.m
//  KeyBoardView
//
//  Created by 余强 on 16/3/23.
//  Copyright © 2016年 你好，我是余强，一位来自上海的ios开发者，现就职于bdcluster(上海大数聚科技有限公司)。这个工程致力于完成一个优雅的IM实现方案. All rights reserved.
//

#import "BubbleLocationView.h"
#define KLocationFont [UIFont boldSystemFontOfSize:15]

@interface BubbleLocationView ()

@property(nonatomic,strong) UILabel *locationLabel;

@property(nonatomic,strong) UIImageView *locationImageV;


@end

@implementation BubbleLocationView
+ (instancetype)BubbleLocationView
{
    BubbleLocationView *bubbleView = [[self alloc]init];
    return bubbleView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    
        self.locationImageV = [[UIImageView alloc]init];
        self.locationImageV.contentMode = UIViewContentModeScaleAspectFill;
        self.locationImageV.clipsToBounds = YES;
        [self addSubview:self.locationImageV];
        
        
        
        self.locationLabel = [[UILabel alloc]init];
        self.locationLabel.textColor = [UIColor blackColor];
        self.locationLabel.font = [UIFont systemFontOfSize:13];
        self.locationLabel.numberOfLines = 0;
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.locationLabel];
        
        
        
        
    }
    return self;
}


- (void)setMessage:(MessageModel *)message
{
    _message = message;

    if (_message.localPositionPhotoPath) {
        self.locationImageV.image  = [UIImage imageWithContentsOfFile:message.localPositionPhotoPath];
    }else{
        self.locationImageV.image = [NSBundle imageWithBundle:BundleName imageName:KBubbleLocationImageDefault];
    }

    self.locationLabel.text = message.address;
    

}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.locationImageV.frame = CGRectMake(0, 0, 90, 90);
    
    
    CGFloat locationHeight = [self.message.address boundingRectWithSize:CGSizeMake(90, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                NSFontAttributeName:KLocationFont
                                                                                                                                                                  }context:nil].size.height;
    
    
    if (locationHeight>90-10*2) {
        locationHeight = 90-10*2;
    }
    self.locationLabel.frame = CGRectMake(CGRectGetMaxX(self.locationImageV.frame)+KLeftMargin, KTopMargin, 90, locationHeight);
    
    
    
    
}

+ (CGSize)BubbleLocationWithMessage:(MessageModel *)message
{
    
    return CGSizeMake(90+90+KLeftMargin, 90);
    
}




@end
