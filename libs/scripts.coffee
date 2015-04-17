path = require 'path'
fs   = require 'fs'
_    = require 'lodash'

wildcardToRegExp = (wildcardStr) ->
  return new RegExp wildcardStr.replace /\*/g, '.*'

class Scripts
  load: (wildcardStr, callback = ->) ->
    @findFiles wildcardStr, (err, files) ->
      if err
        callback err
        return

      scripts = []
      for file in files
        scripts.push
          name: file.name.match(/(.+)\.coffee$/)[1]
          fullpath: file.fullpath
          function: require file.fullpath

      callback null, scripts

  findFiles: (wildcardStr, callback = ->) ->
    fs.readdir path.resolve("scripts"), (err, files) ->
      if err
        callback err
        return

      files = _.chain(files)
      .filter (file) -> wildcardToRegExp("#{wildcardStr}\.coffee$").test file
      .map (file) ->
        fullpath: path.resolve 'scripts', file
        name: file
      .value()

      callback null, files


module.exports = new Scripts
