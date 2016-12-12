//
//  InterfaceController.m
//  FileMasterWatch Extension
//
//  Created by Tengfei on 2016/12/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "InterfaceController.h"
typedef NS_ENUM(NSUInteger, ActionType) {
    ActionUnknown,
    ActionSum, //加
    ActionSubtraction,//减
    ActionMultiplication,//乘
    ActionDivision //除
};


@interface InterfaceController()
- (IBAction)backAction;
- (IBAction)clearAction;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *resultL;

@property (strong, nonatomic) NSString *displayStr;

@property (strong, nonatomic) NSString *previousStr;

@property (assign, nonatomic) ActionType currentAction;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    self.displayStr = @"";
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)backAction {
    if (self.displayStr.length > 0) {
        self.displayStr = [self.displayStr substringToIndex:[self.displayStr length] - 1];
        [self.resultL setText:self.displayStr];
    }
}

- (IBAction)clearAction {
    self.previousStr = nil;
    self.currentAction = ActionUnknown;
    self.displayStr = [NSMutableString string];
    [self.resultL setText:@"0"];
}


#pragma mark --- Action

//加
- (IBAction)sum {
    self.previousStr = self.displayStr;
    self.displayStr = [NSMutableString string];
    [self.resultL setText:@"0"];
    self.currentAction = ActionSum;
}

//减
- (IBAction)subtract {
    self.previousStr = self.displayStr;
    self.displayStr = [NSMutableString string];
    [self.resultL setText:@"0"];
    self.currentAction = ActionSubtraction;
}

//乘
- (IBAction)multiply {
    self.previousStr = self.displayStr;
    self.displayStr = [NSMutableString string];
    [self.resultL setText:@"0"];
    self.currentAction = ActionMultiplication;
}

//除
- (IBAction)divide {
    self.previousStr = self.displayStr;
    self.displayStr = [NSMutableString string];
    [self.resultL setText:@"0"];
    self.currentAction = ActionDivision;
}



//等于
- (IBAction)equalAction {
    if (self.currentAction == ActionSum) {
        NSString *stringResult = [NSString stringWithFormat:@"%.1f", [self.previousStr floatValue] + [self.displayStr floatValue]];
        [self.resultL setText:stringResult];
        self.displayStr = [stringResult mutableCopy];
    } else if (self.currentAction == ActionSubtraction) {
        NSString *stringResult = [NSString stringWithFormat:@"%.1f", [self.previousStr floatValue] - [self.displayStr floatValue]];
        [self.resultL setText:stringResult];
        self.displayStr = [stringResult mutableCopy];
    } else if (self.currentAction == ActionMultiplication) {
        NSString *stringResult = [NSString stringWithFormat:@"%.1f", [self.previousStr floatValue] * [self.displayStr floatValue]];
        [self.resultL setText:stringResult];
        self.displayStr = [stringResult mutableCopy];
    } else if (self.currentAction == ActionDivision) {
        NSString *stringResult = [NSString stringWithFormat:@"%.1f", [self.previousStr floatValue] / [self.displayStr floatValue]];
        [self.resultL setText:stringResult];
        self.displayStr = [stringResult mutableCopy];
    }
    self.previousStr = nil;
    self.currentAction = ActionUnknown;
}

- (IBAction)dot {
    [self toDisplay:@"."];
}

- (IBAction)zero  {
    [self toDisplay:@"0"];
}


- (IBAction)one  {
    [self toDisplay:@"1"];
}

- (IBAction)two  {
    [self toDisplay:@"2"];
}

- (IBAction)three  {
    [self toDisplay:@"3"];
}

- (IBAction)four {
    [self toDisplay:@"4"];
}

- (IBAction)five  {
    [self toDisplay:@"5"];
}

- (IBAction)six  {
    [self toDisplay:@"6"];
}

- (IBAction)seven  {
    [self toDisplay:@"7"];
}

- (IBAction)eight  {
    [self toDisplay:@"8"];
}

- (IBAction)nine  {
    [self toDisplay:@"9"];
}

- (void)toDisplay:(NSString *)string {
    self.displayStr = [self.displayStr stringByAppendingString:string];
    [self.resultL setText:self.displayStr];
}



@end



