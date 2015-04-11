class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->


  hit: ->
    console.log "Hit!"
    console.log @
    @add(@deck.pop())
    # if @scores > 21
    #   console.log "Bust!"
    #   @stand


  stand: ->
    # there should be an event to that signals end of round
    console.log "Stand!"
    @trigger('stand', @)


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    possible = [@minScore(), @minScore() + 10 * @hasAce()]
    if possible[1] < 21
      possible[1]
    else
      possible[0]

  dealerPlay: (playerScore) ->
    @.models[0].flip()

    tryToWin = () =>
      if (@scores() >= 17) or (playerScore == 21)
        return # stand
      else
        @hit()
        tryToWin()

    tryToWin()



