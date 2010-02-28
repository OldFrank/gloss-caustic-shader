//
//  ShaderView.m
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

#import <QuartzCore/QuartzCore.h>
#import "ShaderView.h"
#import "RRGlossCausticShader+SaveToDictionary.h"


@implementation ShaderView

@synthesize shader;
@synthesize defaultShaderSettings;


- (void)awakeFromNib {
    shader = [[RRGlossCausticShader alloc] init];
    self.defaultShaderSettings = [shader dictionaryWithCurrentSettings];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1.0f;
}


- (void)dealloc {
    self.shader = nil;
    self.defaultShaderSettings = nil;
    [super dealloc];
}


- (void)update {
    [self.shader update];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
//    NSLog(@"drawRect");
    [self.shader drawShadingFromPoint:self.bounds.origin 
                              toPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height)
                            inContext:UIGraphicsGetCurrentContext()];
}



@end
