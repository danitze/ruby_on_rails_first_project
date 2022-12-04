class Item < ApplicationRecord
  def get_mean_weight
    weight.quo amount
  end
end
