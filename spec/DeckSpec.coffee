assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      last = deck.last()
      hand.hit()
      assert.strictEqual last, hand.at(2)
      assert.strictEqual deck.length, 49
