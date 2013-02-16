//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/8/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardDeck.h"

@interface CardMatchingGame : NSObject

//Designated Initializer
-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck;

-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*) cardAtIndex:(NSUInteger) index;

@property(nonatomic) int simultaneousCardsMatch;
@property(nonatomic, readonly) int score;
@property(nonatomic, readonly) NSString* lastAction;

@end
