(function() {
  var NeurolucidaXML, Segment, root;

  Segment = (function() {
    function Segment(startPoint, endPoint) {
      this.startPoint = startPoint;
      this.endPoint = endPoint;
      this.direction = [this.endPoint[0] - this.startPoint[0], this.endPoint[1] - this.startPoint[1], this.endPoint[2] - this.startPoint[2]];
    }

    Segment.prototype.getLength = function() {
      var x, y, z;
      x = Math.pow(this.endPoint[0] - this.startPoint[0], 2);
      y = Math.pow(this.endPoint[1] - this.startPoint[1], 2);
      z = Math.pow(this.endPoint[2] - this.startPoint[2], 2);
      return Math.sqrt(x + y + z);
    };

    Segment.prototype.getVolume = function() {
      var r1, r2, r3;
      r1 = Math.pow(this.startPoint[3] / 2, 2);
      r2 = Math.pow(this.endPoint[3] / 2, 2);
      r3 = (this.startPoint[3] * this.endPoint[3]) / 4;
      return ((Math.PI * this.getLength()) / 3) * (r1 + r2 + r3);
    };

    Segment.prototype.getSurface = function() {
      var m, r1, r2;
      r1 = this.startPoint[3] / 2;
      r2 = this.endPoint[3] / 2;
      m = Math.sqrt(Math.pow(r1 - r2, 2) + Math.pow(this.getLength(), 2));
      return (r1 + r2) * m * Math.PI;
    };

    Segment.prototype.getDiameter = function() {
      return (this.startPoint[3] + this.endPoint[3]) / 2;
    };

    Segment.prototype.distanceToPoint = function(point) {
      var d1, d2, r;
      r = [point[0] - this.startPoint[0], point[1] - this.startPoint[1], point[2] - this.startPoint[2]];
      d1 = [this.direction[1] * r[2] - this.direction[2] * r[1], this.direction[2] * r[0] - this.direction[0] * r[2], this.direction[0] * r[1] - this.direction[1] * r[0]];
      d1 = Math.sqrt(Math.pow(d1[0], 2) + Math.pow(d1[1], 2) + Math.pow(d1[2], 2));
      d2 = Math.sqrt(Math.pow(this.direction[0], 2) + Math.pow(this.direction[1], 2) + Math.pow(this.direction[2], 2));
      return d1 / d2;
    };

    return Segment;

  })();

  NeurolucidaXML = (function() {
    function NeurolucidaXML() {
      this._dendrites = [];
    }

    NeurolucidaXML.prototype.load = function(xml) {
      var parser;
      if (!xml) {
        throw new Error('No XML found');
      }
      if (typeof DOMParser === 'undefined') {
        parser = require('xmldom').DOMParser;
        this.xml = new parser().parseFromString(xml, 'text/xml');
      } else {
        parser = new DOMParser();
        this.xml = parser.parseFromString(xml, 'text/xml');
      }
      if (this.xml) {
        this._loadTree();
        return true;
      } else {
        throw new Error('Incorrect XML: ' + xml);
      }
    };

    NeurolucidaXML.prototype._loadTree = function() {
      var tree, _i, _len, _ref, _results;
      _ref = this.xml.getElementsByTagName('tree');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tree = _ref[_i];
        switch (tree.getAttribute('type')) {
          case 'Axon':
            _results.push(this._loadAxon(tree));
            break;
          case 'Dendrite':
            _results.push(this._loadDendrite(tree));
            break;
          default:
            _results.push(void 0);
        }
      }
      return _results;
    };

    NeurolucidaXML.prototype._loadDendrite = function(tag) {
      var child, dendrite, end, index, next, prev, segment, spine, start, _i, _len, _ref;
      dendrite = {
        spines: [],
        length: 0,
        total_spines: 0,
        surface: 0,
        volume: 0,
        diameter: 0,
        segments: 0,
        group: '',
        file: '',
        title: ''
      };
      _ref = tag.childNodes;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        child = _ref[index];
        switch (child.nodeName) {
          case 'point':
            if ((tag.childNodes.length - 1) > index) {
              next = child;
              while (next) {
                next = next.nextSibling;
                if (!next || next.nodeName === 'point') {
                  break;
                }
              }
              if (next) {
                segment = new Segment(this._getCoords(child), this._getCoords(next));
                dendrite.segments += 1;
                dendrite.length += segment.getLength();
                dendrite.volume += segment.getVolume();
                dendrite.surface += segment.getSurface();
                dendrite.diameter += segment.getDiameter();
              }
            }
            break;
          case 'spine':
            prev = child;
            while (prev) {
              prev = prev.previousSibling;
              if (prev.nodeName === 'point') {
                break;
              }
            }
            start = this._getCoords(prev);
            end = this._getCoords(child.getElementsByTagName('point')[0]);
            spine = new Segment(start, end);
            dendrite.spines.push({
              length: spine.getLength()
            });
            dendrite.total_spines++;
        }
      }
      dendrite.diameter /= dendrite.segments;
      return this._dendrites.push(dendrite);
    };

    NeurolucidaXML.prototype._loadAxon = function(tag) {};

    NeurolucidaXML.prototype.getDendrites = function() {
      return this._dendrites;
    };

    NeurolucidaXML.prototype._getCoords = function(point) {
      return [parseFloat(point.getAttribute('x')), parseFloat(point.getAttribute('y')), parseFloat(point.getAttribute('z')), parseFloat(point.getAttribute('d'))];
    };

    NeurolucidaXML.prototype._getNextElement = function(element, nextElement) {
      while (element) {
        element = element.nextSibling;
        if (element.nodeName === nextElement) {
          break;
        }
      }
      return element;
    };

    return NeurolucidaXML;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.NeurolucidaXML = NeurolucidaXML;

}).call(this);
