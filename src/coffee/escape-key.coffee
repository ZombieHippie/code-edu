cmEscapeKey= (cm)->
  $(window).on 'keyup', (e)->
    if e.keyCode is 27 # Esc key
      # Find upmost range
      top = null
      for range in cm.doc.sel.ranges
        if (not top?) or (top.anchor.line > range.anchor.line) or
            ((top.anchor.line is range.anchor.line) and
            (top.anchor.ch > range.anchor.ch))
          top = range
      if top is null
        return
      cm.setSelection top.anchor, top.head
      cm.refresh()
      cm.focus()