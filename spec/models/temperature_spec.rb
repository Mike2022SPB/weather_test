require 'rails_helper'

RSpec.describe Temperature, type: :model do
  it { should have_db_column(:local_observation_time) }
  it { should have_db_column(:temperature) }
  it { should have_db_column(:epoch_time) }

  describe '.get_historical_weather' do
    it 'returns an array of time and temperature data' do
      temperature1 = FactoryBot.create(:temperature, local_observation_time: "2023-12-14T14:58:00+04:00", temperature: 15.2, epoch_time: 1702551480)
      temperature2 = FactoryBot.create(:temperature, local_observation_time: "2023-12-14T13:57:00+04:00", temperature: 14.1, epoch_time: 1702547820)

      result = Temperature.get_historical_weather

      expect(result.length).to eq(2)

      expect(result[0]['LocalObservationDateTime']).to eq(temperature1.local_observation_time)
      expect(result[0]['Temperature']).to eq(temperature1.temperature)
      expect(result[0]['EpochTime']).to eq(temperature1.epoch_time)

      expect(result[1]['LocalObservationDateTime']).to eq(temperature2.local_observation_time)
      expect(result[1]['Temperature']).to eq(temperature2.temperature)
      expect(result[1]['EpochTime']).to eq(temperature2.epoch_time)
    end
  end
end
