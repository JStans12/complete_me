
require 'simplecov'
SimpleCov.start

require './lib/node.rb'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < Minitest::Test

  def test_node_is_a_node
    node = Node.new(true)

    assert node

  end

  def test_node_has_weight_zero
    node = Node.new(true)

    assert_equal 0, node.weight
  end

  def test_node_is_or_isnt_word
    node = Node.new(true)
    node2 = Node.new(false)

    assert_equal true, node.is_word
    assert_equal false, node2.is_word
  end

end
