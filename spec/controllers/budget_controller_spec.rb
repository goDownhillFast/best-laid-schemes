require 'spec_helper'

describe BudgetController do
  let(:calendar_data) do
    file = File.read('spec/support/test_calendar_data.json')
    JSON.parse(file)
  end
  before {allow(controller).to receive(:get_calendar_data).and_return(calendar_data)}
  describe "#calendar_data" do
    it "works" do
      expect(controller.send(:calendar_data)).to eq(calendar_data)
    end
  end
end