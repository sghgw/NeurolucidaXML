class NeurolucidaXML
  constructor: ->
    @_dendrites = []

  # load xml and extract data
  # load: (xml) ->
  #   # TODO: call all methods to load and extract data
    
  #   if @xml
  #     @_loadTree()
  #     # TODO: load cell bodies

  #     true 
  #   else
  #     throw new Error('Incorrect XML: ' + xml)

  # load XML as string and convert it into DOM object
  loadXML: (xml) ->
    throw new Error('No XML found') if !xml
    # get DOMParser and load XML
    if typeof DOMParser is 'undefined'
      parser = require('xmldom').DOMParser
      @xml = new parser().parseFromString xml, 'text/xml'
    else
      parser = new DOMParser()
      @xml = parser.parseFromString xml, 'text/xml'
    
    if @xml then true else throw new Error('Incorrect XML: ' + xml)

  # load dendrite data from a collection of tree[type=Dendrite] tags
  _loadTree: ->
    throw new Error('@xml is empty') if !@xml
    for tree in @xml.getElementsByTagName('tree')
      switch tree.getAttribute 'type'
        when 'Axon' then @_loadAxon tree
        when 'Dendrite' then @_loadDendrite tree

  # load dendrite data from a single tree[type=Dendrite] tag
  _loadDendrite: (tag) ->
    # create basic template for dendrite object
    dendrite = {
      spines: []
      length: 0
      total_spines: 0
      surface: 0
      volume: 0
      diameter: 0
      segments: 0
      group: ''
      file: ''
      title: ''
    }

    # loop through all child tags of tree and create a segment of dendrite between this point and the next one or create a new spine
    for child, index in tag.childNodes
      switch child.nodeName
        when 'point'
          if (tag.childNodes.length - 1) > index
            next = child
            while next
              next = next.nextSibling
              break if !next or next.nodeName is 'point'
            if next
              segment = new Segment @_getCoords(child), @_getCoords(next)
              dendrite.segments += 1
              dendrite.length += segment.getLength()
              dendrite.volume += segment.getVolume()
              dendrite.surface += segment.getSurface()
              dendrite.diameter += segment.getDiameter()
        when 'spine'
          prev = child
          while prev
            prev = prev.previousSibling
            break if prev.nodeName is 'point'
          start = @_getCoords prev
          end = @_getCoords child.getElementsByTagName('point')[0]
          spine = new Segment start, end
          dendrite.spines.push {
            length: spine.getLength()
          }
          dendrite.total_spines++

    dendrite.diameter /= dendrite.segments
    @_dendrites.push dendrite
    dendrite

  #load axon data from single tree[type=Axon] tag
  _loadAxon: (tag) ->
    # TODO: get axon informations from tree tag

  getDendrites: ->
    @_dendrites

  # return x, y, z, d of point tag as array
  _getCoords: (point) ->
    [
      parseFloat(point.getAttribute 'x'),
      parseFloat(point.getAttribute 'y'),
      parseFloat(point.getAttribute 'z'),
      parseFloat(point.getAttribute 'd')
    ]

  # returns next avaiable element of "nextElement"
  _getNextElement: (element, nextElement) ->
    while element
      element = element.nextSibling
      break if element.nodeName is nextElement
    return element

root = exports ? window
root.NeurolucidaXML = NeurolucidaXML
root.Segment = Segment