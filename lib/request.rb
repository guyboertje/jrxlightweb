module JrxlightWeb

  MIME_MAP = HttpUtils.get_mime_type_mapping

  class Request

    def self.get(opts,&blk)
      url,headers,callable = opts.values_at(:url,:headers,:callable)
      
      req = GetRequest.new(url)
      ret = nil
      process_headers(headers).each{ |key,val| req.set_header(key,val) }
      st = System.nanoTime
      
      if block_given?
        resp = CLIENT.send(req,&blk)
        puts "time-asyn: #{(System.nanoTime - st)/1_000_000} ms"
      elsif callable
        resp = CLIENT.send(req,callable)
        puts "time-lamb: #{(System.nanoTime - st)/1_000_000} ms"
      else
        resp = CLIENT.call(req)
        ret = resp.get_body.read_string
        puts "time-sync: #{(System.nanoTime - st)/1_000_000} ms"
      end
      ret
    end
    def self.post(opts,&blk)
      url,headers,payload,callable = opts.values_at(:url,:headers,:payload,:callable)
      req = PostRequest.new(url,"application/x-www-form-urlencoded")
      payload.each do |key,value|
        req.set_parameter(key, value)
      end
      ret = nil
      process_headers(headers).each{ |key,val| req.set_header(key,val) }
      
      st = System.nanoTime
      if block_given?
        resp = CLIENT.send(req,&blk)
        puts "time-asyn: #{(System.nanoTime - st)/1_000_000} ms"
      elsif callable
        resp = CLIENT.send(req,callable)
        puts "time-lamb: #{(System.nanoTime - st)/1_000_000} ms"
      else
        resp = CLIENT.call(req)
        ret = resp.get_body.read_string
        puts "time-sync: #{(System.nanoTime - st)/1_000_000} ms"
      end
      ret
    end
    def self.put(opts,&blk)
    end
    def self.delete(opts,&blk)
    end
    def self.head(opts,&blk)
    end
    def self.options(opts,&blk)
    end

    private

    def self.process_headers(headers)
      return {} if headers.nil?
      headers.inject({}) do |res, (key, val)|
        if key.is_a? Symbol
          key = key.to_s.split(/_/).map { |w| w.capitalize }.join('-')
        end
        case key.upcase
        when 'CONTENT-TYPE'
          res[key] = mime_type(val.to_s)
        when 'ACCEPT'
          _vals = val.kind_of?(Array) ? val : val.to_s.split(',')
          res[key] = _vals.map { |ext| mime_type(ext.to_s.strip) }.join(', ')
        else
          res[key] = val.to_s
        end
        result
      end
    end

    def self.mime_type(ext)
      MIME_MAP[ext] || ext
    end
  end
end
