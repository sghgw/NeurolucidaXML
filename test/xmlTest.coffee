chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML, Segment} = require '../lib/neurolucida-xml'
data = require './data'

describe 'NeurolucidaXML', ->

  it 'should be avaiable', ->
    xml = new NeurolucidaXML
    expect(xml).to.be.an 'object'

  describe '#load()', ->

    it 'should load a XML string and return true', ->
      xml = new NeurolucidaXML
      expect(xml.load(data)).to.be.true

  describe '#_loadDendrite', ->

    it 'should push dendrites object to @_dendrites', ->
      
    