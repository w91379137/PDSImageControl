//
//  PDSImage.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImageControl.h"

@implementation PDSImageControl

#pragma mark - Init
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

#pragma mark - 貼圖
- (void)addImage:(UIImage *)image
               Origin:(CGPoint)origin
{
    if (self.image) {
        self.image =
        [UIImage addImage:image
          BackgroundImage:self.image
                   Origin:origin];
    }
}

- (void)addImageAtCenter:(UIImage *)image
{
    if (self.image) {
        
        CGPoint point =
        [PDSImageControl originOfCenterAlignImage:image
                                  BackgroundImage:self.image];
        
        self.image =
        [UIImage addImage:image
          BackgroundImage:self.image
                   Origin:point];
    }
}

#pragma mark - 中心轉換
+ (CGPoint)originOfCenterAlignImage:(UIImage *)image
                    BackgroundImage:(UIImage *)backgroundImage
{
    CGPoint point =
    CGPointMake((backgroundImage.size.width - image.size.width) / 2,
                (backgroundImage.size.height - image.size.height) / 2);
    return point;
}

@end
