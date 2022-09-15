class Task < ApplicationRecord
    default_scope { order(created_at: :desc) }
    attr_accessor :file_input
end
