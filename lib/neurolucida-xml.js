(function() {
  var Segment, root;

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

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.Segment = Segment;

}).call(this);

(function() {
  var NeurolucidaXML, root;

  NeurolucidaXML = (function() {
    function NeurolucidaXML() {
      this.dendrites = [];
    }

    NeurolucidaXML.prototype.load = function(xml) {
      if (!xml) {
        throw new Error('No XML found');
      }
      this.xml = $($.parseXML(xml));
      return this.loadDendrites(this.xml.find('tree[type=Dendrite]'));
    };

    NeurolucidaXML.prototype.loadDendrites = function(tags) {
      var tag, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = tags.length; _i < _len; _i++) {
        tag = tags[_i];
        _results.push(this.loadDendrite($(tag)));
      }
      return _results;
    };

    NeurolucidaXML.prototype.loadDendrite = function(tag) {
      var dendrite, end, next, point, segment, spine, start, _i, _j, _len, _len1, _ref, _ref1;
      dendrite = {
        segments: [],
        spines: [],
        length: 0,
        total_spines: 0,
        surface: 0,
        volume: 0,
        group: '',
        file: '',
        title: ''
      };
      _ref = tag.children('point');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        point = _ref[_i];
        next = $(point).next('point');
        if (next) {
          segment = new Segment(this._getCoordinates($(point)), this._getCoordinates(next));
          dendrite.length += segment.getLength();
        }
      }
      _ref1 = tag.children('spine');
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        spine = _ref1[_j];
        start = this._getCoordinates($(spine).prev('point'));
        end = this._getCoordinates($(spine).children('point').first());
        spine = new Segment(start, end);
        dendrite.spines.push({
          length: spine.getLength()
        });
        dendrite.total_spines++;
      }
      return this.dendrites.push(dendrite);
    };

    NeurolucidaXML.prototype._getCoordinates = function(point) {
      return [parseFloat(point.attr('x')), parseFloat(point.attr('y')), parseFloat(point.attr('z')), parseFloat(point.attr('d'))];
    };

    return NeurolucidaXML;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.NeurolucidaXML = NeurolucidaXML;

}).call(this);
