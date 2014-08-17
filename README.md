# NeurolucidaXML

NeurolucidaXML will be a JavaScript library to parse data from Neurolucida XML files. I just start with this project, so it is far away from being complete.

## Installation
Install it with npm:
```
$ npm install neurolucida-xml
```
and use it with node:
```JavaScript
var NeurolucidaXML = require('neurolucida-xml').NeurolucidaXML;
```
or in [CoffeeScript](http://coffeescript.org/):
```CoffeeScript
{NeurolucidaXML} = require 'neurolucida-xml'
```

If you want to install it manually:
```HTML
<script src="lib/neurolucida-xml.js"></script>
<!-- Or use minified version -->
<script src="lib/neurolucida-xml.min.js"></script>
```

## Usage
JavaScript:
```JavaScript
// Initialize new instance of NeurolucidaXML parser
var parser = new NeurolucidaXML;

// Load XML string
var xmlString = '<mbf>...</mbf>';
parser.load(xmlString);
```

## Copyright and License
Copyright (c) 2014  Sascha Grothe

NeurolucidaXML is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.
NeurolucidaXML is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the [GNU General Public License](http://www.gnu.org/licenses/) for more details.