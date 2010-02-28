//
//  RRGlossCausticShaderTestViewController.m
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

#import "MainViewController.h"

#import "RRGlossCausticShader.h"
#import "RRCausticColorMatcher.h"
#import "RRGlossCausticShader+SaveToDictionary.h"
#import "UIColor+Components.h"



@interface MainViewController ()

- (void)releaseOutlets;
- (void)resetShaderToDefaultValues;
- (void)loadSettingsFromUserDefaults;
- (void)saveSettingsToUserDefaults;
- (void)syncUIWithShaderSettings;

@end




@implementation MainViewController

@synthesize shaderView;
@synthesize controlsView;
@synthesize scrollView;
@synthesize colorButton;
@synthesize settingsTab;
@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize exponentialCoefficientSlider;
@synthesize glossReflectionPowerSlider;
@synthesize glossStartingWhiteSlider;
@synthesize glossEndingWhiteSlider;
@synthesize causticHueSlider;
@synthesize graySaturationThresholdSlider;
@synthesize causticSaturationForGraysSlider;
@synthesize redHueThresholdSlider;
@synthesize blueHueThresholdSlider;
@synthesize blueCausticHueSlider;
@synthesize causticFractionDomainFactorSlider;
@synthesize causticFractionRangeFactorSlider;
@synthesize redLabel;
@synthesize greenLabel;
@synthesize blueLabel;
@synthesize exponentialCoefficientLabel;
@synthesize glossReflectionPowerLabel;
@synthesize glossStartingWhiteLabel;
@synthesize glossEndingWhiteLabel;
@synthesize causticHueLabel;
@synthesize graySaturationThresholdLabel;
@synthesize causticSaturationForGraysLabel;
@synthesize redHueThresholdLabel;
@synthesize blueHueThresholdLabel;
@synthesize blueCausticHueLabel;
@synthesize causticFractionDomainFactorLabel;
@synthesize causticFractionRangeFactorLabel;



- (void)viewDidLoad {
    [super viewDidLoad];

    // Register the default shader settings in NSUserDefaults, then try to load the current settings from user defaults.
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:self.shaderView.defaultShaderSettings 
                                                                                        forKey:@"shaderSettings"]];
    [self loadSettingsFromUserDefaults];
    
    self.scrollView.contentSize = self.controlsView.bounds.size;
    [self.scrollView addSubview:self.controlsView];
    
    self.colorButton.layer.borderColor = [[UIColor blackColor] CGColor];
    self.colorButton.layer.borderWidth = 1.0f;
    
    self.settingsTab.layer.borderColor = [[UIColor blackColor] CGColor];
    self.settingsTab.layer.borderWidth = 1.0f;
    self.settingsTab.layer.cornerRadius = 5.0f;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    [self releaseOutlets];
}


- (void)releaseOutlets {
    self.shaderView = nil;
    self.controlsView = nil;
    self.scrollView = nil;
    self.colorButton = nil;
    self.settingsTab = nil;
    self.redSlider = nil;
    self.greenSlider = nil;
    self.blueSlider = nil;
    self.exponentialCoefficientSlider = nil;
    self.glossReflectionPowerSlider = nil;
    self.glossStartingWhiteSlider = nil;
    self.glossEndingWhiteSlider = nil;
    self.causticHueSlider = nil;
    self.graySaturationThresholdSlider = nil;
    self.causticSaturationForGraysSlider = nil;
    self.redHueThresholdSlider = nil;
    self.blueHueThresholdSlider = nil;
    self.blueCausticHueSlider = nil;
    self.causticFractionDomainFactorSlider = nil;
    self.causticFractionRangeFactorSlider = nil;    
    self.redLabel = nil;
    self.greenLabel = nil;
    self.blueLabel = nil;
    self.exponentialCoefficientLabel = nil;
    self.glossReflectionPowerLabel = nil;
    self.glossStartingWhiteLabel = nil;
    self.glossEndingWhiteLabel = nil;
    self.causticHueLabel = nil;
    self.graySaturationThresholdLabel = nil;
    self.causticSaturationForGraysLabel = nil;
    self.redHueThresholdLabel = nil;
    self.blueHueThresholdLabel = nil;
    self.blueCausticHueLabel = nil;
    self.causticFractionDomainFactorLabel = nil;
    self.causticFractionRangeFactorLabel = nil;
}


