class NeurolucidaXML
  constructor: ->
    @_dendrites = []
  load: (xml) ->
    throw new Error('No XML found') if !xml
    # get DOMParser and load XML
    if typeof DOMParser is 'undefined'
      parser = require('xmldom').DOMParser
      @xml = new parser().parseFromString xml, 'text/xml'
    else
      parser = new DOMParser()
      @xml = parser.parseFromString xml, 'text/xml'
    
    if @xml
      @loadTree()
      # TODO: load cell bodies

      true 
    else
      throw new Error('Incorrect XML: ' + xml)

  # load dendrite data from a collection of tree[type=Dendrite] tags
  loadTree: ->
    for tree in @xml.getElementsByTagName('tree')
      switch tree.getAttribute 'type'
        when 'Axon' then @loadAxon tree
        when 'Dendrite' then @loadDendrite tree

  # load dendrite data from a single tree[type=Dendrite] tag
  loadDendrite: (tag) ->
    # create basic template for dendrite object
    dendrite = {
      spines: []
      length: 0
      total_spines: 0
      surface: 0
      volume: 0
      diameter: 0
      group: ''
      file: ''
      title: ''
    }

    # loop through all point tags and create a segment of dendrite between this point and the next one
    for point in tag.children('point')
      next = $(point).nextAll('point').first()
      if next.length > 0
        segment = new Segment(@_getCoordinates($(point)), @_getCoordinates(next)) 
        dendrite.length += segment.getLength()
        dendrite.volume += segment.getVolume()
        dendrite.surface += segment.getSurface()
        dendrite.diameter += segment.getDiameter()


    dendrite.diameter /= (tag.children('point').length - 1)

    # loop through all spine tags
    for spine in tag.children 'spine'
      start = @_getCoordinates $(spine).prev('point')
      end = @_getCoordinates $(spine).children('point').first()
      spine = new Segment(start, end)
      dendrite.spines.push {
        length: spine.getLength()

      }
      dendrite.total_spines++

    @_dendrites.push dendrite

  #load axon data from single tree[type=Axon] tag
  loadAxon: (tag) ->
    # TODO: get axon informations from tree tag

  getDendrites: ->
    @_dendrites

  # return x, y, z, d of point tag as array
  _getCoordinates: (point) ->
    [
      parseFloat(point.attr 'x'),
      parseFloat(point.attr 'y'),
      parseFloat(point.attr 'z'),
      parseFloat(point.attr 'd')
    ]

root = exports ? window
root.NeurolucidaXML = NeurolucidaXML