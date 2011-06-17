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
        harvest.expense_categories.all.select{|e| e.name == "Travel" }.should == []
      end
    end
  end
  
  
  it "allows adding, updating, and removing expenses" do
    cassette("expenses2") do
      category       = harvest.expense_categories.create(
        "name"       => "Something Deductible",
        "unit_price" => 100,
        "unit_name"  => "deduction"
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
      harvest.expenses.all("12/28/2009").select {|e| e.notes == "Off to Chicago"}.should == []
    end
  end
end

# Copied from feature
# @wip
# Scenario: Attaching a receipt to an Expense
#   Given I am using the credentials from "./support/harvest_credentials.yml"
#   When I create an expense category with the following:
#   | name       | Mileage |
#   | unit_name  | Miles   |
#   | unit_price | 0.485   |
#   Then there should be an expense category "Mileage"
#   When I create a client with the following:
#   | name | Expense Client |
#   When I create a project for the client "Expense Client" with the following:
#   | name | Test Project |
#   When I create an expense for the project "Test Project" with the category "Mileage" with the following:
#   | notes      | Drive to Chicago |
#   | total_cost | 75.00            |
#   | spent_at   | 12/28/2009       |
#   Then there should be an expense "Drive to Chicago" on "12/28/2009"
#   When I attach the receipt "./support/fixtures/receipt.png" to the expense "Drive to Chicago" on "12/28/2009"
#   Then there should be a receipt "./support/fixtures/receipt.png" attached to the expense "Drive to Chicago" on "12/28/2009"

