//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/8/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property(strong, nonatomic) NSMutableArray *cards;
@property(nonatomic) int score;
@property(nonatomic) NSString* lastAction;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck {
    
    self = [super init];
    if(self){
        for(int i=0; i < cardCount; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
    
}

-(Card*) cardAtIndex:(NSUInteger) index {
    return(index < self.cards.count) ? self.cards[index]:nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY_2CARDGAME 2
#define MATCH_BONUS_2CARDGAME 4
#define MISMATCH_PENALTY_3CARDGAME 4
#define MATCH_BONUS_3CARDGAME 16

-(void) flipCardAtIndex:(NSUInteger)index {
    
    Card* card = [self cardAtIndex:index];
    if(!card.isUnPlayable) {
        if(!card.isFaceUp) {
            
            self.lastAction = [NSString stringWithFormat:@"Fliped %@", card.contents];
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnPlayable) {
                    if(self.simultaneousCardsMatch == 2 ||self.simultaneousCardsMatch == 0) {
                        
                        //2-card matching logic
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore){
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS_2CARDGAME;
                            self.lastAction = [NSString stringWithFormat:@"Matched %@ with %@", card.contents, otherCard.contents];
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY_2CARDGAME;
                            self.lastAction = [NSString stringWithFormat:@"%@ and %@ do not match, -%d points", card.contents, otherCard.contents, MISMATCH_PENALTY_2CARDGAME];
                        }
                    
                    } else if (self.simultaneousCardsMatch == 3) {
                        
                        for(Card *thirdCard in self.cards) {
                            if(thirdCard.isFaceUp && !thirdCard.isUnPlayable && ![thirdCard.contents isEqualToAttributedString:otherCard.contents]) {
                                
                                //3-card matching logic
                                int matchScore = [card match:@[otherCard, thirdCard]];
                                if(matchScore){
                                    thirdCard.unplayable = YES;
                                    otherCard.unplayable = YES;
                                    card.unplayable = YES;
                                    self.score += matchScore * MATCH_BONUS_3CARDGAME;
                                    self.lastAction = [NSString stringWithFormat:@"Matched %@, %@ and %@", card.contents, otherCard.contents, thirdCard.contents];
                                } else {
                                    thirdCard.faceUp = NO;
                                    otherCard.faceUp = NO;
                                    self.score -= MISMATCH_PENALTY_3CARDGAME;
                                    self.lastAction = [NSString stringWithFormat:@"%@, %@ and %@ do not match, -%d points", card.contents, otherCard.contents, thirdCard.contents, MISMATCH_PENALTY_3CARDGAME];
                                }
                            }
                        }
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
    
}

@end
