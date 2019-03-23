require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "./gilded_rose"

class CharacterizationTest < Minitest::Test
  def setup
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
    @rose = GildedRose.new(@items)
    @items = @rose.instance_variable_get(:@items)
  end

  attr_reader :rose, :items

  def test_after_1_day
    rose.update_quality
    assert_items([9, 19], [1, 1], [4, 6], [0, 80], [14, 21], [2, 4])
  end

  private

  def assert_items(*expected_items)
    expected_items.zip(items) do |(sell_in, quality), item|
      assert_equal(sell_in, item.sell_in, "#{item.name} sell_in")
      assert_equal(quality, item.quality, "#{item.name} quality")
    end
  end
end