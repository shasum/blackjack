class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    if @isDealer then @.on 'dealerContinue', => @hit()
    if not @isDealer then Backbone.on 'pageReady', => @checkScore()

  hit: ->
    @add(@deck.pop())
    @checkScore()

  stand: ->
    @trigger 'dealerStart', @

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
    [@minScore(), @minScore() + 10 * @hasAce()]
    max = Math.max(@minScore(), @minScore() + 10 * @hasAce())
    if max <= 21 then max else @minScore()

  checkScore: ->
    @trigger 'dealerStart', @ if @scores() >= 21 and not @isDealer
    @trigger 'dealerStop', @ if @scores() >= 17 and @isDealer
    @trigger 'dealerContinue', @ if @scores() < 17 and @isDealer