//
//  ScaryBug.m
//  ScaryBugs
//
//  Created by Main Account on 10/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "ScaryBug.h"

@implementation ScaryBug

- (id)initWithName:(NSString *)name image:(UIImage *)image howScary:(ScaryFactor)howScary {
  if ((self = [super init])) {
    _name = name;
    _image = image;
    _howScary = howScary;
  }
  return self;
}

- (NSString *)howScaryString {
  return [ScaryBug scaryFactorToString:(self.howScary)];
}

+ (NSString *)scaryFactorToString:(ScaryFactor)scaryFactor {
  switch (scaryFactor) {
    case ScaryFactorNotScary:
      return @"Not scary";
      break;
    case ScaryFactorALittleScary:
      return @"A little scary";
      break;
    case ScaryFactorAverageScary:
      return @"Average scariness";
      break;
    case ScaryFactorQuiteScary:
      return @"Quite scary";
      break;
    case ScaryFactorAiiiiieeeee:
      return @"AIIIIIEEEEE!!";
      break;
  }
}

+ (NSMutableArray *)bugs {
  ScaryBug * centipede = [[ScaryBug alloc] initWithName:@"Centipede" image:[UIImage imageNamed:@"centipede.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * ladybug = [[ScaryBug alloc] initWithName:@"Ladybug" image:[UIImage imageNamed:@"ladybug.jpg"] howScary:ScaryFactorNotScary];
  ScaryBug * potatoBug = [[ScaryBug alloc] initWithName:@"Potato Bug" image:[UIImage imageNamed:@"potatoBug.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * wolfSpider = [[ScaryBug alloc] initWithName:@"Wolf Spider" image:[UIImage imageNamed:@"wolfSpider.jpg"] howScary:ScaryFactorAiiiiieeeee];
  ScaryBug * bee = [[ScaryBug alloc] initWithName:@"Bee" image:[UIImage imageNamed:@"bee.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * beetle = [[ScaryBug alloc] initWithName:@"Beetle" image:[UIImage imageNamed:@"beetle.jpg"] howScary:ScaryFactorALittleScary];
  ScaryBug * burritoInsect = [[ScaryBug alloc] initWithName:@"Burrito Insect" image:[UIImage imageNamed:@"burritoInsect.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * caterpillar = [[ScaryBug alloc] initWithName:@"Caterpillar" image:[UIImage imageNamed:@"caterpillar.jpg"] howScary:ScaryFactorNotScary];
  ScaryBug * cicada = [[ScaryBug alloc] initWithName:@"Cicada" image:[UIImage imageNamed:@"cicada.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * cockroach = [[ScaryBug alloc] initWithName:@"Cockroach" image:[UIImage imageNamed:@"cockroach.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * exoskeleton = [[ScaryBug alloc] initWithName:@"Exoskeleton" image:[UIImage imageNamed:@"exoskeleton.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * fly = [[ScaryBug alloc] initWithName:@"Fly" image:[UIImage imageNamed:@"fly.jpg"] howScary:ScaryFactorNotScary];
  ScaryBug * giantMoth = [[ScaryBug alloc] initWithName:@"Giant Moth" image:[UIImage imageNamed:@"wolfSpider.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * grasshopper = [[ScaryBug alloc] initWithName:@"Grasshopper" image:[UIImage imageNamed:@"grasshopper.jpg"] howScary:ScaryFactorAiiiiieeeee];
  ScaryBug * mosquito = [[ScaryBug alloc] initWithName:@"Mosquito" image:[UIImage imageNamed:@"mosquito.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * prayingMantis = [[ScaryBug alloc] initWithName:@"Praying Mantis" image:[UIImage imageNamed:@"prayingMantis.jpg"] howScary:ScaryFactorNotScary];
  ScaryBug * roach = [[ScaryBug alloc] initWithName:@"Roach" image:[UIImage imageNamed:@"roach.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * robberFly = [[ScaryBug alloc] initWithName:@"Robber Fly" image:[UIImage imageNamed:@"robberFly.jpg"] howScary:ScaryFactorQuiteScary];
  ScaryBug * scorpion = [[ScaryBug alloc] initWithName:@"Scorpion" image:[UIImage imageNamed:@"scorpion.jpg"] howScary:ScaryFactorAiiiiieeeee];
  ScaryBug * shieldBug = [[ScaryBug alloc] initWithName:@"Shield Bug" image:[UIImage imageNamed:@"shieldBug.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * stagBeetle = [[ScaryBug alloc] initWithName:@"Stag Beetle" image:[UIImage imageNamed:@"stagBeetle.jpg"] howScary:ScaryFactorAverageScary];
  ScaryBug * stinkBug = [[ScaryBug alloc] initWithName:@"Stink Bug" image:[UIImage imageNamed:@"stinkbug.jpg"] howScary:ScaryFactorALittleScary];
  
  return [@[centipede, ladybug, potatoBug, wolfSpider, bee, beetle, burritoInsect, caterpillar, cicada, cockroach, exoskeleton, fly, giantMoth, grasshopper, mosquito, prayingMantis, roach, robberFly, scorpion, shieldBug, stagBeetle, stinkBug] mutableCopy];
}

@end