class CreateDeployments < ActiveRecord::Migration[7.0]
  def change
    create_table :deployments do |t|
      t.references :prompt, null: false, foreign_key: true
      t.references :environment, null: false, foreign_key: true
      t.boolean :is_static, default: false, null: false

      t.timestamps
    end
  end
end
