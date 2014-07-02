//
//  BugSection.h
//  Scary Bugs
//
//  Created by Mark Stuver on 6/22/14.
//  Copyright (c) 2014 Halo International Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

// import ScaryBug header file
#import "ScaryBug.h"

@interface BugSection : NSObject

// Create property of ScaryBug class
@property (assign) ScaryFactor howScary;

// Create property of NSMutableArray called bug
@property (nonatomic, strong) NSMutableArray *bugs;

// When this is called, it will initialize the instance based on what is passed into it.
-(instancetype)initWithHowScary:(ScaryFactor )howScary;

@end
