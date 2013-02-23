//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
// returns a pointer to a playing card deck
- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (UIColor *color in [SetCard shapeColors]) {
                for (NSNumber *shade in [SetCard shapeShades]) {
                    for (int i=0; i < [[SetCard shapeCounts] count]; i++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.shapeColor = color;
                        card.shapeShade = [shade floatValue];
                        card.shapeCount = [[[SetCard shapeCounts] objectAtIndex:i] intValue];
                        [self addCard:card atTop:YES];  // Add card to top of deck
                        printf("loading new card into deck 2\n");
                    }
                }
            }
        }
    }
    return self;
}

@end
