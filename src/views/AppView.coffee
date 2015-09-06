class window.AppView extends Backbone.View
  template: _.template '
    <button class="deal-button">Deal</button>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .deal-button': -> @model.deal()


  initialize: ->
    @render()
    @startgame()
    @model.on 'all', (event) =>
      switch event
        when 'tie' then alert 'Push'
        when 'playerWin' then alert 'Player Wins!'
        when 'dealerWin' then alert 'Dealer Wins!'
        when 'change'
          @render()
          @startgame()
      if event isnt 'change' then @endgame()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  endgame: ->
    @$el.children('.hit-button').prop "disabled", true
    @$el.children('.stand-button').prop "disabled", true
    @$el.children('.deal-button').prop "disabled", false

  startgame: ->
    @$el.children('.hit-button').prop "disabled", false
    @$el.children('.stand-button').prop "disabled", false
    @$el.children('.deal-button').prop "disabled", true