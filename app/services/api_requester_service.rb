class ApiRequesterService
  require "uri"
  require "net/http"

  def self.get_current_weather
    url = URI("http://dataservice.accuweather.com/currentconditions/v1/#{ENV['CITY_KEY']}?apikey=#{ENV['API_KEY']}")

    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    response_class = JSON.parse(response.read_body).class

    if response_class == Array
      parsed_current_weather_json = JSON.parse(response.read_body)[0]

      parsed_current_weather_json['LocalObservationDateTime']
      parsed_current_weather_json['Temperature']['Metric']['Value']

      hash_output = { 
        time: parsed_current_weather_json['LocalObservationDateTime'],
        tempetrature_in_celsius: parsed_current_weather_json['Temperature']['Metric']['Value']
      }
    elsif response_class == Hash
      hash_output = { 
        message: JSON.parse(response.read_body)['Message']
      }
    end
  end

  def self.get_historical_max_weather
    new.create_temperature_array(Temperature.get_historical_weather).max
  end

  def self.get_historical_min_weather
    new.create_temperature_array(Temperature.get_historical_weather).min
  end

  def self.get_historical_avg_weather
    array_of_time_and_temperature = Temperature.get_historical_weather.map do |element| element['Temperature'] end
    
    if array_of_time_and_temperature.size != 0
      average_value = array_of_time_and_temperature.sum / array_of_time_and_temperature.size.to_f
    else
      message = "There is no input data"
    end
  end

  def self.get_temperature_by_timestamp(timestamp)
    data = Temperature.find_by(epoch_time: timestamp)
    if data.present?
      hash_output = { 
        local_observation_time: data.local_observation_time,
        temperature: data.temperature
      }
    else
      hash_output = { 
        error: 404
      }
    end
  end

  def create_temperature_array(array_of_time_and_temperature)
    array_of_time_and_temperature = array_of_time_and_temperature.map do |element| element['Temperature'] end
  end
end
