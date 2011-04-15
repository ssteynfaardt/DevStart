DevStart: Easy add commonly used services to Ubuntu 10.04+
==========================================================

**Setup your web server the easy way** DevStart takes care of adding 
adding all required repositories to `/etc/apt/sources.list` getting valid apt-key's
and installing the additionally required software, so  you can take care of what
really matters. Getting your webserver up and running.

**Currently DevStart can install:**

**1.** Zend Server 5.3 CE

**2.** MongoDb

**3.** Memcahe

**4.** Varnish

## Installation

### The Easy Method
Downloading just the setupDev.sh file

    $ curl -L http://goo.gl/NNn9B -o setupDev.sh && chmod +x setupDev.sh
    $ sudo ./devStart.sh

### The Git Clone Method
To install pow from source, you will need `node >=0.4` and `npm >=1.0`.

    $ git clone git://github.com/ssteynfaardt/DevStart.git && cd DevStart && chmod +x devStart.sh
    $ sudo ./devStart.sh

### Just follow the onscreen instructions:

    Zend Server 5.3 CE: [I]nstall, [U]pdate, [S]kip: 
    MongoDB Server: [I]nstall, [S]kip: 
    Memcached Server: [I]nstall, [S]kip:
    Varnish Proxy Server: [I]nstall, [S]kip:

**Note:** MongoDb will ask you what version to install, and is installed from source so could take some time to install.

## License

(The MIT License)

Copyright &copy; 2011 Stephan Steynfaardt

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
