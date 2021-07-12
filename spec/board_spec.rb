require_relative "../lib/board"
require_relative "../lib/player"

describe Board do
  let(:player_dummy) { instance_double(Player, mark: "⚪") }
  describe "#initialize" do

    context "start with empty board" do
      subject(:board_init) { described_class.new } 

      it "__ is empty " do
        expect(subject.cells.flatten).to all(eq "__")
      end
    end

    context "start with 2 players" do
      it "has player black and white" do
        player_black = subject.instance_variable_get(:@player_black)
        player_white = subject.instance_variable_get(:@player_white)
        expect(player_black).not_to be_nil
        expect(player_white).not_to be_nil
      end
    end
  end

  describe "#play_game" do
    before do
      allow(subject).to receive(:puts)
      allow(subject).to receive(:play_turns)
    end
    
    context "game start with message" do
      it "returns message" do
        expect(subject).to receive(:puts).once
        subject.play_game
      end
    end

    context "start play_turns" do
      it "sends message to play_turns" do
        expect(subject).to receive(:play_turns).once
        subject.play_game
      end
    end
  end

  describe "#play_turns" do
    let(:player_turns) { instance_double(Player) }

    context "game_over true" do
      before do
        allow(subject).to receive(:game_over?).and_return(true)
        allow(subject).to receive(:puts)
      end
  
      it "return the loop if game_over?" do
        expect(subject).to receive(:player_input)
        subject.play_turns
      end
    end
    context " when game_over false, then true" do
      before do
        allow(subject).to receive(:game_over?).and_return(false, true)
        allow(subject).to receive(:puts)
      end

      it "loops twice" do
        expect(subject).to receive(:player_input).twice
        subject.play_turns
      end
    end
    context "when game board is full" do
      before do
        allow(subject).to receive(:full?).and_return(false, true)
        allow(subject).to receive(:player_input)
        
        
      end
      it "be game over" do
        expect(subject).to receive(:full?).twice
        expect(subject).to receive(:puts).with("It's a draw!").once

        subject.play_turns
        
      end
    end
  end

  describe "#player_input" do
    let(:player_double) { instance_double(Player) }
    
    context "input is always valid so break loop" do
      before do
        allow(player_double).to receive(:input).and_return(5)
        allow(subject).to receive(:mark_cell!)
        allow(subject).to receive(:print)
      end
      it "returns" do
        expect(subject).to receive(:mark_cell!).once
        subject.player_input(player_double)
      end
    end
  end

  describe "#mark_cell!" do
    context "when is called" do
     
      before do
        
      end
      it "returns cells with marked cells" do
        cells = subject.instance_variable_get(:@cells)
        expect { subject.mark_cell!(2, player_dummy) }.to change { cells }
  
      end
    end
  end

  describe "#valid_colum?" do
    context "when the column is full" do
      it "returns false" do
        6.times { subject.mark_cell!(2, player_dummy) } 
        expect(subject.valid_column?(2)).to be false
      end
    end

    context "when the column is not full" do
      it "returns false" do
        5.times { subject.mark_cell!(2, player_dummy) } 
        expect(subject.valid_column?(2)).to be true
      end
    end
    
  end

  describe "#game_over?" do
    context "when game has a horizontal line" do
      before do
        allow(subject).to receive(:horizontal?).and_return(true)
      end
      it "be game over" do
        expect(subject).to be_game_over
      end
      
    end
    context "when game has a vertical line" do
      before do
        allow(subject).to receive(:vertical?).and_return(true)
      end
      it "be game over" do
        expect(subject).to be_game_over
      end
      
    end
    context "when game has a diagonal line" do
      before do
        allow(subject).to receive(:upward_diagonal?).and_return(true)
        allow(subject).to receive(:downward_diagona?).and_return(true)
      end
      it "be game over" do
        expect(subject).to receive(:downward_diagonal?).once
        expect(subject).to receive(:upward_diagonal?).once
        subject.game_over?
        
      end
    end
  end
end #endfile