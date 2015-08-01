module RecipeExtractor
  INGREDIENTS_SNIPPET  = "(//div|//section)[contains(@*, 'ngred')]"
  INGREDIENTS_ELEMENTS = ['.//li', './/p', './/div',
                          './/input[type=checkbox]', '*/span']
  DIRECTIONS_SNIPPETS  = ['irectio', 'repar', 'nstru', 'roced',
                         'ethod', 'ow-to', 'ook', 'akin']
  DIRECTIONS_ELEMENTS  = ['p', 'li', 'div']
  RECIPE_REGEX         = /org\/Recipe/i
end
