m = require 'methodder'
module.exports = class Index
	constructor:(@app, @db = null)->
		# navigation bar
		@app.locals nav:{Home:"/",Editor:'/editor'}
		@app.get '/', m @get, @
		@app.post '/', m @post, @
		@editor = new (require('./editor'))(@app, @db)
		#@register = new (require('./register'))(@app, @db)
	get: (req, res) ->
		res.render('index', {
			title: 'Code-edu'
			user: req.session.user
		})
	post: (req, res) ->
		console.log req.body