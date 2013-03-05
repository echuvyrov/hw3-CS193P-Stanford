//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Eugene Chuvyrov on 2/16/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardViewCell.h"

@implementation SetGameViewController

- (MatchingGame *)game
{
    if (![super game])
        super.game = [[SetMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                       usingDeck:[self createDeck]];
    return [super game];
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCardViewCell class]]) {
        SetCardView *setCardView = ((SetCardViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.shape = setCard.shape;
            setCardView.shapeColor = setCard.shapeColor;
            setCardView.shapeCount = setCard.shapeCount;
            setCardView.shapeShade = setCard.shapeShade;
            
            setCardView.faceUp = setCard.isFaceUp;
            
            setCardView.alpha = setCard.isUnPlayable ? 0.3 : (setCard.isFaceUp ? 0.3: 1.0);
        }
    }
}

@end
