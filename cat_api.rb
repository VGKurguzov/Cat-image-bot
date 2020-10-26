require 'net/http'
require 'uri'
require 'json'

class CatApi

  public
  def get_url_image()
    content = get_content()
    json = JSON.parse(content)
    return json[0]['url']
  end

  private
  def get_content()

    uri = URI.parse(ENV['URL_API'])
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field('x-api-key', ENV['TOKEN_API'])
    resp = http.request(request)
    return resp.body.to_s
  end
end

