class Temperature < ApplicationRecord

  def self.get_historical_weather
    array_of_time_and_temperature = Temperature.order(local_observation_time: :desc).limit(24).map do |t| 
      {
        'LocalObservationDateTime' => t.local_observation_time,
        'Temperature' => t.temperature,
        'EpochTime' => t.epoch_time
      }
    end

    array_of_time_and_temperature
  end
end
