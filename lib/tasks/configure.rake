namespace :spree do
  namespace :australian_merchant do
    desc "Set up basic configuration for Australia-based merchant"
    task :configure => :environment do
      #SpreeAustralianMerchant::Engine.load_seed
      # create basic AU configuration
      oz = Spree::Country.find_by_iso('AU')

      puts "Making Australia the default country"
      Spree::Config.default_country_id = oz.id

      # add states unless already present
      unless Spree::State.find_by_country_id(oz.id)
        puts "Creating Australian states"
        oz.states << Spree::State.create(:name => 'Australian Capital Territory', :abbr => 'ACT')
        oz.states << Spree::State.create(:name => 'New South Wales', :abbr => 'NSW')
        oz.states << Spree::State.create(:name => 'Victoria', :abbr => 'VIC')
        oz.states << Spree::State.create(:name => 'Tasmania', :abbr => 'TAS')
        oz.states << Spree::State.create(:name => 'Queensland', :abbr => 'QLD')
        oz.states << Spree::State.create(:name => 'South Australia', :abbr => 'SA')
        oz.states << Spree::State.create(:name => 'Western Australia', :abbr => 'WA')
        oz.states << Spree::State.create(:name => 'Northern Territory', :abbr => 'NT')
      end

      tax_cat =  Spree::TaxCategory.find_by_name('GST')
      unless tax_cat
        puts "Creating GST as the default tax category"
        Spree::TaxCategory.all.each{|tc|tc.destroy}
        tax_cat = Spree::TaxCategory.create(:name => 'GST', :description => 'Goods and Services Tax', :is_default => true)
      end

      unless Spree::Zone.find_by_name('AU')
        puts "Configuring AU zone for tax and shipping"
        zone = Spree::Zone.create!(:name => 'AU', :description => 'Australia', :default_tax => true)
        Spree::ZoneMember.create!(:zone_id => zone.id, :zoneable_id => oz.id, :zoneable_type => 'Spree::Country')

        tax_calc = Spree::Calculator::FlatRate.new
        Spree::TaxRate.create!(:zone_id => zone.id, :amount => 0.10, :tax_category_id => tax_cat.id, :included_in_price => true, :calculator => tax_calc)
      end

      Spree::Config.shipment_inc_vat = false

      puts "Complete: you will need to configure a shipping method to enable ordering"

    end
  end
end
