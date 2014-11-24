require 'rails_helper'

describe Location do 
	it { is_expected.to validate_presence_of :ssid }
	it { is_expected.to validate_presence_of :place_name }


	let(:valid_location) { new_location = Location.create(
		address: nil,
		ssid: "Guest",
		place_name: "My Mommas house",
		boro: "SI",
		details: "Second floor gets best signal",
		latitude: "42.9043",
		longitude: "-72.8394"
		)}

	it "is valid ssid and place_name" do 
		expect(valid_location).to be_valid
	end
end