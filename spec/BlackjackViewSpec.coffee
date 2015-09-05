assert = chai.assert
expect = chai.expect

describe 'blackjack', ->
  app = null
  playerHand = null
  dealerHand = null
  dealerHitSpy = null

  beforeEach ->
    app = new App()
    playerHand = app.get('playerHand')
    dealerHand = app.get('dealerHand')
    dealerHitSpy = sinon.spy(dealerHand, 'hit');

  describe "Player's Turn", ->
    it 'should start dealer turn when player clicks stand', ->
      assert.isFalse(dealerHand.at(0).get('revealed'))
      playerHand.stand()
      assert.isTrue(dealerHand.at(0).get('revealed'))

  describe "Dealer's Turn", ->
    it 'should stop dealing when score exceeds 16', ->
      oldScores = dealerHand.scores
      dealerHand.scores = ->
        10 + @length
      expect(dealerHitSpy).to.have.not.been.called;
      playerHand.stand()
      expect(dealerHitSpy).to.have.callCount(5)
      dealerHand.scores = oldScores