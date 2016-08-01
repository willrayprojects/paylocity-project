  FactoryGirl.define do
    factory :employee do
      skip_create

      first_name SecureRandom.hex(10)
      last_name SecureRandom.hex(10)
      dependents 0

      base_salary 52000
      annual_benefits_cost 1000
      cost_per_dependent 500
      discount 0
    end
  end