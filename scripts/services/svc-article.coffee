class ArticleSvc

  constructor: (@$q, @$http) ->
    @deffered = @$q.defer()

    @$http.get('/api/article')
      .success (data, status, headers, config) => 
        @articles = data
        @articlesIndex = {}
        for article in @articles
          @articlesIndex[article._id] = article 
          @articlesIndex[article.slug] = article if article.slug
        @deffered.resolve()
      .error (data, status, headers, config) => 
        @deffered.reject()

  all: (done) =>
    @deffered.promise.then => done(@articles)

  get: (id, done) =>
    @deffered.promise.then => done(@articlesIndex[id.trim()])



angular.module("ArticleSvc", []).service("ArticleSvc", ["$q", "$http", ArticleSvc])