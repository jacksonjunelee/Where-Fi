require 'rails_helper'

describe User do

	it { is_expected.to validate_presence_of :username }
	it { is_expected.to validate_uniqueness_of :username }
	it { is_expected.to validate_presence_of :first_name }
	it { is_expected.to validate_presence_of :last_name }
	it { is_expected.to validate_presence_of :password }

	let(:hari) {new_user = User.new( username: "superman",
	first_name: "hari",
	last_name: "Doe",
	password: "hunter2",
	password_confirmation: "hunter2")}


	it "is valid with a username, first_name, last_name and password" do
		expect(hari).to be_valid
	end


end


#getting errors unexpectedly on the shoulda matchers
