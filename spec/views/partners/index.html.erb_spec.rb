require 'spec_helper'

describe "partners/index" do
  before(:each) do
    assign(:partners, [
      stub_model(Partner,
        :name => "Name",
        :url => "Url",
        :status => "",
        :email => "Email",
        :street => "Street",
        :city => "City",
        :phone => ""
      ),
      stub_model(Partner,
        :name => "Name",
        :url => "Url",
        :status => "",
        :email => "Email",
        :street => "Street",
        :city => "City",
        :phone => ""
      )
    ])
  end

  it "renders a list of partners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
