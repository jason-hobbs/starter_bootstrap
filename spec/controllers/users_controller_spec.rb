require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

#user = User.create!(user_attributes)
#project = Project.create!(project_attributes)

describe UsersController do
  
end
