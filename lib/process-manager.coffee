module.exports =
class ProcessManager

  constructor: ->
    @PATH = switch process.platform
      when 'darwin'
        texbin = '/usr/texbin'
        process.env.PATH
      when 'linux'
        texbin = '/usr/texbin'
        process.env.PATH
      when 'win32'
        texbin = 'C:\\miktex\\bin'
        process.env.Path

    #TODO: Resolve texbin path automatically.
    @texPath = atom.config.get('texlicious.texPath') ? texbin
    #TODO: Get the users TEXINPUTS if they are defined in process.env.
    @texInputs = atom.config.get('texlicious.texInputs') ? ''

  options: () ->
    environment = process.env
    environment.PATH =  @PATH + ':' + @texPath + ':'
    unless process.platform is 'win32'
      environment.TEXINPUTS = @texInputs + '//:' if @texInputs isnt ''
    environment.timeout = 60000

    environment

  # kill: (pid) ->
  #   unless pid?
  #     console.log "No pid to kill."
  #   else
  #     try
  #       process.kill(pid, 'SIGINT')
  #     catch e
  #       if e.code is 'ESRCH'
  #         throw new Error("Process #{pid} has already been killed.")
  #       else
  #         throw (e)
