require 'spec_helper'

describe "partners/edit" do
  before(:each) do
    @partner = assign(:partner, stub_model(Partner,
      :name => "MyString",
      :url => "MyString",
      :status => "",
      :email => "MyString",
      :street => "MyString",
      :city => "MyString",
      :phone => ""
    ))
  end

  it "renders the edit partner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => partners_path(@partner), :method => "post" do
      assert_select "input#partner_name", :name => "partner[name]"
      assert_select "input#partner_url", :name => "partner[url]"
      assert_select "input#partner_status", :name => "partner[status]"
      assert_select "input#partner_email", :name => "partner[email]"
      assert_select "input#partner_street", :name => "partner[street]"
      assert_select "input#partner_city", :name => "partner[city]"
      assert_select "input#partner_phone", :name => "partner[phone]"
    end
  end
end
