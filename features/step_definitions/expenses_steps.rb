When 'I create an expense for the project "$1" with the category "$2" with the following:' do |project_name, category_name, table|
  project = Then %Q{there should be a project "#{project_name}"}
  category = Then %Q{there should be an expense category "#{category_name}"}
  
  expense = Harvest::Expense.new(table.rows_hash.merge("expense_category_id" => category.id, "project_id" => project.id))
  harvest_api.expenses.create(expense)
end

Then 'there should be an expense "$1" on "$2"' do |notes, date|
  expenses = harvest_api.expenses.all(date)
  expense = expenses.detect {|e| e.notes == notes}
  expense.should_not be_nil
  expense
end

Then 'there should not be an expense "$1" on "$2"' do |notes, date|
  expenses = harvest_api.expenses.all(date)
  expense = expenses.detect {|e| e.notes == notes}
  expense.should be_nil
end

When 'I delete the expense "$1" on "$2"' do |notes, date|
  expense = Then %Q{there should be an expense "#{notes}" on "#{date}"}
  id = harvest_api.expenses.delete(expense)
  expense.id.should == id
end

Then 'the expense "$1" on "$2" should have the following attributes:' do |notes, date, table|
  expense = Then %Q{there should be an expense "#{notes}" on "#{date}"}
  table.rows_hash.each do |key, value|
    expense.send(key).to_s.should == value
  end
end

When 'I update the expense "$1" on "$2" with the following:' do |notes, date, table|
  expense = Then %Q{there should be an expense "#{notes}" on "#{date}"}
  expense.attributes = table.rows_hash
  harvest_api.expenses.update(expense)
end

