# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', =>
      console.log "BUSTED"
      @evaluateGame()
    @get('dealerHand').on 'bust', =>
      console.log "BUSTED"
      @evaluateGame()
    @get('playerHand').on 'stand', =>
      @get('dealerHand').dealerPlay @get('playerHand').scores()
    @get('dealerHand').on 'endGame', =>
      @evaluateGame()

  evaluateGame: ->
    console.log("Evaluating game")
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if (playerScore > 21) or (dealerScore > playerScore and dealerScore <= 21)
      console.log("DEALER WINS")
    else if (dealerScore > 21) or (playerScore > dealerScore and playerScore <= 21)
      console.log("PLAYER WINS")
    else
      console.log("PUSH")
