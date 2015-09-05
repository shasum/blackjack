# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'dealerStart', =>
      @get('dealerHand').at(0).flip()
      @get('dealerHand').checkScore()

    @get('dealerHand').on 'dealerStop', => @result()
    return


  result: ->
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    @trigger 'tie', @ if playerScore is dealerScore
    @trigger 'playerWin', @ if playerScore > dealerScore or dealerScore > 21
    @trigger 'dealerWin', @ if dealerScore > playerScore and dealerScore <= 21
    return