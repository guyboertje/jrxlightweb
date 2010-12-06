jrxlightweb

a library wrapping the JAVA xlightweb jar

only GET requests are supported at present

Usage:
irb example... using mongrel2 standard config

load 'jrxlightweb.rb'
url = "http://localhost:6767/tests/sample.html"

#synchronous
jruby-1.5.2 > p JrxlightWeb.get(url)
  time-nblk: 6 ms
  "hi there\n"
  => nil

#asynchronous
handler = lambda {|resp| puts resp.get_non_blocking_body.read_string_by_delimiter("\n")}
th=[];6.times{th << Thread.new {JrxlightWeb.get(url,{},handler)}; th.each{|t| t.join}}
  time-call: 0 ms
  time-call: 1 ms
  hi there
  hi there
  time-call: 1 ms
  hi there
  time-call: 2 ms
  hi there
  time-call: 7 ms
  hi there
  time-call: 1 ms
   => 6
  hi there




