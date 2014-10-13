# NeurolucidaXML

[![Build Status](https://travis-ci.org/sghgw/NeurolucidaXML.svg?branch=master)](https://travis-ci.org/sghgw/NeurolucidaXML)

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

// Get dendrite data as an array of dendrite objects
parser.getDendrites();
```

## Data
NeuroluciaXML extracts data of dendrites and spines. Axons and cell bodies data is coming soon.

`parser.getDendrites()` will return an array of dendrite objects. The dendrite object looks like this:
```JavaScript
{
	name:           'name',
	diameter:       0.76,   // in µm	
	length:         12.7,   // in µm
	surface:        12.756, // in µm²
	volume:         1.022,	  // in µm³
	total_spines:   26,     // number of spines
	spine_density:	 2.04,	    // in 1/µm
	spine_means: {
		length:      1.34,	    // in µm
		diameter:    0.32     // in µm
	},
	spines:         [{spineObject}, ... , {spineObject}]
}
```

## Copyright and License
Copyright (c) 2014  Sascha Grothe

NeurolucidaXML is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

NeurolucidaXML is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the [GNU General Public License](http://www.gnu.org/licenses/) for more details.