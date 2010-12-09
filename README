jrxlightweb

a library wrapping the JAVA xlightweb jar

only GET and POST requests are supported at present

The top level interface has similar method signatures to rest-client
https://github.com/archiloque/rest-client

Usage:
irb example... using mongrel2 standard config

load 'jrxlightweb.rb'
url = "http://localhost:6767/tests/sample.html"

#synchronous
jruby-1.5.2 > p JrxlightWeb.get(url)
  time-sync: 6 ms
  "hi there\n"
  => nil

#asynchronous

handler = lambda {|resp| puts resp.get_non_blocking_body.read_string_by_delimiter("\n")}
th=[];6.times{th << Thread.new {JrxlightWeb.get(url,{},handler)}; th.each{|t| t.join}}
  time-lamb: 0 ms
  time-lamb: 1 ms
  hi there
  hi there
  time-lamb: 1 ms
  hi there
  time-lamb: 2 ms
  hi there
  time-lamb: 7 ms
  hi there
  time-lamb: 1 ms
   => 6
  hi there


#proper async

require 'thread'
q = Queue.new
url = "http://some_service.org/some/api/logon"
pl = {'login_id'=>'api_test@some_service.org','password'=>'afgafgafgadfg','answer'=>'aardvark'}
th=[];6.times{th << Thread.new {JrxlightWeb.post(url,pl){|resp| body = resp.get_non_blocking_body; len = body.available; q << body.read_string_by_length(len) }}; th.each{|t| t.join}}  
time-asyn: 1 ms
time-asyn: 0 ms
time-asyn: 0 ms
time-asyn: 1 ms
time-asyn: 0 ms
time-asyn: 2 ms
 => 6
6.times{puts q.pop}
{"status":"success","data":{"token":"aaabbbccc"}}
{"status":"success","data":{"token":"aaabbbccc"}}
{"status":"success","data":{"token":"aaabbbccc"}}
{"status":"success","data":{"token":"aaabbbccc"}}
{"status":"success","data":{"token":"aaabbbccc"}}
{"status":"success","data":{"token":"aaabbbccc"}}
=> 6 
 




