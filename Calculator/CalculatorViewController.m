//
//  CalculatorViewController.m
//  Calculator
//
//  Created by viet on 1/7/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL isFloat;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if ([digit isEqualToString:@"."]) {
        
        if (self.userIsInTheMiddleOfEnteringANumber) {
            if (!self.isFloat) {
                self.display.text = [self.display.text stringByAppendingString:digit];
                
            }
        }
        else
        {
            self.display.text = @"0.";
//            self.history.text = @"0";
        }
        self.isFloat = YES;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    else if(self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
        else {
            self.display.text = digit;
            if (![digit isEqualToString:@"0"]) {
                self.userIsInTheMiddleOfEnteringANumber = YES;
            }
            
        }
        

//    self.history.text = [self.history.text stringByAppendingString:digit];
    
    NSLog(@"user touched %@", digit);
}

- (IBAction)enterPressed {
    
    if([self.display.text isEqualToString:@"π"])
    {
        [self.brain pushOperand:(M_PI)];
    }
    else
    {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.isFloat = NO;
    if ([self.history.text hasSuffix:@"="]) {
        self.history.text = [self.history.text substringToIndex:[self.history.text length]-1];
    }
    self.history.text = [[self.history.text stringByAppendingString:self.display.text] stringByAppendingString:@" "];
    
}


- (IBAction)operationPressed:(id)sender {
    
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    if ([self.history.text hasSuffix:@"="]) {
        self.history.text = [self.history.text substringToIndex:[self.history.text length]-1];
    }
    
    double result = [self.brain performOperation:operation];
    if(result == M_PI)
    {
        self.display.text = [NSString stringWithFormat:@"π"];
    }
    else
    {
        self.display.text = [NSString stringWithFormat:@"%g", result];
    }
    
//    self.history.text = [[self.history.text stringByAppendingString:operation] stringByAppendingString:@" ="];
    self.history.text = [NSString stringWithFormat: @"%@ %@ =", self.history.text, operation];
}
- (IBAction)clearAction:(UIButton *)sender {
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.isFloat = NO;
    [self.brain clear];
    self.history.text = @"";
}
- (IBAction)backspace:(id)sender  {
    if ([self.display.text length] > 1) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    }
    else{
        self.display.text = @"0";
    }
}

- (IBAction)negative:(id)sender {
    self.display.text = [NSString stringWithFormat:@"%g", [self.display.text doubleValue] * -1];
}

@end
