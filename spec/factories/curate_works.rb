# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :curate_work, :class => 'Curate::Work' do
    title "MyString"
  end
end
