//
//  BugSection.m
//  Scary Bugs
//
//  Created by Mark Stuver on 6/22/14.
//  Copyright (c) 2014 Halo International Corp. All rights reserved.
//

#import "BugSection.h"

@implementation BugSection


/// initializer - Sets up initial instance of scareFactor
-(instancetype)initWithHowScary:(ScaryFactor )howScary {
    
    if ((self = [super init])) {
        
        self.howScary = howScary;
        _bugs = [NSMutableArray array];
    }
    return self;
}


@end
