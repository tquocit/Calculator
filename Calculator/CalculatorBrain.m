//
//  CalculatorBrain.m
//  Calculator
//
//  Created by viet on 1/7/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack{
    if(!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void)setOperandStack:(NSMutableArray *)anArray{
    _operandStack = anArray;
}

- (void)clear
{
    [self.operandStack removeAllObjects];
}

-(void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
    NSLog(@"Stack: %@", [self.operandStack componentsJoinedByString:@" "]);
}

-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    
    if(operandObject) [self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}

-(double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if([operation isEqualToString:@"*"])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if([operation isEqualToString:@"-"])
    {
        double temp = [self popOperand];
        result = [self popOperand] - temp;
    }
    else if([operation isEqualToString:@"/"])
    {
        double temp = [self popOperand];
        result = [self popOperand] / temp;
    }
    else if([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]*M_PI/180);
    }
    else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]*M_PI/180);
    }
    else if([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    }
    else if([operation isEqualToString:@"π"]){
//        if (_operandStack) {
//            result = [self popOperand];
//        }
//        [self pushOperand:(M_PI)];
//        return result;
//        
        result = M_PI;
    }
    
    
    
    [self pushOperand:result];
    return result;
}


@end
