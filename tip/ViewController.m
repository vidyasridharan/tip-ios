//
//  ViewController.m
//  tip
//
//  Created by Vidya Sridharan on 9/3/14.
//  Copyright (c) 2014 Vidya Sridharan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UILabel *sharedFour;
@property (weak, nonatomic) IBOutlet UILabel *sharedTwo;

@property (weak, nonatomic) IBOutlet UIView *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (void)updateValues;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
    // Do any additional setup after loading the view, typically from a nib.
    [self.amount becomeFirstResponder];
    self.slider.alpha = 0;
    self.tipControl.alpha =0;
}
- (IBAction)onTap:(id)sender {
    //NSLog(@"onTap");
    [self.view endEditing:YES];
   // [self updateValues];
}
- (IBAction)onTipPercentageChange:(id)sender {
    [self updateValues];
}
- (IBAction)onAmountChanged:(UITextField *)sender {
    [self updateValues];
}

- (void) updateValues{
    float billAmount = [self.amount.text floatValue];
    float tipAmount = 0;
    if(billAmount){
        [UIView animateWithDuration:0.4 animations:^{
            // This causes first view to fade in and second view to fade out
            self.slider.alpha = 1;
            self.tipControl.alpha =1;
            
        }];}
    else{
        self.slider.alpha = 0;
        self.tipControl.alpha =0;
    }
    NSArray *tipPercentages = @[@(0.10), @(0.20), @(0.30)];
    tipAmount =  billAmount * [tipPercentages[self.tipControl.selectedSegmentIndex] floatValue];
    billAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", billAmount];
    self.sharedTwo.text = [NSString stringWithFormat:@"$%0.2f", billAmount/2];
    self.sharedFour.text = [NSString stringWithFormat:@"$%0.2f", billAmount/4];
   

}
-(void) viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"The defaul tipControl is %li", [defaults integerForKey:@"defaultTip"] );
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"defaultTip"];
    
}

@end
