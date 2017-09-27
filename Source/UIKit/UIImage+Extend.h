//
//  UIImage+Extend.h
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

#import <UIKit/UIKit.h>

@interface UIImage (Extend)
/**
 *  生成一张打好水印的图片
 */
+ (instancetype)generateWithWatermark:(UIImage *)watermark ForImage:(UIImage *)image;

/**
 *  返回一张可以随意拉伸不变形的图片
 */
+ (UIImage *)resizableImageNamed:(NSString *)name;

/**
 图片自动拉伸
 */
- (UIImage *)autoResize;

/// 截取指定view的快照
+ (instancetype)captureWithView:(UIView *)view;
@end
