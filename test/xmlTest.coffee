chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML} = require '../lib/neurolucida-xml'
data = require './data'

describe 'NeurolucidaXML', ->

  it 'should be avaiable', ->
    xml = new NeurolucidaXML
    expect(xml).to.be.an 'object'

  describe '#load()', ->

    it 'should load a XML string and return true', ->
      xml = new NeurolucidaXML
      expect(xml.load(data.doc)).to.be.true
      expect(xml.getDendrites().length).to.equal 3

  describe '#_loadDendrite', ->

    it 'should push dendrites object to @_dendrites'