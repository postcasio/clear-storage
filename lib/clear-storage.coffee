path = require 'path'
fs = require 'fs'

unlinkFiles = (dir) ->
	if fs.existsSync(dir)
		for file in fs.readdirSync(dir)
			file_path = path.join(dir, file)
			if fs.lstatSync(file_path).isDirectory()
				unlinkFiles(file_path)
				fs.rmdirSync(file_path)
			else
				fs.unlinkSync(file_path)


module.exports =
	activate: (state) ->
		atom.commands.add 'atom-workspace',
			'clear-storage:clear': ->
					unlinkFiles atom.constructor.getStorageDirPath()

	deactivate: ->