- (void)dealloc {
    [self releaseOutlets];
    [super dealloc];
}



#pragma mark Print settings to console

- (IBAction)printToConsoleButtonTapped:(id)sender {
    RRGlossCausticShader *shader = self.shaderView.shader;

    NSMutableString *outputString = [NSMutableString stringWithString:@"\n"];
    [outputString appendString:[NSString stringWithFormat:@"UIColor *baseColor = [UIColor colorWithRed:%ff green:%ff blue:%ff alpha:1.0f];\n",
                                [[shader noncausticColor] red], [[shader noncausticColor] green], [[shader noncausticColor] blue]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader setNoncausticColor:baseColor];              \n"]];
    [outputString appendString:[NSString stringWithFormat:@"[shader setExponentialCoefficient:%ff];             \n", [shader exponentialCoefficient]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader setGlossReflectionPower:%ff];               \n", [shader glossReflectionPower]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader setGlossStartingWhite:%ff];                 \n", [shader glossStartingWhite]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader setGlossEndingWhite:%ff];                   \n", [shader glossEndingWhite]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setCausticHue:%ff];                 \n", [shader.matcher causticHue]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setGraySaturationThreshold:%ff];    \n", [shader.matcher graySaturationThreshold]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setCausticSaturationForGrays:%ff];  \n", [shader.matcher causticSaturationForGrays]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setRedHueThreshold:%ff];            \n", [shader.matcher redHueThreshold]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setBlueHueThreshold:%ff];           \n", [shader.matcher blueHueThreshold]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setBlueCausticHue:%ff];             \n", [shader.matcher blueCausticHue]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setCausticFractionDomainFactor:%ff];\n", [shader.matcher causticFractionDomainFactor]]];
    [outputString appendString:[NSString stringWithFormat:@"[shader.matcher setCausticFractionRangeFactor:%ff]; \n", [shader.matcher causticFractionRangeFactor]]];
    
    NSLog(@"%@", outputString);
}



#pragma mark Reset to default values

- (IBAction)resetToDefaultsButtonTapped:(id)sender{
    [self resetShaderToDefaultValues];
}

- (void)resetShaderToDefaultValues {
    [self.shaderView.shader updateWithSettingsFromDictionary:self.shaderView.defaultShaderSettings];
    [self.shaderView update];
    [self syncUIWithShaderSettings];
    [self saveSettingsToUserDefaults];
}



#pragma mark User defaults

- (void)loadSettingsFromUserDefaults {
    NSDictionary *restoredSettings = [[NSUserDefaults standardUserDefaults] objectForKey:@"shaderSettings"];
    [self.shaderView.shader updateWithSettingsFromDictionary:restoredSettings];
    [self.shaderView update];
    [self syncUIWithShaderSettings];
}


- (void)saveSettingsToUserDefaults {
    NSDictionary *settings = [self.shaderView.shader dictionaryWithCurrentSettings];
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"shaderSettings"];
}



#pragma mark Controls updates

