class SetDefaultAvataToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :avatar, :string, default: "http://res.cloudinary.com/duq6yxlzy/image/upload/v1/development/ghaqanlp91lehqirmt1u"
  end
end
