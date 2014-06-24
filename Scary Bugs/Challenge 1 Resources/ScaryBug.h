//
//  ScaryBug.h
//  ScaryBugs
//
//  Created by Main Account on 10/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

// ScaryBug Model Class provided by Ray Wenderlich video tutorial TableViews

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ScaryFactor) {
  ScaryFactorNotScary,
  ScaryFactorALittleScary,
  ScaryFactorAverageScary,
  ScaryFactorQuiteScary,
  ScaryFactorAiiiiieeeee
};

@interface ScaryBug : NSObject

@property (strong) NSString * name;
@property (retain) UIImage * image;
@property (assign) ScaryFactor *howScary;

- (id)initWithName:(NSString *)name image:(UIImage *)image howScary:(ScaryFactor)howScary;
- (NSString *)howScaryString;

+ (NSMutableArray *)bugs;
+ (NSString *)scaryFactorToString:(ScaryFactor)scaryFactor;

@end