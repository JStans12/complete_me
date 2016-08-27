require './lib/completeme.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TestCompleteMe < Minitest::Test

  def test_insert_the_word_a_root_is_node
    trie = Trie.new
    trie.insert("a")

    assert_equal Node, trie.root.a.class
    refute trie.root.is_word
    assert trie.root.a.is_word
  end

  def test_insert_two_words_with_same_letters_longest_first
    trie = Trie.new
    trie.insert("am")
    trie.insert("a")

    assert_equal Node, trie.root.a.class
    assert_equal Node, trie.root.a.m.class
    assert trie.root.a.is_word
    assert trie.root.a.m.is_word
    refute trie.root.m
  end

  def test_a_handful_of_words
    trie = Trie.new
    trie.insert("catapalt")
    trie.insert("caterpiller")
    trie.insert("cat")
    trie.insert("a")
    trie.insert("ardvark")
    trie.insert("ark")

    assert_equal Node, trie.root.c.a.t.e.r.p.i.l.l.e.r.class
    assert trie.root.c.a.t.e.r.p.i.l.l.e.r.is_word
    assert trie.root.c.a.t.is_word
    refute trie.root.c.is_word
    refute trie.root.c.is_word

    assert trie.root.a.is_word
    assert trie.root.a.r.k.is_word
    refute trie.root.a.r.is_word
  end

  def test_node_links
    trie = Trie.new
    trie.insert("catapalt")
    trie.insert("caterpiller")
    trie.insert("cat")
    trie.insert("a")
    trie.insert("ardvark")
    trie.insert("ark")

    assert_equal trie.node_links(trie.root), ["a", "c"]
    assert_equal trie.node_links(trie.root.c.a.t), ["a", "e"]
    assert_equal trie.node_links(trie.root.a.r), ["d", "k"]
  end

end
