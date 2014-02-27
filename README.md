# LineHeadWasher

[![Build Status](https://travis-ci.org/tbpgr/line_head_washer.png?branch=master)](https://travis-ci.org/tbpgr/line_head_washer)
[![Coverage Status](https://coveralls.io/repos/tbpgr/line_head_washer/badge.png)](https://coveralls.io/r/tbpgr/line_head_washer)

LineHeadWasher remove start of target pattern charactors.

## Installation

Add this line to your application's Gemfile:

    gem 'line_head_washer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install line_head_washer

## Usage
### generate Washfile
~~~bash
lhwasher init
~~~

~~~ruby
# encoding: utf-8

# input file or directory by regexp
# input is required
# input allow only String
# input's default value => "./*.txt"
input "./*.txt"

# output directory
# output is required
# output allow only String
# output's default value => "./"
output "./"

# remove_regexp
# remove_regexp is required
# remove_regexp allow only String
# remove_regexp's default value => "[ |	]"
remove_regexp "[ |	]"
~~~

### edit Washfile
~~~ruby
# encoding: utf-8

input "./inputs/*.txt"
output "./outputs"
remove_regexp "[ |	]*"
~~~

### prepare test input files
~~~bash
$ mkdir inputs
$ cat <<EOS>test1.txt
hoge
  hige
	hege
EOS
$ cat <<EOS>test2.txt
hoge
hige  
hege	
EOS
~~~

### execute wash files
~~~bash
lhwasher e
~~~

### check results
~~~bash
$ cat outputs/test1.txt

$ cat outputs/test2.txt

~~~

## History
version 0.0.1 : first release.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
