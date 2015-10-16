require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    search_url = 'https://maps.googleapis.com/maps/api/geocode/json?address='+ url_safe_street_address
    raw_data = open(search_url).read
    require 'json'
    parsed_data = JSON.parse(raw_data)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s
    search_url2 = 'https://api.forecast.io/forecast/81734857a2b9cb841340641557a2b504/'+lat+','+lng
    raw_data2 = open(search_url2).read
    require 'json'
    parsed_data2 = JSON.parse(raw_data2)


    @current_temperature =  parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
