require 'rails_helper'

describe Location do 
	it { is_expected.to validate_presence_of :address}
	it { is_expected.to validate_presence_of :ssid}
	it { is_expected.to validate_presence_of :place_name}


	let(:valid_location) {new_location = Location.new(
		address: "506 Amsterdam Avenue NY, NY 10024",
		ssid: "Guest",
		place_name: "My Mommas house",
		boro: "SI",
		details: "Second floor gets best signal",
		lat: "42.9043",
		long: "-72.8394"
		)}

	it "is valid with address, ssid, and place_name" do 
		expect(valid_location).to be_valid
	end
end