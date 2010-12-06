module JrxlightWeb

  require File.join('lib','xlightweb.jar')
  require 'java'

  import org.xlightweb.client.HttpClient
  import org.xlightweb.GetRequest
  import org.xlightweb.PostRequest
  import org.xlightweb.HttpResponse

  import org.xlightweb.HttpUtils

  import java.lang.System

  %w(request response).each do |f|
    require File.join('lib',f)
  end

  def self.get(url, headers={}, callable=nil, &block)
    Request.get(:url => url, :headers => headers, :callable=>callable, &block)
  end

  def self.post(url, payload, headers={}, &block)
    Request.post(:url => url, :payload => payload, :headers => headers, &block)
  end

  def self.put(url, payload, headers={}, &block)
    Request.put(:url => url, :payload => payload, :headers => headers, &block)
  end

  def self.delete(url, headers={}, &block)
    Request.delete(:url => url, :headers => headers, &block)
  end

  def self.head(url, headers={}, &block)
    Request.head(:url => url, :headers => headers, &block)
  end

  def self.options(url, headers={}, &block)
    Request.options(:url => url, :headers => headers, &block)
  end

end
