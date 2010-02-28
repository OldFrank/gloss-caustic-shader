//
//  RRGlossCausticShader+SaveToDictionary.m
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

#import "RRGlossCausticShader+SaveToDictionary.h"
#import "RRCausticColorMatcher.h"

#if TARGET_OS_IPHONE
#import "UIColor+Components.h"
#else
#import <AppKit/AppKit.h>
#endif


static NSString *kColorRedKey                    = @"baseColorRed";
static NSString *kColorGreenKey                  = @"baseColorGreen";
static NSString *kColorBlueKey                   = @"baseColorBlue";
static NSString *kExponentialCoefficientKey      = @"exponentialCoefficient";
static NSString *kGlossReflectionPowerKey        = @"glossReflectionPower";
static NSString *kGlossStartingWhiteKey          = @"glossStartingWhite";
static NSString *kGlossEndingWhiteKey            = @"glossEndingWhite";
static NSString *kCausticHueKey                  = @"causticHue";
static NSString *kGraySaturationThresholdKey     = @"graySaturationThreshold";
static NSString *kCausticSaturationForGraysKey   = @"causticSaturationForGrays";
static NSString *kRedHueThresholdKey             = @"redHueThreshold";
static NSString *kBlueHueThresholdKey            = @"blueHueThreshold";
static NSString *kBlueCausticHueKey              = @"blueCausticHue";
static NSString *kCausticFractionDomainFactorKey = @"causticFractionDomainFactor";
static NSString *kCausticFractionRangeFactorKey  = @"causticFractionRangeFactor";



@implementation RRGlossCausticShader (SaveToDictionary)

- (NSDictionary *)dictionaryWithCurrentSettings {
#if TARGET_OS_IPHONE
    CGFloat red   = [[self noncausticColor] red];
    CGFloat green = [[self noncausticColor] green];
    CGFloat blue  = [[self noncausticColor] blue];
#else
    CGFloat red   = [[self noncausticColor] redComponent];
    CGFloat green = [[self noncausticColor] greenComponent];
    CGFloat blue  = [[self noncausticColor] blueComponent];
#endif
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat:red],   kColorRedKey,
                          [NSNumber numberWithFloat:green], kColorGreenKey,
                          [NSNumber numberWithFloat:blue],  kColorBlueKey,
                          [NSNumber numberWithFloat:[self exponentialCoefficient]],              kExponentialCoefficientKey,
                          [NSNumber numberWithFloat:[self glossReflectionPower]],                kGlossReflectionPowerKey,
                          [NSNumber numberWithFloat:[self glossStartingWhite]],                  kGlossStartingWhiteKey,
                          [NSNumber numberWithFloat:[self glossEndingWhite]],                    kGlossEndingWhiteKey,
                          [NSNumber numberWithFloat:[self.matcher causticHue]],                  kCausticHueKey,
                          [NSNumber numberWithFloat:[self.matcher graySaturationThreshold]],     kGraySaturationThresholdKey,
                          [NSNumber numberWithFloat:[self.matcher causticSaturationForGrays]],   kCausticSaturationForGraysKey,
                          [NSNumber numberWithFloat:[self.matcher redHueThreshold]],             kRedHueThresholdKey,
                          [NSNumber numberWithFloat:[self.matcher blueHueThreshold]],            kBlueHueThresholdKey,
                          [NSNumber numberWithFloat:[self.matcher blueCausticHue]],              kBlueCausticHueKey,
                          [NSNumber numberWithFloat:[self.matcher causticFractionDomainFactor]], kCausticFractionDomainFactorKey,
                          [NSNumber numberWithFloat:[self.matcher causticFractionRangeFactor]],  kCausticFractionRangeFactorKey,
                          nil];
    return dict;
}


- (void)updateWithSettingsFromDictionary:(NSDictionary *)dict {
#if TARGET_OS_IPHONE
    UIColor *baseColor = [UIColor colorWithRed:[[dict valueForKey:kColorRedKey]   floatValue]
                                         green:[[dict valueForKey:kColorGreenKey] floatValue]
                                          blue:[[dict valueForKey:kColorBlueKey]  floatValue]
                                         alpha:1.0f];
    [self setNoncausticColor:baseColor];
#else
    NSColor *baseColor = [NSColor colorWithDeviceRed:[[dict valueForKey:kColorRedKey] floatValue]
                                               green:[[dict valueForKey:kColorGreenKey] floatValue]
                                                blue:[[dict valueForKey:kColorBlueKey]  floatValue]
                                               alpha:1.0f];
    [self setNoncausticColor:baseColor];
#endif
    [self setExponentialCoefficient:             [[dict valueForKey:kExponentialCoefficientKey] floatValue]];
    [self setGlossReflectionPower:               [[dict valueForKey:kGlossReflectionPowerKey] floatValue]];
    [self setGlossStartingWhite:                 [[dict valueForKey:kGlossStartingWhiteKey] floatValue]];
    [self setGlossEndingWhite:                   [[dict valueForKey:kGlossEndingWhiteKey] floatValue]];
    [self.matcher setCausticHue:                 [[dict valueForKey:kCausticHueKey] floatValue]];
    [self.matcher setGraySaturationThreshold:    [[dict valueForKey:kGraySaturationThresholdKey] floatValue]];
    [self.matcher setCausticSaturationForGrays:  [[dict valueForKey:kCausticSaturationForGraysKey] floatValue]];
    [self.matcher setRedHueThreshold:            [[dict valueForKey:kRedHueThresholdKey] floatValue]];
    [self.matcher setBlueHueThreshold:           [[dict valueForKey:kBlueHueThresholdKey] floatValue]];
    [self.matcher setBlueCausticHue:             [[dict valueForKey:kBlueCausticHueKey] floatValue]];
    [self.matcher setCausticFractionDomainFactor:[[dict valueForKey:kCausticFractionDomainFactorKey] floatValue]];
    [self.matcher setCausticFractionRangeFactor: [[dict valueForKey:kCausticFractionRangeFactorKey] floatValue]];
    [self update];
}

@end
