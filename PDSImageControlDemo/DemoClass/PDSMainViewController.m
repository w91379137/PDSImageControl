//
//  PDSMainViewController.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSMainViewController.h"
#import "PDSImage.h"

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
    UIColor *demoColor3 = [self randomColor];
    UIColor *demoColor4 = [self randomColor];
    
    UIImage *pureImage;
    UIImage *gradientImage;
    
    {
        pureImage =
        [PDSImage makePureColorImage:imageSize
                               Color:demoColor1];
        [self factoryImageView].image = pureImage;
    }
    {
        gradientImage =
        [PDSImage makeGradientImage:imageSize
                         StartPoint:CGPointMake(0, 0)
                           EndPoint:CGPointMake(imageSize.width, imageSize.height)
                             Colors:@[demoColor1,demoColor2,demoColor3,demoColor4]
                           Location:@[@0,@0.4,@0.6,@1]];
        [self factoryImageView].image = gradientImage;
    }
    {
        UIImage *image1 =
        [PDSImage makePureColorImage:CGSizeMake(30, 30)
                               Color:demoColor2];
        
        {
            [self factoryImageView].image =
            [PDSImage addImage:image1
               BackgroundImage:pureImage
                        Origin:CGPointZero];
            
        }
        {
            CGPoint point =
            [PDSImage originOfCenterAlignImage:image1
                               BackgroundImage:pureImage];
            
            [self factoryImageView].image =
            [PDSImage addImage:image1
               BackgroundImage:pureImage
                        Origin:point];
        }
    }
    {
        float radius = 25.0;
        float period = 10.0;
        
        UIImage *image =
        [PDSImage makeRoundedImage:gradientImage
                           Corners:UIRectCornerAllCorners
                            Radius:radius];
        
        {
            [self factoryImageView].image = image;
        }
        {
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                  resizingMode:UIImageResizingModeTile];
        }
        {
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                  resizingMode:UIImageResizingModeStretch];
        }
    }
    {
        UIImage *image = pureImage;
        for (NSInteger x = 0; x < 5; x++) {
            for (NSInteger y = 0; y < 5; y++) {
                image =
                [PDSImage addImage:[PDSImage makePureColorImage:CGSizeMake(10, 10)
                                                          Color:[self randomColor]]
                   BackgroundImage:image
                            Origin:CGPointMake(x * 10, y * 10)];
            }
        }
        [self factoryImageView].image = image;
        
        float period = 10.0;
        {
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                  resizingMode:UIImageResizingModeTile];
        }
        {
            [self factoryImageViewContentMode:UIViewContentModeScaleAspectFill].image =
            [image resizableImageWithCapInsets:UIEdgeInsetsMake(period, period, period, period)
                                  resizingMode:UIImageResizingModeStretch];
        }
    }
    {
        //http://blog.csdn.net/lwjok2007/article/details/47184911
        UIImage *imageA =
        [PDSImage makeTextImage:@"A"
                 FontDictionary:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20 * [UIScreen mainScreen].scale],
                                  NSStrokeWidthAttributeName:@3,
                                  NSStrokeColorAttributeName:[self randomColor]}];
        [self factoryImageView].image = imageA;
        
        UIImage *imageB =
        [PDSImage makeTextImage:@"B"
                 FontDictionary:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10 * [UIScreen mainScreen].scale],
                                  NSStrokeWidthAttributeName:@3,
                                  NSStrokeColorAttributeName:[self randomColor]}];
        [self factoryImageView].image = imageB;
        
        {
            UIImage *image = gradientImage;
            image = [PDSImage addImage:imageA
                       BackgroundImage:image
                                Origin:CGPointZero];
            
            CGPoint point =
            [PDSImage originOfCenterAlignImage:imageB
                               BackgroundImage:image];
            
            image = [PDSImage addImage:imageB
                       BackgroundImage:image
                                Origin:point];
            
            [self factoryImageView].image = image;
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

- (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                           green:arc4random_uniform(255) / 255.0f
                            blue:arc4random_uniform(255) / 255.0f
                           alpha:0.9];
}

- (CGPoint)centerOfImageView:(NSInteger)number
{
    float x = (number % 3) + 0.5;
    float y = floorf(number / 3.0) + 0.5;
    return CGPointMake(x * (imageViewSize.width + 1) + 20,
                       y * (imageViewSize.height + 1) + 20);
}

@end
