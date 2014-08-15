chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML, Segment} = require '../lib/neurolucida-xml'
data = require './data'

describe 'NeurolucidaXML', ->

  it 'should load a XML string', ->
    xml = new NeurolucidaXML
    xml.load(data).should.equal true
    