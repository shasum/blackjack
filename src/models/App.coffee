# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'dealerStart', =>
      @get('dealerHand').at(0).flip()
      if @get('playerHand').scores() > 21
        @result()
      else
        @get('dealerHand').checkScore()

    @get('dealerHand').on 'dealerStop', => @result()

    return


  result: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    @trigger 'tie', @ if playerScore is dealerScore
    @trigger 'dealerWin', @ if playerScore > 21
    @trigger 'playerWin', @ if playerScore <= 21 and playerScore > dealerScore or dealerScore > 21
    @trigger 'dealerWin', @ if dealerScore > playerScore and dealerScore <= 21
    return