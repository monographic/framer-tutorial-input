# DEFAULTS

Framer.Defaults.Animation =
	curve: "ease-in-out"
	time: 0.15

inputFocus = false

# CREATE INPUT ELEMENTS

backLayer = new Layer
	width: Canvas.width
	height: Canvas.height
	backgroundColor: "transparent"
	
inputContainer = new Layer
	width: 360
	height: 76
	x: 170
	y: 162
	backgroundColor: "transparent"
	
inputLabel = new TextLayer
	text: "Your name"
	parent: inputContainer
	fontFamily: "Basis Grotesque Pro"
	fontSize: 16
	lineHeight: 1.25
	y: 18
	color: "#808080"

inputLabel.states =
	basic:
		fontSize: 16
		y: 18
	active:
		fontSize: 12
		y: 0

inputLine = new Layer
	parent: inputContainer
	height: 2
	width: inputContainer.width
	y: 54
	backgroundColor: "#e5e5e5"

inputLine.states =
	basic:
		backgroundColor: "#e5e5e5"
	hover:
		backgroundColor: "#bfbfbf"
	active:
		backgroundColor: "#000000"
	error:
		backgroundColor: "#bf3048"

inputError = new TextLayer
	text: ""
	parent: inputContainer
	fontFamily: "Basis Grotesque Pro"
	fontSize: 12
	lineHeight: 1.25
	y: 60
	color: "#bf3048"
	opacity: 0

# CREATE INPUT AREA

inputControl = document.createElement("input")
inputControl.style["width"] = "360px"
inputControl.style["height"] = "56px"
inputControl.style["font-family"] = "Basis Grotesque Pro"
inputControl.style["font-size"] = "16px"
inputControl.style["line-height"] = "2"
inputControl.style["outline"] = "none"
inputControl.style["color"] = "#000000"
inputControl.value = ""
inputContainer._element.appendChild(inputControl)

# INTERACTION

inputContainer.onClick ->
	inputFocus = true
	inputLine.animate("active")
	inputLabel.animate("active")

inputContainer.onMouseOver ->
	if !inputFocus
		inputLine.animate("hover")
inputContainer.onMouseOut ->
	if !inputFocus
		inputLine.animate("basic")

backLayer.onClick ->
	inputFocus = false
	inputLine.animate("basic")
	if inputControl.value == ""
		inputLabel.animate("basic")
		
inputControl.addEventListener "keyup", (ev) ->
	if inputControl.value == "Donald Trump"
		inputError.text = "You can't use this name"
		inputError.animate(opacity: 1)
		inputLine.animate("error")
	else
		inputError.animate(opacity: 0)
		inputLine.animate("active")
		Utils.delay 0.15, ->
			inputError.text = ""