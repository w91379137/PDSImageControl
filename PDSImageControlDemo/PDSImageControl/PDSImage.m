//
//  PDSImage.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImage.h"

@implementation PDSImage

#pragma mark - 產生純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color
{
    if (![color isKindOfClass:[UIColor class]]) {
        color = [UIColor blackColor];
    }
    
    //開始繪圖
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    {
        [color set];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 產生字圖
+ (UIImage *)makeTextImage:(NSString *)string
            FontDictionary:(NSDictionary *)fontDictionary
{
    CGSize size =
    [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:fontDictionary
                         context:nil].size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    [string drawAtPoint:CGPointZero withAttributes:fontDictionary];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 產生漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations
{
    //開始繪圖
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    {
        //取出顏色的資訊
        NSMutableArray *valuesArray = [self valuesFromColors:colors];
        
        //漸層中所包含的關鍵顏色 RGBA
        CGFloat colorComponents[[valuesArray count]];
        for (int i = 0; i < [valuesArray count]; i++) {
            colorComponents[i] = [[valuesArray objectAtIndex:i] floatValue];
        }
        
        //關鍵顏色所出現的位置
        CGFloat locationsComponents[[locations count]];
        for (int i = 0; i < [locations count]; i++) {
            locationsComponents[i] = [[locations objectAtIndex:i] floatValue];
        }
        
        //關鍵顏色的個數
        size_t count = colors.count;
        
        //製作漸層顏色模型
        CGGradientRef gradient =
        CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(),
                                            colorComponents,
                                            locationsComponents,
                                            count);
        
        //繪製漸層線條
        CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradient, startPoint, endPoint, 0);
        CGGradientRelease(gradient);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 貼圖
+ (UIImage *)addImage:(UIImage *)image
      BackgroundImage:(UIImage *)backgroundImage
               Origin:(CGPoint)origin
{
    //畫布設定
    UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, backgroundImage.scale);
    
    {
        //畫上背景
        [backgroundImage drawAtPoint:CGPointMake(0, 0)];
        
        //畫上增加圖
        [image drawAtPoint:origin];
    }
    
    //將影像傳回
    UIImage *imagex = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imagex;
}

#pragma mark - 圓角
+ (UIImage *)makeRoundedImage:(UIImage *)image
                      Corners:(UIRectCorner)corners
                       Radius:(NSInteger)radius
{
    //http://stackoverflow.com/questions/4847163/round-two-corners-in-uiview
    
    //下面兩個角導角
    //corners >> UIRectCornerBottomLeft | UIRectCornerBottomRight
    
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height)
                          byRoundingCorners:corners
                                cornerRadii:CGSizeMake(radius, radius)];
    return [self clipImage:image
                      Path:maskPath];
}

#pragma mark - 切圖
+ (UIImage *)clipImage:(UIImage *)image
                  Path:(UIBezierPath *)path
{
    //http://stackoverflow.com/questions/16142743/clip-uiimage-with-uibezierpath-asynchronously
    
    UIGraphicsBeginImageContextWithOptions(image.size, 0, image.scale);
    
    //path
    //UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    [path addClip];
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

#pragma mark - 資料處理
+ (NSMutableArray *)valuesFromColors:(NSArray *)colorArray
{
    NSMutableArray *valuesArray = [NSMutableArray array];
    for (int k = 0; k < [colorArray count]; k++) {
        
        UIColor *aColor = colorArray[k];
        if ([aColor isKindOfClass:[UIColor class]]) {
            [valuesArray addObjectsFromArray:[self valuesFromColor:aColor]];
        }
        else {
            [valuesArray addObjectsFromArray:[self valuesFromColor:[UIColor blackColor]]];
        }
    }
    return valuesArray;
}

+ (NSArray *)valuesFromColor:(UIColor *)color
{
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 1;
    
    if (CGColorGetNumberOfComponents(color.CGColor) == 2) {
        CGFloat hue;
        CGFloat saturation;
        CGFloat brightness;
        
        [color getHue:&hue
           saturation:&saturation
           brightness:&brightness
                alpha:&alpha];
        
        red = brightness;
        green = brightness;
        blue = brightness;
    }
    else if (CGColorGetNumberOfComponents(color.CGColor) == 4) {
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    else {
        NSLog(@"★★The color can't be anaysis to rgb★★");
    }
    
    return @[@(red),@(green),@(blue),@(alpha)];
}

@end
