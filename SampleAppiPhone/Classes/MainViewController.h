//
//  RRGlossCausticShaderTestViewController.h
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

#import <UIKit/UIKit.h>

#import "ShaderView.h"


@interface MainViewController : UIViewController {
    ShaderView *shaderView;
    UIView *controlsView;
    UIScrollView *scrollView;
    UIButton *colorButton;
    UILabel *settingsTab;
    
    UISlider *redSlider;
    UISlider *greenSlider;
    UISlider *blueSlider;
    UISlider *exponentialCoefficientSlider;
    UISlider *glossReflectionPowerSlider;
    UISlider *glossStartingWhiteSlider;
    UISlider *glossEndingWhiteSlider;
    UISlider *causticHueSlider;
    UISlider *graySaturationThresholdSlider;
    UISlider *causticSaturationForGraysSlider;
    UISlider *redHueThresholdSlider;
    UISlider *blueHueThresholdSlider;
    UISlider *blueCausticHueSlider;
    UISlider *causticFractionDomainFactorSlider;
    UISlider *causticFractionRangeFactorSlider;

    UILabel *redLabel;
    UILabel *greenLabel;
    UILabel *blueLabel;
    UILabel *exponentialCoefficientLabel;
    UILabel *glossReflectionPowerLabel;
    UILabel *glossStartingWhiteLabel;
    UILabel *glossEndingWhiteLabel;
    UILabel *causticHueLabel;
    UILabel *graySaturationThresholdLabel;
    UILabel *causticSaturationForGraysLabel;
    UILabel *redHueThresholdLabel;
    UILabel *blueHueThresholdLabel;
    UILabel *blueCausticHueLabel;
    UILabel *causticFractionDomainFactorLabel;
    UILabel *causticFractionRangeFactorLabel;
}

@property (nonatomic, retain) IBOutlet ShaderView *shaderView;
@property (nonatomic, retain) IBOutlet UIView *controlsView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *colorButton;
@property (nonatomic, retain) IBOutlet UILabel *settingsTab;

@property (nonatomic, retain) IBOutlet UISlider *redSlider;
@property (nonatomic, retain) IBOutlet UISlider *greenSlider;
@property (nonatomic, retain) IBOutlet UISlider *blueSlider;
@property (nonatomic, retain) IBOutlet UISlider *exponentialCoefficientSlider;
@property (nonatomic, retain) IBOutlet UISlider *glossReflectionPowerSlider;
@property (nonatomic, retain) IBOutlet UISlider *glossStartingWhiteSlider;
@property (nonatomic, retain) IBOutlet UISlider *glossEndingWhiteSlider;
@property (nonatomic, retain) IBOutlet UISlider *causticHueSlider;
@property (nonatomic, retain) IBOutlet UISlider *graySaturationThresholdSlider;
@property (nonatomic, retain) IBOutlet UISlider *causticSaturationForGraysSlider;
@property (nonatomic, retain) IBOutlet UISlider *redHueThresholdSlider;
@property (nonatomic, retain) IBOutlet UISlider *blueHueThresholdSlider;
@property (nonatomic, retain) IBOutlet UISlider *blueCausticHueSlider;
@property (nonatomic, retain) IBOutlet UISlider *causticFractionDomainFactorSlider;
@property (nonatomic, retain) IBOutlet UISlider *causticFractionRangeFactorSlider;

@property (nonatomic, retain) IBOutlet UILabel *redLabel;
@property (nonatomic, retain) IBOutlet UILabel *greenLabel;
@property (nonatomic, retain) IBOutlet UILabel *blueLabel;
@property (nonatomic, retain) IBOutlet UILabel *exponentialCoefficientLabel;
@property (nonatomic, retain) IBOutlet UILabel *glossReflectionPowerLabel;
@property (nonatomic, retain) IBOutlet UILabel *glossStartingWhiteLabel;
@property (nonatomic, retain) IBOutlet UILabel *glossEndingWhiteLabel;
@property (nonatomic, retain) IBOutlet UILabel *causticHueLabel;
@property (nonatomic, retain) IBOutlet UILabel *graySaturationThresholdLabel;
@property (nonatomic, retain) IBOutlet UILabel *causticSaturationForGraysLabel;
@property (nonatomic, retain) IBOutlet UILabel *redHueThresholdLabel;
@property (nonatomic, retain) IBOutlet UILabel *blueHueThresholdLabel;
@property (nonatomic, retain) IBOutlet UILabel *blueCausticHueLabel;
@property (nonatomic, retain) IBOutlet UILabel *causticFractionDomainFactorLabel;
@property (nonatomic, retain) IBOutlet UILabel *causticFractionRangeFactorLabel;

- (IBAction)printToConsoleButtonTapped:(id)sender;
- (IBAction)resetToDefaultsButtonTapped:(id)sender;

- (IBAction)colorSliderChanged:(id)sender;
- (IBAction)setExponentialCoefficient:(id)sender;
- (IBAction)setGlossReflectionPower:(id)sender;
- (IBAction)setGlossStartingWhite:(id)sender;
- (IBAction)setGlossEndingWhite:(id)sender;
- (IBAction)setCausticHue:(id)sender;
- (IBAction)setGraySaturationThreshold:(id)sender;
- (IBAction)setCausticSaturationForGrays:(id)sender;
- (IBAction)setRedHueThreshold:(id)sender;
- (IBAction)setBlueHueThreshold:(id)sender;
- (IBAction)setBlueCausticHue:(id)sender;
- (IBAction)setCausticFractionDomainFactor:(id)sender;
- (IBAction)setCausticFractionRangeFactor:(id)sender;

@end

