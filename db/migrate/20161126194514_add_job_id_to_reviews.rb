class AddJobIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :job_id, :integer
  end
end
