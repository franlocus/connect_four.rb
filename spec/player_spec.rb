require_relative "../lib/player"

describe Player do
  describe "#input" do
    context "when player turn to input" do
      before do
        allow(subject).to receive(:gets).and_return("5\n")
      end

      it "input a column number" do
        expect(subject).to receive(:puts).once
        expect(subject.input).to be_between(1, 7).inclusive
      end
    end
  end
end