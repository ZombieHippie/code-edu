# This is for development purposes
ndm = require 'nodemon'
devreload = require 'devreload'
http = require 'http'
p = require 'path'
# Use devreload for automatic reloading
devreload.listen http.createServer(), {
	watch:null, port:9999
}

std = (data)->console.log data.toString()

gen = (type, callback)->
	spawn = require('child_process').spawn 'cmd', ["/c", "cake", 'build:'+type]
	console.log "Generating #{type} files"
	spawn.on 'error', std
	spawn.stdout.on 'data', std
	spawn.stderr.on 'data', std
	spawn.on 'exit', callback
checkGenSrc = (callback)->
	if '--gensrc' in process.argv
		gen 'src', callback
	else callback()
checkGenVendors = (callback)->
	if '--genvendors' in process.argv
		gen 'vendors', callback
	else callback()
checkGen = (callback)->
	checkGenSrc ->
		checkGenVendors callback
start = ->
	ext = 'jade styl coffee js'
	watch = ['routes/','views/','app.coffee']
	if '--genvendors' in process.argv
		watch.push 'vendors/'
	if '--gensrc' in process.argv
		watch.push 'src/'
		watch.push 'vendor/CodeMirror4/lib/'
	ndm {
		script:'app.coffee'
		watch
		ext
	}
	.on 'restart', (files)->
		checkGen ->
			devreload.reload()
	#.on 'stdout', std
	#.on 'stderr', std
	.on 'crash', ->
		std "CRASH"
	.on 'log', (log) ->
		console.log log.colour
checkGen ->
	start()
