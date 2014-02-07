#_require coffeescript-mode

window.editor = {}

editor.coffeescript = CodeMirror.fromTextArea document.getElementById("cm-coffeescript"), {
  mode: "coffeescript2"
  useTabs: false
  indentWithTabs: false
  indentUnit: 2
  theme: "edu"
  styleSelectedText: true
  lineNumbers: true
  autoCloseBrackets: true
  showCursorWhenSelecting: true
  styleActiveLine: true
  matchTags: true
  autofocus: true
  fontSize: 18
  extraKeys:
    "Ctrl-Enter": (cm)->
      preview(cm)
    "Tab": (cm)->
      if cm.getOption("useTabs")
        return CodeMirror.Pass
      spaces = Array(cm.getOption("indentUnit") + 1).join(" ")
      cm.replaceSelection(spaces, "end", "+input")
}

$(window).on 'keyup', (e)->
  if e.keyCode is 27 # Esc key
    cursor = editor.coffeescript.getCursor()
    editor.coffeescript.setCursor(cursor)
    editor.coffeescript.focus()


editor.coffeescript.setValue """
hash = require('../pass').hash
m = require 'methodder'

module.exports = class Editor
  constructor:(@app, @db)->
    @app.get '/editor', m @get, @
  get: (req, res)=>
    res.render 'editor.jade', {
        title: 'Inkblur editor'
        user: req.session.user
    }
  compares: (a = 9, b = 10) ->
    res = false
    res = a > b
    a += 3
    res = b >= a%%3
    res &= true
"""