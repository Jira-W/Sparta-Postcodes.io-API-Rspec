require 'httparty'
require 'json'

class Postcodesio
  include HTTParty

  attr_accessor :postcode, :postcodes_arr

  def initialize(postcode, postcodes_arr)
    @postcode, @postcodes_arr = postcode, postcodes_arr
  end

  base_uri 'https://api.postcodes.io'

  def remove_space(a)
    x = a.gsub(' ','')
  end

  def get_single_postcode
    JSON.parse(self.class.get("/postcodes/#{postcode}").body)
  end
  def get_single_post_status
    a = JSON.parse(self.class.get("/postcodes/#{postcode}").body)
    a["status"]
  end

  def get_single_post_attributes(key, value)
    a =  JSON.parse(self.class.get("/postcodes/#{postcode}").body)
    a["#{key}"]["#{value}"]
  end

  def get_multiple_postcodes
    a = JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_arr}).body)
    a
  end

  def get_multiple_postcodes_status
    a = JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_arr}).body)
    a["status"]
  end

  def get_multiple_postcodes_query_first
    a = JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_arr}).body)
    a["result"][0]["query"]
  end

  def get_multiple_postcodes_query_second
    a = JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_arr}).body)
    a["result"][1]["query"]
  end

  # method for getting attributes for first postcode in the array
  def get_multi_post_attributes_1(key, value)
    a =  JSON.parse(self.class.post('/postcodes', body:{ "postcodes": postcodes_arr}).body)
      a["#{key}"][0]["#{key}"]["#{value}"]
  end
  # method for getting attributes for second postcode in the array
  def get_multi_post_attributes_2(key, value)
    a =  JSON.parse(self.class.post('/postcodes', body:{ "postcodes": postcodes_arr}).body)
      a["#{key}"][1]["#{key}"]["#{value}"]
  end
end

t = Postcodesio.new('w93pt', ['w93pt','nw88sy'])
p t.remove_space(t.get_single_post_attributes('result', 'postcode'))
