class Hook
  constructor: (opts) ->
    @context =
      response: opts.response
      listener: opts.listener
      message:  opts.message
      robot:    opts.robot
      done:     @done
      next:     @next
    @hooks    = opts.hooks.slice 0 # make a shallow clone
    @callback = opts.callback

  run: ->
    nextHook = @hooks.shift()
    if nextHook?
      nextHook(@context)
    else
      @callback()

  done: =>
    @context.message.finish()
    @callback()

  next: =>
    @run()

module.exports = {
  Hook
}
