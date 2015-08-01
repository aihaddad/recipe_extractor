# RecipeExtractor

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'recipe_extractor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install recipe_extractor

## Usage

```ruby
# instantiate a new recipe with its URL
recipe = RecipeExtractor::Recipe.new 'http://tinyw.in/pg42'

recipe.meta
# =>{source: "Foodnetwork",
# favicon: "http://www.foodnetwork.com/etc/designs/food/clientlib/img/favicon.ico",
# url: "http://www.foodnetwork.com/recipes/tyler-florence/el-paseo-porterhouse-steak-recipe.html",
# title: "El Paseo Porterhouse Steak",
# description: "Get this all-star, easy-to-follow El Paseo Porterhouse Steak recipe from Tyler Florence.",
# keywords: "steak, porterhouse, butter, paseo, place",
# image_url: => "http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2013/1/30/0/BX0802H_el-paseo-porterhouse-steak-recipe_s4x3.jpg",
# => extractable: true}

recipe.body
# => {ingredients: ["52 ounce Porterhouse 28 day dry-aged Masami steak", "California solar salt/ sea salt", "Clarified butter", "Fresh sage leaves", "Fresh thyme", "2 bulbs of garlic", "Freshly ground black pepper", "Shallot butter, for serving"],
# directions: ["Directions Watch how to make this recipe Season the meat before broiling: liberally rub salt over both sides of the steak.Place the steak directly onto the broiler, no extra fat is needed, at 1200 degrees for 20 minutes.After 10 minutes turn the steaks over and return to the broiler: they only need turning once.After 20 minutes, remove the steak from the broiler.Place the steak in the clarified butter, sage, thyme and garlic mixture, and leave to rest for 10 minutes, basting the top with butter.Remove the steak from the clarified butter and place on kitchen roll to remove any excess.To serve, separate the fillet and strip sirloin from the bone and slice. Place the T-bone in the centre of the plate and reassemble the steak, with the sliced sirloin to the left and sliced fillet to the right. Sprinkle over freshly ground black pepper to taste. Place the shallot butter on top of each steak, and garnish with half a garlic bulb taken from the clarified butter, a sprig of thyme and a generous drizzle of garlic butter. 2012, Tyler Florence, All Rights Reserved CATEGORIES: Beef Main Dish Steak View All"],
# images: ["http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2013/1/30/0/BX0802H_el-paseo-porterhouse-steak-recipe_s4x3.jpg.rend.sni12col.landscape.jpeg", "http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2015/6/22/0/FNStore-SummerSale.jpg.rend.sni5col.landscape.jpeg"]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/recipe_extractor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
