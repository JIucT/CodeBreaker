require 'spec_helper'
require 'rspec/collection_matchers'

module Codebreaker
  describe Game do
    let(:game) {Game.new}
    before(:each) {game.start}
    
    context "#start" do
      it "should generate secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).numbers
      end
    end
    
    context "#im_feeling_lucky" do
      it "should return correct answer" do
        game.instance_variable_set(:@secret_code, [3,3,6,2,])
        
        expect(game.im_feeling_lucky("4422")).to eq('+')
        expect(game.im_feeling_lucky("3444")).to eq('+')
        expect(game.im_feeling_lucky("3443")).to eq('+-')
        expect(game.im_feeling_lucky("4433")).to eq('--')
        expect(game.im_feeling_lucky("4333")).to eq('+-')
        expect(game.im_feeling_lucky("3333")).to eq('++')
        expect(game.im_feeling_lucky("3233")).to eq('+--')
        expect(game.im_feeling_lucky("5553")).to eq('-')
      end

      it "should return true if player wins" do
        game.instance_variable_set(:@secret_code, [1,2,3,4])
        expect(game.im_feeling_lucky("1234")).to eq(true)
      end      

      it "should return false if player loose" do
        game.instance_variable_set(:@secret_code, [1,2,3,4])
        expect(game.im_feeling_lucky("5555")).to eq(false)
      end            
    end

    context "#hint" do
      it "should return string with one digit of @secret_code" do
        game.instance_variable_set(:@secret_code, [1,1,1,1])
        expect(game.hint).to eq(1)
      end 
    end
  end
end