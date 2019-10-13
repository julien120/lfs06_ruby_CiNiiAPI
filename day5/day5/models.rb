require 'bundler/setup'
Bundler.require

if development?
   ActiveRecord::Base.establish_connection('sqlite3:db/development.db')
end


class History < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :tags
end

class Category < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :tags, through: :middle
  #validates :body,
    #presence: true
end

class Tag < ActiveRecord::Base
  has_many :posts, through: :middle
  belongs_to :user
  validates :body
end


#中間テーブルは両者に所属している
class Middle < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
end