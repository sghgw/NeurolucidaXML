# NeurolucidaXML

NeurolucidaXML will be a JavaScript library to parse data from Neurolucida XML files. I just start with this project, so it is far away from being complete.

## Installation
Install it with npm:
```
$ npm install neurolucida-xml
```

If you want to install it manually:
```HTML
<script src="lib/neurolucida-xml.js"></script>
<!-- Or use minified version -->
<script src="lib/neurolucida-xml.min.js"></script>
```
or for use with node:
```JavaScript
var NeurolucidaXML = require('./lib/neurolucida-xml.js').NeurolucidaXML;
// Or use minified version
var NeurolucidaXML = require('./lib/neurolucida-xml.min.js').NeurolucidaXML;
```
or in [CoffeeScript](http://coffeescript.org/):
```CoffeeScript
{NeurolucidaXML} = require './lib/neurolucida-xml.js'
# Or use minified version
{NeurolucidaXML} = require './lib/neurolucida-xml.min.js'
```