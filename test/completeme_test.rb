require './lib/completeme.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TestCompleteMe < Minitest::Test

  def test_insert_the_word_a_root_is_node
    my_trie = Trie.new
    my_trie.insert("a")

    assert_equal Node, my_trie.root.a.class
    refute my_trie.root.is_word
    assert my_trie.root.a.is_word
  end

  def test_insert_two_words_with_same_letters_longest_first
    my_trie = Trie.new
    my_trie.insert("am")
    my_trie.insert("a")

    assert_equal Node, my_trie.root.a.class
  end

end
