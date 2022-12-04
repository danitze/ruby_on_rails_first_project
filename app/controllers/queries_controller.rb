class QueriesController < ApplicationController
  def list
  end

  def a
    @item = item_differs_from_mean_less_than_0_3_kilos
  end

  def b
    @amount_more_2 = passengers_with_more_2_pieces_amount
    @amount_more_than_medium = passengers_with_more_than_mean_pieces_amount
  end

  def c
    @is_true = passengers_equal_amount_but_weight_differs_0_5_kilos?
  end

  def d
    @is_true = passenger_with_max_weight_and_amount?
  end

  def e
    @is_true = passenger_with_one_piece_less_than_30_kilos?
  end

  private def item_differs_from_mean_less_than_0_3_kilos
    items = Item.all
    mean_weight = items
                    .map { |item| item.weight }
                    .inject(0) { |sum, x| sum + x }
                    .quo items
                           .map { |item| item.amount }
                           .inject(0) { |sum, x| sum + x }
    result_item = nil
    items.each do |item|
      if (item.get_mean_weight - mean_weight).abs <= 0.3
        result_item = item
        break
      end
    end
    result_item
  end

  private def passengers_with_more_2_pieces_amount
    Item.all.select { |item| item.amount > 2 }.length
  end

  private def passengers_with_more_than_mean_pieces_amount
    items = Item.all
    mean_pieces = items.map { |item| item.amount }
                                 .inject(0) { |sum, x| sum + x }.quo items.length
    items.select { |item| item.amount > mean_pieces }.length
  end

  private def passengers_equal_amount_but_weight_differs_0_5_kilos?
    items = Item.all
    items.each_with_index do |item_i, i|
      items.each_with_index do |item_j, j|
        if i != j && item_i.amount == item_j.amount && (item_i.weight - item_j.weight).abs <= 0.5
          return true
        end
      end
    end
    false
  end

  private def passenger_with_max_weight_and_amount?
    items = Item.all
    item_max_amount = items.max_by { |item| item.amount }
    item_max_weight = items.max_by { |item| item.weight }
    item_max_amount == item_max_weight &&
      items.select { |item| item.amount == item_max_amount.amount }.length == 1 &&
      items.select { |item| item.weight == item_max_weight.weight }.length == 1
  end

  private def passenger_with_one_piece_less_than_30_kilos?
    Item.all.select { |item| item.amount == 1 && item.weight < 30 }.any?
  end
end
