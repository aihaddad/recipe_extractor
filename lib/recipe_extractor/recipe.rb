module RecipeExtractor
  # pending:
  # detect if NOT a text recipe link
  # detect if dessert, salad, vegetarian, vegan or includes meat
  # detect if video
  class Recipe
    # This class aims to extract food recipe meta and body information from
    # fairly well-written HTML5 pages & present them in machine-friendly format.
    def initialize url
      page    = MetaInspector.new url
      @parsed = page.parsed

      @url       = page.url
      ary_host   = page.host.split('.')
      dots       = ary_host.size - 1
      dots > 1 ? @host = ary_host[1].capitalize : @host = ary_host[0].capitalize

      @description = page.description
      @favicon     = page.images.favicon

      @main_image  = page.images.best
      # Better algorithm needed to extract a sorted array of recipe images only
      # for better user experience
      @images      = page.images.with_size.select do |img|
        img[1] > 150 or img[2] > 150 and \
        (img[1] - img[2]).abs.to_f / (img[1] + img[2]).to_f < 0.5 and \
        img[0] =~ /#{@host}/i
      end.map do |img|
        img[0]
      end
    end

    # Basic meta information to be stored in local DB
    def meta
      {
        source:      @host,
        favicon:     @favicon,
        url:         @url,
        title:       title,
        description: @description,
        keywords:    keywords,
        image_url:   @main_image,
        extractable: extractable?
      }
    end

    # Recipe body presented on-the-fly
    def body
      if extractable?
        return {
          ingredients: @recipe.extract_ingredients,
          directions:  @recipe.extract_directions,
          images:      @images
        }
      end
      return nil
    end

    private

      def pismo
        @pismo ||= Pismo::Document.new @url
        return @pismo
      end

      def title
        pismo.title
      end

      def keywords
        pismo.keywords.select do |word|
          word[0].length > 2 and word[1] > 4
        end.map do |word|
          word[0]
        end.join(', ')
      end

      def extractable?
        @recipe = Extractor.new parsed: @parsed, url: @url
        @recipe.extracts_ingredients? and @recipe.extracts_directions?
      end
  end
end
