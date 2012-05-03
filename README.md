# SpreeAustralianMerchant

Several times I have battled with the Spree configuration to setup a shop for an Australian merchant.

This extension provides a rake task for quick configuration of GST, adds an Australian zone, and inserts the Asutralian states and territories.


## Example

Add it to your Gemfile

    gem 'spree_australian_merchant', :git => 'git@github.com:msharp/spree-australian-merchant.git'

Then run `bundle install`.

You will now have a rake task available

    bundle exec rake spree:australian_merchant:configure

## Testing

Not yet.

## Todo

Some view overrides which show the component on the sale which is GST


