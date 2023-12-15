require "uri"
require "net/http"

# Делаем запрос на получение исторических данных и сохраняем в бд

url = URI("http://dataservice.accuweather.com/currentconditions/v1/#{ENV['CITY_KEY']}/historical/24?apikey=#{ENV['API_KEY']}&language=en-us")

http = Net::HTTP.new(url.host, url.port);
request = Net::HTTP::Get.new(url)

response = http.request(request)

parsed_historical_weather_json = JSON.parse(response.read_body)

# Проверка на случай, если кол-во запросов к API закончилось
# Т.к. в случае ошибки прилетает Hash, то проверяем на его наличие
# При его наличии заполняем заранее полученными данными вручную, если нет то обрабатываем ответ от сервера

if parsed_historical_weather_json.class == Hash
  parsed_historical_weather_json = [{"LocalObservationDateTime"=>"2023-12-14T14:58:00+04:00", "EpochTime"=>1702551480, "WeatherText"=>"Partly sunny", "WeatherIcon"=>3, "HasPrecipitation"=>false, "PrecipitationType"=>nil, "IsDayTime"=>true, "Temperature"=>{"Metric"=>{"Value"=>15.2, "Unit"=>"C", "UnitType"=>17}, "Imperial"=>{"Value"=>59.0, "Unit"=>"F", "UnitType"=>18}}, "MobileLink"=>"http://www.accuweather.com/en/ge/batumi/13/current-weather/13?lang=en-us", "Link"=>"http://www.accuweather.com/en/ge/batumi/13/current-weather/13?lang=en-us"},{"LocalObservationDateTime"=>"2023-12-14T13:57:00+04:00", "EpochTime"=>1702547820, "WeatherText"=>"Mostly sunny", "WeatherIcon"=>2, "HasPrecipitation"=>false, "PrecipitationType"=>nil, "IsDayTime"=>true, "Temperature"=>{"Metric"=>{"Value"=>14.1, "Unit"=>"C", "UnitType"=>17}, "Imperial"=>{"Value"=>57.0, "Unit"=>"F", "UnitType"=>18}}, "MobileLink"=>"http://www.accuweather.com/en/ge/batumi/13/current-weather/13?lang=en-us", "Link"=>"http://www.accuweather.com/en/ge/batumi/13/current-weather/13?lang=en-us"}]
end

parsed_historical_weather_json.each do |temperature_data|
  temperature = Temperature.find_or_create_by(epoch_time: temperature_data['EpochTime']) do |t|
    t.local_observation_time = temperature_data['LocalObservationDateTime']
    t.temperature = temperature_data['Temperature']['Metric']['Value']

    puts "#{temperature_data['LocalObservationDateTime']}, #{temperature_data['EpochTime']}, #{temperature_data['Temperature']['Metric']['Value']} record created"
  end
end
