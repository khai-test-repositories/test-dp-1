TestDp1View = require './test-dp-1-view'
{CompositeDisposable} = require 'atom'

module.exports = TestDp1 =
  testDp1View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @testDp1View = new TestDp1View(state.testDp1ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @testDp1View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'test-dp-1:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @testDp1View.destroy()

  serialize: ->
    testDp1ViewState: @testDp1View.serialize()

  toggle: ->
    console.log 'TestDp1 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
