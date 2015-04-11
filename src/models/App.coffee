# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @playing = true

    @get('playerHand').on 'bust', =>
      @evaluateGame()
    @get('dealerHand').on 'bust', =>
      @evaluateGame()
    @get('playerHand').on 'stand', =>
      @playing = false
      @get('dealerHand').dealerPlay @get('playerHand').scores()
    @get('dealerHand').on 'endGame', =>
      @evaluateGame()

  playing: true

  winner: "No Winner. Playing the Game"

  evaluateGame: ->
    @playing = false
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if (playerScore > 21) or (dealerScore > playerScore and dealerScore <= 21)
      @winner = "Dealer wins."
    else if (dealerScore > 21) or (playerScore > dealerScore and playerScore <= 21)
      @winner = "You Win!!!"
    else
      @winner = "Push. No one wins."

    @trigger 'winner', @



