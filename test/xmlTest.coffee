chai = require 'chai'
chai.should()
expect = chai.expect

{NeurolucidaXML, Segment} = require '../lib/neurolucida-xml'

describe 'NeurolucidaXML', ->

  it 'should load a XML'