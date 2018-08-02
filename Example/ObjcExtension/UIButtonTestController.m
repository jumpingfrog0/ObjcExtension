//
//  UIButtonTestController.m
//  ObjcExtension
//
//  Created by jumpingfrog0 on 11/08/2017.
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

#import "UIButtonTestController.h"
#import "UIButton+JFExtension.h"

@interface UIButtonTestController ()
@property (weak, nonatomic) IBOutlet UIButton *bananaButton;
@property (weak, nonatomic) IBOutlet UIButton *bananaButton2;
@property (weak, nonatomic) IBOutlet UIButton *bananaButton3;
@end

@implementation UIButtonTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bananaButton jf_alignVerticalWithSpacing:4.0 bottomPadding: 4.0];
    [self.bananaButton2 jf_alignVerticalWithSpacing:4.0];
    [self.bananaButton3 jf_alignHorizontalWithSpacing:20.0];
}

@end
