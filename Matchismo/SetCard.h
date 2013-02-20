//
//  SetCard.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
