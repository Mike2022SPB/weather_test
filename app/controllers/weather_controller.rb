class WeatherController < ApplicationController
  def current
    temperature = ApiRequesterService.get_current_weather

    render json: { weather: temperature }
  end

  def historical
    array_of_historical_data = Temperature.get_historical_weather

    render json: { historical_data: array_of_historical_data }
  end

  def historical_max
    historical_max_temperature = ApiRequesterService.get_historical_max_weather

    render json: { historical_max_temperature: historical_max_temperature }
  end

  def historical_min
    historical_min_temperature = ApiRequesterService.get_historical_min_weather

    render json: { historical_min_temperature: historical_min_temperature }
  end

  def historical_avg
    historical_avg_temperature = ApiRequesterService.get_historical_avg_weather

    render json: { historical_avg_temperature: historical_avg_temperature }
  end

  def by_time
    temperature_by_timestamp = ApiRequesterService.get_temperature_by_timestamp(params[:timestamp].to_i)

    render json: { temperature_by_timestamp: temperature_by_timestamp }
  end

  def health
    render json: { health: "OK" }
  end
end
