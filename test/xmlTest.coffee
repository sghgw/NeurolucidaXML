chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML} = require '../lib/neurolucida-xml'
data = require './data'

describe 'NeurolucidaXML', ->

  neuro = undefined
  beforeEach ->
    neuro = new NeurolucidaXML

  it 'should be avaiable', ->
    expect(neuro).to.be.an 'object'

  describe '#loadXML()', ->

    it 'should return true', ->
      expect(neuro.loadXML(data.doc)).to.be.true

    it 'should save xml data to @xml', ->
      neuro.loadXML data.doc
      neuro.xml.should.be.an 'object'

    it 'should throw an error if xml argument is empty', ->
      neuro.loadXML.should.throw 'No XML found'

  describe '#_loadTree', ->

    it 'should throw error if @xml is empty', ->
      neuro._loadTree.should.throw '@xml is empty'


  describe '#_loadDendrite', ->

    it 'should push dendrites object to @_dendrites', ->
      dendrite = neuro._loadDendrite data.dendrite
      # dendrite.total_spines.should.be.equal 1
      neuro.getDendrites().length.should.be.equal 1