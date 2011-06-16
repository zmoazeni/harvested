require 'spec_helper'

describe 'harvest expenses' do
  context 'categories' do
    it 'allows adding, updating and removing categories' do
      cassette("expense_category1") do
        category       = harvest.expense_categories.create(
          "name"       => "Mileage",
          "unit_price" => 100,
          "unit_name"  => "mile"
        )
        category.name.should == "Mileage"

        category.name = "Travel"
        category = harvest.expense_categories.update(category)
        category.name.should == "Travel"

        harvest.expense_categories.delete(category)
        harvest.expense_categories.all.size.should == 0
      end
    end
  end
  
  
  it "allows adding, updating, and removing expenses" do
    cassette("expenses2") do
      category       = harvest.expense_categories.create(
        "name"       => "Mileage",
        "unit_price" => 100,
        "unit_name"  => "mile"
      )

      client      = harvest.clients.create(
        "name"    => "Tom's Butcher",
        "details" => "Building API Widgets across the country"
      )

      project       = harvest.projects.create(
        "name"      => "Expensing Project",
        "active"    => true,
        "notes"     => "project to test the api",
        "client_id" => client.id
      )
      
      expense                 = harvest.expenses.create(
        "notes"               => "Drive to Chicago",
        "total_cost"          => 75.0,
        "spent_at"            => "12/28/2009",
        "expense_category_id" => category.id,
        "project_id"          => project.id
      )
      expense.notes.should == "Drive to Chicago"
      
      expense.notes = "Off to Chicago"
      expense = harvest.expenses.update(expense)
      expense.notes.should == "Off to Chicago"
      
      harvest.expenses.delete(expense)
      harvest.expenses.all("12/28/2009").size.should == 0
    end
  end
end
