require 'net/http'
require 'uri'
require 'json'

class CatApi

  TOKEN = 'c4826c41-cc56-4d51-b900-d928f7ba404f'
  URL = "https://api.thecatapi.com/v1/images/search"

  public
  def get_url_image()
    content = get_content()
    json = JSON.parse(content)
    return json[0]["url"]
  end

  private
  def get_content()

    uri = URI.parse(URL)
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field('x-api-key', TOKEN)
    resp = http.request(request)
    return resp.body.to_s
  end
end

