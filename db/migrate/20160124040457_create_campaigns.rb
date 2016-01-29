class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :created_by
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :end_payment_at
      t.datetime :end_instalation_at

      t.timestamps null: false
    end
  end
end
