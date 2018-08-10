require "qlite/version"

module Qlite
  require 'net/http'
  require 'json'

  def self.fetch_epochs qubic_id
      pp "RUN Qlite::fetch_epochs"
      # TODO: Refacctor
      uri = URI('http://192.168.0.3:17733/')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
      req.body = {command: 'fetch_epoch', 'qubic id': qubic_id, 'epoch index': 0, 'epoch index max': 100}.to_json
      res = http.request(req)
      return JSON.parse(res.body)
  rescue => e
      puts "failed #{e}"
  end

  def self.qubic_read qubic_id
    pp "RUN Qlite::qubic_read"
    # TODO: Refacctor
    uri = URI('http://192.168.0.3:17733/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
    req.body = {command: 'qubic_read', 'qubic id': qubic_id}.to_json
    res = http.request(req)
    return JSON.parse(res.body)
  rescue => e
    puts "failed #{e}"
  end


  def self.iam_list
    pp "RUN Qlite::iam_list"
    # TODO: Refacctor
    uri = URI('http://192.168.0.3:17733/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
    req.body = {command: 'iam_list'}.to_json
    res = http.request(req)
    return JSON.parse(res.body)
  rescue => e
    puts "failed #{e}"
  end

  def self.iam_read(iam_id, index)
    pp "RUN Qlite::iam_read"
    # TODO: Refacctor
    uri = URI('http://192.168.0.3:17733/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
    req.body = {command: 'iam_read', 'iam id': iam_id, 'index': index}.to_json
    res = http.request(req)
    return JSON.parse(res.body)
  rescue => e
    puts "failed #{e}"
  end

  def self.iam_write(iam_id, index, message)
    pp "RUN Qlite::iam_write"
    # TODO: Refacctor
    uri = URI('http://192.168.0.3:17733/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
    req.body = {command: 'iam_write', 'index': index, 'iam stream handle': iam_id, 'message': message}.to_json
    res = http.request(req)
    return JSON.parse(res.body)
  rescue => e
    puts "failed #{e}"
  end

end
