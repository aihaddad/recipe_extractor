require 'spec_helper'

describe RecipeExtractor::Recipe do

  before :all do
    @recipe = RecipeExtractor::Recipe.new 'http://tinyw.in/pg42'
  end

  it {expect(@recipe).to respond_to :meta}
  it {expect(@recipe).to respond_to :body}

  it 'returns a Hash of meta information' do
    expect(@recipe.meta).to be_a Hash
  end

  it 'returns meta information with necessary keys' do
    expect(@recipe.meta).to include :source, :favicon, :url, :title,
                                    :description, :keywords, :image_url, :extractable
  end

  it 'returns correct meta information' do
    expect(@recipe.meta[:source]).to eq 'Foodnetwork'
    expect(@recipe.meta[:title]).to eq 'El Paseo Porterhouse Steak'
  end

  context 'when recipe is extractable' do

    it 'signifies extactability' do
      expect(@recipe.meta[:extractable]).to be true
    end

    it 'extracts recipe body' do
      expect(@recipe.body).not_to be nil
    end

    it 'returns a Hash of body information' do
      expect(@recipe.body).to be_a Hash
    end

    it 'returns body with recipe keys' do
      expect(@recipe.body).to include :ingredients, :directions, :images
    end

    it 'returns correct ingedients' do
      expect(@recipe.body[:ingredients]).to be_any{|m|m =~ /ounce Porterhouse/}
    end

    it 'returns correct directions' do
      expect(@recipe.body[:directions]).to be_any{|m|m =~ /Season the meat/}
    end
  end

  context 'when recipe is not extractable' do

    before :all do
      @non_extractable = RecipeExtractor::Recipe.new 'http://tinyw.in/KyGp'
    end

    it 'signifies non-extactability' do
      expect(@non_extractable.meta[:extractable]).to be false
    end

    it 'returns nil for body' do
      expect(@non_extractable.body).to be nil
    end
  end
end
