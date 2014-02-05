window.editor = {}

editor.coffeescript = CodeMirror.fromTextArea document.getElementById("cm-coffeescript"), {
  mode: "coffeescript"
  tabMode: "indent"
  useTabs: false
  indentWithTabs: false
  indentUnit:2
  theme: "neat"
  styleSelectedText: true
  lineNumbers: true
  autoCloseBrackets: true
  showCursorWhenSelecting: true
  autofocus: true
  extraKeys:
    "Ctrl-Enter": (cm)->
      preview(cm)
}