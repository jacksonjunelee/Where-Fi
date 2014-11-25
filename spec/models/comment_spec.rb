require 'rails_helper'

describe Comment do 
	it { is_expected.to validate_presence_of :content }
end