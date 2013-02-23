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

@interface SetGameViewController ()
// private property
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong)Card *card;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
- (IBAction)dealAction:(id)sender;
@property (strong, nonatomic) SetMatchingGame *game;

@end

@implementation SetGameViewController


-(void) viewDidLoad{
    [self startNewGame];
}

- (IBAction)dealAction:(id)sender {
    [self startNewGame];
}

-(void) startNewGame{
    self.game = [[SetMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    [self updateUI];
    
    self.flipsLabel.text = @"Flips: 0";
    self.lastActionLabel.text = @"Last Action: shuffled the deck";
    self.scoreLabel.text = @"Score: 0";
    self.flipCount = 0;
}

- (SetMatchingGame *) game
{
    if(!_game)
        _game = [[SetMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
}

-(void)updateUI
{
    //UIImage *cardBackImage = [UIImage imageNamed:@"Icon.png"];
    for(UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateNormal];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateDisabled];
        //[cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable? 0.3 : card.isFaceUp? 0.5: 1.0;
        cardButton.backgroundColor = card.isFaceUp? [UIColor grayColor] : [UIColor whiteColor];
        
        /*
         if(cardButton.isSelected){
         [cardButton setImage:nil forState:UIControlStateNormal];
         } else {
         [cardButton setImage:cardBackImage forState:UIControlStateNormal];
         }
         */
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastActionLabel.attributedText = self.game.lastAction;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString
                            stringWithFormat:@"Flips: %d",
                            self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;                      // update flip count
    [self updateUI];
}

@end
