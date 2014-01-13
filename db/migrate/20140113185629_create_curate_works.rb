class CreateCurateWorks < ActiveRecord::Migration
  def change
    create_table :curate_works do |t|
      t.string :title

      t.timestamps
    end
  end
end
