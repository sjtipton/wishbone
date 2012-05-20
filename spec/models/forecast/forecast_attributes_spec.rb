require 'spec_helper'

describe Forecast do

  describe "attributes" do

    it { should respond_to(:title) }
    it { should respond_to(:user_id) }
    it { should respond_to(:prediction_id) }

    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:prediction_id) }
  end
end
