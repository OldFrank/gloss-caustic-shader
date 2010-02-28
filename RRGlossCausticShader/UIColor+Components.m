//
//  UIColor+Components.m
//
// Copyright © 2010 Ole Begemann
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//------------------------------------------------------------------------------

#import "UIColor+Components.h"


@implementation UIColor (Components)

@dynamic red, green, blue, alpha;

- (CGColorSpaceModel)colorSpaceModel {  
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));  
}  

- (BOOL)canProvideRGBComponents {  
    return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||   
            ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));  
}  

- (CGFloat)red {  
    NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    return c[0];  
}  

- (CGFloat)green {  
    NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];  
    return c[1];  
}  

- (CGFloat)blue {  
    NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];  
    return c[2];  
}  

- (CGFloat)alpha {  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    return c[CGColorGetNumberOfComponents(self.CGColor)-1];  
}  

@end
