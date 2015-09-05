new AppView(model: new App()).$el.appendTo 'body'
Backbone.trigger 'pageReady'