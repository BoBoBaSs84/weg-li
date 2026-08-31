# frozen_string_literal: true

Fabricator(:blueprint) do
  name { Faker::Lorem.name }
  note { Faker::Lorem.sentence }
  flags { 2 }
  charge
  user
end
