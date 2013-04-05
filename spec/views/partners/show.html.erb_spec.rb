require 'spec_helper'

describe "partners/show" do
  before(:each) do
    @partner = assign(:partner, stub_model(Partner,
      :name => "Name",
      :url => "Url",
      :status => "",
      :email => "Email",
      :street => "Street",
      :city => "City",
      :phone => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(//)
    rendered.should match(/Email/)
    rendered.should match(/Street/)
    rendered.should match(/City/)
    rendered.should match(//)
  end
end
