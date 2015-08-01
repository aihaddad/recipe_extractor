require 'spec_helper'

describe RecipeExtractor::Extractor do

  before :all do
    @extractor = RecipeExtractor::Extractor.new url: 'http://tinyw.in/pg42'
  end

  it {expect(@extractor).to respond_to :extracts_ingredients?}
  it {expect(@extractor).to respond_to :extracts_directions?}
  it {expect(@extractor).to respond_to :extract_ingredients}
  it {expect(@extractor).to respond_to :extract_directions}

  describe 'ingredients' do

    context 'when extractable' do

      it 'signifies extractablity' do
        expect(@extractor.extracts_ingredients?).to be true
      end

      it 'responds with an ingredients Hash' do
        expect(@extractor.extract_ingredients).to be_an Array
      end

      it 'responds with correct ingredient information' do
        expect(@extractor.extract_ingredients).to \
                          be_any{|m|m =~ /ounce Porterhouse/}
      end
    end

    context 'when non-extractable' do

      before :all do
        @non_extractable = RecipeExtractor::Extractor.new(
                                                   url: 'http://tinyw.in/G1jH' )
      end

      it 'signifies non-extractablity' do
        expect(@non_extractable.extracts_ingredients?).to be false
      end

      it 'responds with nil' do
        expect(@non_extractable.extract_ingredients).to be nil
      end
    end
  end

  describe 'directions' do

    context 'when extractable' do

      it 'signifies extractablity' do
        expect(@extractor.extracts_directions?).to be true
      end

      it 'responds with an ingredients Hash' do
        expect(@extractor.extract_directions).to be_an Array
      end

      it 'responds with correct ingredient information' do
        expect(@extractor.extract_directions).to \
                          be_any{|m|m =~ /Season the meat/}
      end
    end

    context 'when non-extractable' do

      before :all do
        @non_extractable = RecipeExtractor::Extractor.new(
                                                   url: 'http://tinyw.in/KyGp' )
      end

      it 'signifies non-extractablity' do
        expect(@non_extractable.extracts_directions?).to be false
      end

      it 'responds with nil' do
        expect(@non_extractable.extract_directions).to be nil
      end
    end
  end
end
