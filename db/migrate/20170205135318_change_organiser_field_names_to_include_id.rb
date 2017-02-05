class ChangeOrganiserFieldNamesToIncludeId < ActiveRecord::Migration
  def change
  	rename_column :events, :organiser, :organiser_id
  	rename_column :events, :second_organiser, :second_organiser_id
  end
end