- (void)syncUIWithShaderSettings {
    self.colorButton.backgroundColor = [self.shaderView.shader noncausticColor];
    
    self.redSlider.value = [[self.shaderView.shader noncausticColor] red];
    self.redLabel.text = [NSString stringWithFormat:@"%.3f", [[self.shaderView.shader noncausticColor] red]];
    self.greenSlider.value = [[self.shaderView.shader noncausticColor] green];
    self.greenLabel.text = [NSString stringWithFormat:@"%.3f", [[self.shaderView.shader noncausticColor] green]];
    self.blueSlider.value = [[self.shaderView.shader noncausticColor] blue];
    self.blueLabel.text = [NSString stringWithFormat:@"%.3f", [[self.shaderView.shader noncausticColor] blue]];
    
    self.exponentialCoefficientSlider.value = [self.shaderView.shader exponentialCoefficient];
    self.exponentialCoefficientLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader exponentialCoefficient]];
    
    self.glossReflectionPowerSlider.value = [self.shaderView.shader glossReflectionPower];
    self.glossReflectionPowerLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader glossReflectionPower]];
    
    self.glossStartingWhiteSlider.value = [self.shaderView.shader glossStartingWhite];
    self.glossStartingWhiteLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader glossStartingWhite]];
    
    self.glossEndingWhiteSlider.value = [self.shaderView.shader glossEndingWhite];
    self.glossEndingWhiteLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader glossEndingWhite]];
    
    self.causticHueSlider.value = [self.shaderView.shader.matcher causticHue];
    self.causticHueLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher causticHue]];
    
    self.graySaturationThresholdSlider.value = [self.shaderView.shader.matcher graySaturationThreshold];
    self.graySaturationThresholdLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher graySaturationThreshold]];
    
    self.causticSaturationForGraysSlider.value = [self.shaderView.shader.matcher causticSaturationForGrays];
    self.causticSaturationForGraysLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher causticSaturationForGrays]];
    
    self.redHueThresholdSlider.value = [self.shaderView.shader.matcher redHueThreshold];
    self.redHueThresholdLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher redHueThreshold]];
    
    self.blueHueThresholdSlider.value = [self.shaderView.shader.matcher blueHueThreshold];
    self.blueHueThresholdLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher blueHueThreshold]];
    
    self.blueCausticHueSlider.value = [self.shaderView.shader.matcher blueCausticHue];
    self.blueCausticHueLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher blueCausticHue]];
    
    self.causticFractionDomainFactorSlider.value = [self.shaderView.shader.matcher causticFractionDomainFactor];
    self.causticFractionDomainFactorLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher causticFractionDomainFactor]];
    
    self.causticFractionRangeFactorSlider.value = [self.shaderView.shader.matcher causticFractionRangeFactor];
    self.causticFractionRangeFactorLabel.text = [NSString stringWithFormat:@"%.3f", [self.shaderView.shader.matcher causticFractionRangeFactor]];
}


- (IBAction)colorSliderChanged:(id)sender {
    UIColor *newColor = [UIColor colorWithRed:self.redSlider.value 
                                        green:self.greenSlider.value
                                         blue:self.blueSlider.value
                                        alpha:1.0f];
    
    self.redLabel.text   = [NSString stringWithFormat:@"%.3f", [newColor red]];
    self.greenLabel.text = [NSString stringWithFormat:@"%.3f", [newColor green]];
    self.blueLabel.text  = [NSString stringWithFormat:@"%.3f", [newColor blue]];

    self.colorButton.backgroundColor = newColor;
    
    [self.shaderView.shader setNoncausticColor:newColor];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}


- (IBAction)setExponentialCoefficient:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader setExponentialCoefficient:slider.value];
    self.exponentialCoefficientLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setGlossReflectionPower:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader setGlossReflectionPower:slider.value];
    self.glossReflectionPowerLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setGlossStartingWhite:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader setGlossStartingWhite:slider.value];
    self.glossStartingWhiteLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setGlossEndingWhite:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader setGlossEndingWhite:slider.value];
    self.glossEndingWhiteLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setCausticHue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setCausticHue:slider.value];
    self.causticHueLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setGraySaturationThreshold:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setGraySaturationThreshold:slider.value];
    self.graySaturationThresholdLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setCausticSaturationForGrays:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setCausticSaturationForGrays:slider.value];
    self.causticSaturationForGraysLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setRedHueThreshold:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setRedHueThreshold:slider.value];
    self.redHueThresholdLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setBlueHueThreshold:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setBlueHueThreshold:slider.value];
    self.blueHueThresholdLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setBlueCausticHue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setBlueCausticHue:slider.value];
    self.blueCausticHueLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setCausticFractionDomainFactor:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setCausticFractionDomainFactor:slider.value];
    self.causticFractionDomainFactorLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

- (IBAction)setCausticFractionRangeFactor:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.shaderView.shader.matcher setCausticFractionRangeFactor:slider.value];
    self.causticFractionRangeFactorLabel.text = [NSString stringWithFormat:@"%.3f", slider.value];
    [self.shaderView update];
    [self saveSettingsToUserDefaults];
}

@end