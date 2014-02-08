#_require coffeescript-mode/coffeescript-mode
#_require sublime-keymap/sublime_keys
#_require escape-key

window.editor = {}

editor.coffeescript = CodeMirror.fromTextArea document.getElementById("cm-coffeescript"), {
  mode: "coffeescript"
  autofocus: true
  indentWithTabs: false
  useTabs: false
  indentUnit: 2
  fontSize: 18
  theme: "edu"
  lineNumbers: true

  showCursorWhenSelecting: true
  highlightSelectionMatches: true
  styleSelectedText: true
  styleActiveLine: true

  autoCloseBrackets: true
  sublimeKeys: true
  extraKeys:
    "Ctrl-Enter": (cm)->
      preview(cm)
    "Tab": (cm)->
      if cm.getOption("useTabs")
        return CodeMirror.Pass
      spaces = Array(cm.getOption("indentUnit") + 1).join(" ")
      cm.replaceSelection(spaces, "end", "+input")
}

window.cm = editor.coffeescript
cmEscapeKey editor.coffeescript

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