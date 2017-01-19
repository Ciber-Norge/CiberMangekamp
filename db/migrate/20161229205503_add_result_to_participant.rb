class AddResultToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :rank, :integer, null: false, default: 0
    add_column :participants, :score, :string
    # SQL used to move data from results to participants
    # update participants
    # set rank = results.rank, score = results.score
    # from results where participants.id = results.participant_id;
  end
end
