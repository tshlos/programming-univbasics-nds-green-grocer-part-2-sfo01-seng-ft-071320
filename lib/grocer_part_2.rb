require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  new_cart = []
  cart.each do |item|
    coupon = coupons.find { |coupon| item[:item] == coupon[:item] }

    if !coupon 
      new_cart.push(item)
    else 
      # check coupon and subtract the number of discounted items from total items
      remaining_count = item[:count] - coupon[:num]
      

      # push discounted coupon into new cart 
      discounted_hash = {
        :item => "#{item[:item]} W/COUPON", 
        :price => coupon[:cost] / coupon[:num],
        :clearance => item[:clearance],
        :count => item[:count] > coupon[:num] ? coupon[:num] : item[:count] 
      }
      new_cart.push(discounted_hash)
      
      if remaining_count >= 0
        # push items that are left into new cart
        no_discount = {
          :item => item[:item],
          :price => item[:price],
          :clearance => item[:clearance],
          :count => remaining_count
        }
        new_cart.push(no_discount)
      end
    end
  end
  new_cart
end
# if number of coupons is less than number of item
# number of avocados = 5, number of coupons 1 

# if number of coupons is greater than number of item
# number of avocados = 1, number of coupons 5

# if number of coupons is equal to number of item
# number of avocados = 5, number of coupons 5

# clearance 






def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = (item[:price] *0.8).round(2)
    end
  end
  cart
end






def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  
  grand_total = 0
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  clearance_items = apply_clearance(cart_with_coupons)

  clearance_items.each do |hash|
    total = hash[:price] * hash[:count]
    grand_total += total
  end
  grand_total > 100 ? grand_total * 0.9 : grand_total
end

