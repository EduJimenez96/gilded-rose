require 'delegate'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      ItemWrapper.new(item).update
    end
  end
end

class ItemWrapper < SimpleDelegator
  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    age
    update_quality
  end

  def age
    self.sell_in -= 1 if name != "Sulfuras, Hand of Ragnaros"
  end

  def update_quality
    self.quality += caluculate_quality_adjustment
  end

  def caluculate_quality_adjustment
    adjustment = 0
    if name == "Aged Brie"
      adjustment += 1
      if sell_in < 0
        adjustment += 1
      end
    elsif name == "Backstage passes to a TAFKAL80ETC concert"
      if sell_in < 11
        adjustment += 1
      end
      if sell_in < 6
        adjustment += 1
      end
      if sell_in < 0
        adjustment -= quality
      end
    elsif name == "Conjured Mana Cake"
      adjustment -= 2
      if sell_in < 0
        adjustment -= 2
      end
    else
      adjustment -= 1
      if sell_in < 0
        adjustment -= 1
      end
    end

    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end