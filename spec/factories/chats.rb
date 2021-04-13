FactoryBot.define do
  factory :chat do
    message               { 'test' }
    
    association :user
    association :group
  end
end