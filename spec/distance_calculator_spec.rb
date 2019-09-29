require 'distance_calculator'

class DummyClass
  include DistanceCalculator
end

RSpec.describe DistanceCalculator, "#convert_to_radians" do
  let(:subject) { DummyClass.new }

  context "given valid arguments" do
    it "returns degrees in radians" do
      expect(subject.convert_to_radians(42)).to eq 0.733038
    end
  end

  context "given invalid arguments" do
    it "throws error when given string" do
      expect { subject.convert_to_radians('test') }.to raise_error(NoMethodError)
    end

    it "throws error when given nil" do
      expect { subject.convert_to_radians(nil) }.to raise_error(NoMethodError)
    end
  end
end

RSpec.describe DistanceCalculator, "#calculate_distance_between" do
  let(:subject) { DummyClass.new }

  context "given valid arguments" do
    it "returns distance between dublin and another point" do
      lat = 0.932987655533
      long = -0.108749354
      expect(subject.calculate_distance_between(long, lat)).to eq 13.109199
    end
  end

  context "given invalid arguments" do
    it "throws error when given string" do
      expect { subject.calculate_distance_between('not a longitude', 'not a latitude') }.to raise_error(TypeError)
    end

    it "throws error when given nil" do
      expect { subject.calculate_distance_between('not a longitude', 'not a latitude') }.to raise_error(TypeError)
    end
  end
end
