hash = require('../pass').hash
m = require 'methodder'

module.exports = class Editor
	constructor:(@app, @db)->
		@app.get '/editor', m @get, @
	get: (req, res)=>
		res.render 'editor.jade', {
				title: 'Inkblur editor'
				user: req.session.user}