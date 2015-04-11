class window.AppView extends Backbone.View
  template: _.template '
    <div class="winner-container"><h2>No Winner</h2></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      if @model.playing
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if @model.playing
        @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'winner', =>
      @changeWinner()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  changeWinner: ->
    @$('.winner-container h2').text(@model.winner)
