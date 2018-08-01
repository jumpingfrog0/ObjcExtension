//
//  UIImage+Extend.m
//  ObjcExtension
//
//  Created by jumpingfrog0 on 27/07/2017.
//
//
//  Copyright (c) 2017 Jumpingfrog0 LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

// TODO: 适配UIImageView的大小和contentMode
+ (instancetype)generateWithWatermark:(UIImage *)watermark ForImage:(UIImage *)image;
{
    // 创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0.0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];

    // 画水印
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = watermark.size.width * scale;
    CGFloat waterH = watermark.size.height * scale;
    CGFloat waterX = image.size.width - waterW - margin;
    CGFloat waterY = image.size.height - waterH - margin;
    [watermark drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)resizableImageNamed:(NSString *)name
{
    UIImage *origin = [UIImage imageNamed:name];
    
#ifdef DEBUG
    NSAssert(origin != nil, @"The resizable image should not be nil.");
#else
    NSLog(@"The resizable image should not be nil.");
#endif
    
    return [origin autoResize];
}

- (UIImage *)autoResize {
    CGFloat w = self.size.width * 0.5;
    CGFloat h = self.size.height * 0.5;
    UIEdgeInsets capInsets = UIEdgeInsetsMake(h, w, h, w);
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 5.0) {
        // `resizableImageWithCapInsets:` 可以重复一个区域进行平铺拉伸，而不是1x1像素
        return [self resizableImageWithCapInsets:capInsets];
    } else {
        // `stretchableImageWithLeftCapWidth:topCapHeight` 只能以1x1的像素进行拉伸
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

+ (instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}


@end