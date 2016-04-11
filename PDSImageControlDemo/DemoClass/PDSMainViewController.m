//
//  PDSMainViewController.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSMainViewController.h"

@interface PDSMainViewController ()

@end

@implementation PDSMainViewController

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        imageSize = CGSizeMake(50, 50);
        imageViewSize = CGSizeMake(70, 70);
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIColor *demoColor1 = [UIColor colorWithRed:.1 green:arc4random_uniform(255) / 255.0f blue:arc4random_uniform(255) / 255.0f alpha:.8];
    UIColor *demoColor2 = [UIColor colorWithRed:.9 green:arc4random_uniform(255) / 255.0f blue:arc4random_uniform(255) / 255.0f alpha:.8];
    UIColor *demoColor3 = [UIColor randomColor];
    UIColor *demoColor4 = [UIColor randomColor];
    
    UIImage *pureImage;
    UIImage *gradientImage;
    
    {
        pureImage =
        [UIImage makePureColorImage:imageSize
                              Color:demoColor1];
        
        #pragma 純色圖片
        [self factoryImageView].image = pureImage;
    }
    
    {
        gradientImage =
        [UIImage makeGradientImage:imageSize
                        StartPoint:CGPointMake(0, imageSize.height)
                          EndPoint:CGPointMake(imageSize.width, 0)
                            Colors:@[demoColor1,demoColor2,demoColor3,demoColor4]
                          Location:@[@0,@0.4,@0.6,@1]];
        
        #pragma 漸層圖片
        [self factoryImageView].image = gradientImage;
    }
    
    {
        UIImage *image1 =
        [UIImage makePureColorImage:CGSizeMake(30, 30)
                              Color:demoColor2];
        
        {
            #pragma 貼圖片
            [self factoryImageView].image =
            [UIImage addImage:image1
              BackgroundImage:pureImage
                       Origin:CGPointZero];
            
        }
        {
            PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:pureImage];
            [imageControl addImageAtCenter:image1];
            
            #pragma 貼圖片
            [self factoryImageView].image = imageControl.image;
        }
    }
    {
        float radius = 25.0;
        float period = 10.0;
        
        PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:gradientImage];
        [imageControl addCorners:UIRectCornerAllCorners Radius:radius];
        
        {
            #pragma 圓角
            [self factoryImageView].image = imageControl.image;
        }
        {
            #pragma 延展圓角
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [imageControl.image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period,    period, period)
                                  resizingMode:UIImageResizingModeTile];
        }
        {
            #pragma 延展圓角
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [imageControl.image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                  resizingMode:UIImageResizingModeStretch];
        }
    }
    {
        PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:pureImage];
        for (NSInteger x = 0; x < 5; x++) {
            for (NSInteger y = 0; y < 5; y++) {
                [imageControl addImage:[UIImage makePureColorImage:CGSizeMake(10, 10)
                                                        Color:[UIColor randomColor]]
                                Origin:CGPointMake(x * 10, y * 10)];
            }
        }
        
        #pragma 磁磚
        [self factoryImageView].image = imageControl.image;
        
        float period = 10.0;
        {
            #pragma 延展磁磚
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [imageControl.image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                               resizingMode:UIImageResizingModeTile];
        }
        {
            #pragma 延展磁磚
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [imageControl.image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                               resizingMode:UIImageResizingModeStretch];
        }
    }
    {
        //http://blog.csdn.net/lwjok2007/article/details/47184911
        UIImage *imageA =
        [UIImage makeTextImage:@"A"
                 FontDictionary:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20 * [UIScreen mainScreen].scale],
                                  NSStrokeWidthAttributeName:@3,
                                  NSStrokeColorAttributeName:[UIColor randomColor]}];
        
        #pragma 貼字
        [self factoryImageView].image = imageA;
        
        {
            PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:imageA];
            
            #pragma 更改顏色
            [imageControl changeColor:[UIColor randomColor]];
            [self factoryImageView].image = imageControl.image;
            
            #pragma 裁切
            [imageControl subImageRect:CGRectMake(5, 10, 15, 25)];
            [self factoryImageView].image = imageControl.image;
            
            #pragma 旋轉
            [imageControl rotateOrientation:UIImageOrientationLeft];
            [self factoryImageView].image = imageControl.image;
        }
        
        UIImage *imageB =
        [UIImage makeTextImage:@"B"
                 FontDictionary:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10 * [UIScreen mainScreen].scale],
                                  NSStrokeWidthAttributeName:@3,
                                  NSStrokeColorAttributeName:[UIColor randomColor]}];
        
        #pragma 貼字
        [self factoryImageView].image = imageB;
        
        {
            PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:gradientImage];
            [imageControl addImage:imageA Origin:CGPointZero];
            [imageControl addImageAtCenter:imageB];
            
            #pragma 貼字
            [self factoryImageView].image = imageControl.image;
        }
    }
    {
        PDSImageControl *imageControl = [[PDSImageControl alloc] initWithImage:pureImage];
        [imageControl addTexture:[UIImage imageNamed:@"shadow1.png"]];
        
        #pragma 合成
        [self factoryImageView].image = imageControl.image;
        
        {
            [imageControl reSize:CGSizeMake(20, 20)];
            
            #pragma 改大小
            [self factoryImageView].image = imageControl.image;
        }
    }
    {
        PDSImageControl *imageControl =
        [[PDSImageControl alloc] initWithImage:[UIImage makeImageWithView:self.view]];
        [imageControl reSizeMaxLength:imageSize.height];
        
        #pragma 截圖
        [self factoryImageView].image = imageControl.image;
        
        {
            CIImage *test = [CIImage imageWithCGImage:imageControl.image.CGImage];
            
            CIContext *context = [CIContext contextWithOptions:nil];
            CIFilter *filter =
            [CIFilter filterWithName:@"CIColorMonochrome"];
            //[CIFilter filterWithName:@"CIHueAdjust"];
            
            [filter setDefaults];
            [filter setValue:test forKey:kCIInputImageKey];
            [filter setValue:
             [CIColor colorWithRed:arc4random_uniform(255)/255.0f
                             green:arc4random_uniform(255)/255.0f
                              blue:arc4random_uniform(255)/255.0f
                             alpha:1.0f]
                               forKey: @"inputColor"];
            //[filter setValue:[NSNumber numberWithFloat: 2.0f] forKey:@"inputAngle"];
            //[filter setValue:[UIColor randomColor] forKey:kCIAttributeTypeColor];
            
            test = [filter valueForKey:kCIOutputImageKey];
            
            CGRect extent = [test extent];
            CGImageRef cgImage = [context createCGImage:test fromRect:extent];
            
            UIImage *filteredImage =
            [[UIImage alloc] initWithCGImage:cgImage
                                       scale:imageControl.image.scale
                                 orientation:imageControl.image.imageOrientation];
            
            #pragma 濾鏡
            [self factoryImageView].image = filteredImage;
        }
        
    }
}

#pragma mark - Factory Method
- (UIImageView *)factoryImageView
{
    return [self factoryImageViewContentMode:UIViewContentModeCenter];
}

- (UIImageView *)factoryImageViewContentMode:(UIViewContentMode)mode
{
    UIImageView *imageView =
    [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSize.width, imageViewSize.width)];
    
    UIColor *imageViewBgColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.3];
    imageView.backgroundColor = imageViewBgColor;
    
    imageView.contentMode = mode;
    [self.view addSubview:imageView];
    
    imageView.center = [self centerOfImageView:k];
    k++;
    
    return imageView;
}

- (CGPoint)centerOfImageView:(NSInteger)number
{
    static NSInteger lineNumber = 4;
    float x = (number % lineNumber) + 0.5;
    float y = floorf(number / (float)lineNumber) + 0.5;
    return CGPointMake(x * (imageViewSize.width + 1) + 20,
                       y * (imageViewSize.height + 1) + 20);
}

@end
