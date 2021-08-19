class Customer < ApplicationRecord
  belongs_to :employee, foreign_key: "support_rep_id"
end
