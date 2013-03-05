//
//  MatchingGame.h
//  Matchismo
//
//  Created by Eugene Chuvyrov on 3/2/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface MatchingGame : NSObject

//Designated Initializer
-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck;

-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*) cardAtIndex:(NSUInteger) index;

@property(nonatomic) int simultaneousCardsMatch;
@property(nonatomic) int score;
@property(nonatomic, strong) NSMutableAttributedString* lastAction;

@end
