//
//  PDSImage.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImage.h"

@implementation PDSImage

#pragma mark - 做純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color
{
    UIImage *aPureColorImage = nil;
    
    if (color != nil) {
        CGSize imageSize = size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        [color set];
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
        aPureColorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return aPureColorImage;
}

#pragma mark - 做漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations
{
    //使用RGB顏色模型
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
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
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colorComponents, locationsComponents, count);
    CGColorSpaceRelease(rgb);
    
    //開始繪圖
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    //指定畫布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //繪製漸層線條
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    //將畫布指定給Image
    UIImage *aGradientImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    
    //結束繪圖
    UIGraphicsEndImageContext();
    return aGradientImage;
}

#pragma mark - 資料處理部
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
