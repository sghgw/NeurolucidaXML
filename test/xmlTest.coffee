chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML} = require '../lib/neurolucida-xml'
data = require './data'

describe 'NeurolucidaXML', ->

  it 'should be avaiable', ->
    xml = new NeurolucidaXML
    expect(xml).to.be.an 'object'

  describe '#loadXML()', ->

    it 'should return true', ->
      xml = new NeurolucidaXML
      expect(xml.loadXML(data.doc)).to.be.true

    it 'should save xml data to @xml', ->
      xml = new NeurolucidaXML
      xml.loadXML data.doc
      xml.xml.should.be.an 'object'

    it 'should throw an error if xml argument is empty', ->
      xml = new NeurolucidaXML
      # error = new Error('No XML found')
      xml.loadXML.should.throw 'No XML found'

  describe '#_loadDendrite', ->

    it 'should push dendrites object to @_dendrites', ->
      xml = new NeurolucidaXML
      dendrite = xml._loadDendrite data.dendrite
      # dendrite.total_spines.should.be.equal 1
      xml.getDendrites().length.should.be.equal 1