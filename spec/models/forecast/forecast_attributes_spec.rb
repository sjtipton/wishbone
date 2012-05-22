require 'spec_helper'

describe Forecast do

  it { should have_many(:predictions) }
  it { should belong_to(:user) }

  describe "attributes" do

    it { should respond_to(:title) }
    it { should respond_to(:user_id) }

    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:user_id) }
  end
end
