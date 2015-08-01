module RecipeExtractor
  class Extractor
    # This class aims to parse recipe ingredients and directions information and
    # present them in machine-friendly format. It's done by checking if the page
    # has parsable microdata based on schema.org, & if not, targets HTML5 nodes
    # via CSS and XPATH, making it usable accross different languages.
    def initialize options
      @url     = options[:url]
      @parsed  = options[:parsed] || MetaInspector.new(@url).parsed
      open(@url) {|io| @raw = io.read}
      open(@url) {|f|  @doc = Mida::Document.new(f, @url)}
    end

    # On-the-fly extraction of ingredients preferrably with no saving in DB
    def extracts_ingredients?
      extract_ingredients ? true : false
    end

    def extract_ingredients
      if @raw =~ RECIPE_REGEX
        item = @doc.items.select do |i|
          i.type =~ RECIPE_REGEX
        end.first.properties
        if item.has_key? 'ingredients'
          return clean_text_list_from item['ingredients']
        elsif item.has_key? 'recipeIngredients'
          return clean_text_list_from item['recipeIngredients']
        elsif item.has_key? 'ingredient'
          return item['ingredient'].map do |i|
            "#{i.properties['amount'][0]} #{i.properties['name'][0]}".strip
          end
        end
      elsif ingredients
        begin
          [-1, -2, 0].each do |i|
            INGREDIENTS_ELEMENTS.each do |j|
              containers = text_list_from(ingredients[i].xpath(j))
              return containers if containers.size > 1 and \
                                   containers.all? {|s|s.length > 2}
            end
          end
        rescue
          return nil
        end
      end
      return nil
    end

    # On-the-fly extraction of directions preferrably with no saving in DB
    def extracts_directions?
      extract_directions ? true : false
    end

    def extract_directions
      if @raw =~ RECIPE_REGEX
        item = @doc.items.select do |i|
          i.type =~ RECIPE_REGEX
        end.first.properties
        if item.has_key? 'recipeInstructions'
          return clean_text_list_from item['recipeInstructions']
        elsif item.has_key? 'instructions'
          return clean_text_list_from item['instructions']
        elsif item.has_key? 'instruction'
          return item['instruction'].map do |i|
            "#{i.properties['amount'][0]} #{i.properties['name'][0]}".strip
          end
        end
      elsif directions
        begin
          [-1, 0].each do |i|
            DIRECTIONS_ELEMENTS.each do |j|
              containers = text_list_from(directions[i].css(j))
              return containers if containers.size > 1 and \
                                   containers.all? {|s|s.length >= 3}
            end
          end
        rescue
          return nil
        end
      end
      return nil
    end


    private

      def ingredients
        @parsed.xpath(INGREDIENTS_SNIPPET)
      end

      def directions
        DIRECTIONS_SNIPPETS.each do |s|
          divs = @parsed.css("section[class*='#{s}'], div[class*='#{s}']")
          if divs.blank? then \
             divs = @parsed.xpath("//*[contains(@*, '#{s}')]") end
          return divs if divs.size > 0
        end
        return nil
      end

      def text_list_from elements
        elements.map do |n|
          n.text.strip.gsub(/\s+/, ' ')
        end.reject(&:blank?)
      end

      def clean_text_list_from elements
        elements.map {|i|i.gsub(/\s+/, ' ').gsub(/(\<.+\>)/, '')}
      end
  end
end
