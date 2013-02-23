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

@property (strong, nonatomic)NSString *shape;
@property (strong, nonatomic)UIColor *shapeColor;
@property (nonatomic)CGFloat shapeShade;
@property (nonatomic) NSUInteger shapeCount;

+ (NSArray *)validShapes;
+ (NSArray *)shapeColors;
+ (NSArray *)shapeShades;
+ (NSArray *)shapeCounts;

@end
