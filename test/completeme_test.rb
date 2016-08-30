require './lib/completeme.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'CSV'

class TestCompleteMe < Minitest::Test

  def test_root_is_node_class
    trie = Trie.new

    assert_equal Node, trie.root.class
  end

  def test_root_is_not_a_word
    trie = Trie.new

    refute trie.root.is_word
  end

  def test_insert_the_word_a_root_is_node
    trie = Trie.new
    trie.insert("a")

    assert_equal Node, trie.root.a.class
  end

  def test_a_is_a_word
    trie = Trie.new
    trie.insert("a")

    assert trie.root.a.is_word
  end

  def test_insert_two_words_with_same_letters_longest_first_are_nodes
    trie = Trie.new
    trie.insert("am")
    trie.insert("a")

    assert_equal Node, trie.root.a.class
    assert_equal Node, trie.root.a.m.class
    refute trie.root.m
  end

  def test_insert_two_words_with_same_letters_longest_first_are_words
    trie = Trie.new
    trie.insert("am")
    trie.insert("a")

    assert trie.root.a.is_word
    assert trie.root.a.m.is_word
    end
  def test_a_handful_of_words_are_nodes
    trie = Trie.new
    trie.insert("catapult")
    trie.insert("caterpillar")
    trie.insert("cat")
    trie.insert("a")
    trie.insert("ardvark")
    trie.insert("ark")

    assert_equal Node, trie.root.c.a.t.a.p.u.l.t.class
    assert_equal Node, trie.root.c.a.t.e.r.p.i.l.l.a.r.class
    assert_equal Node, trie.root.c.a.t.class
    assert_equal Node, trie.root.a.class
    assert_equal Node, trie.root.a.r.d.v.a.r.k.class
    assert_equal Node, trie.root.a.r.k.class
  end

def test_a_handful_of_words_are_words
  trie = Trie.new
  trie.insert("catapult")
  trie.insert("caterpillar")
  trie.insert("cat")
  trie.insert("a")
  trie.insert("ardvark")
  trie.insert("ark")

  assert trie.root.c.a.t.e.r.p.i.l.l.a.r.is_word
  assert trie.root.c.a.t.e.r.p.i.l.l.a.r.is_word
  assert trie.root.c.a.t.is_word
  assert trie.root.a.is_word
  assert trie.root.a.r.k.is_word
  refute trie.root.a.r.is_word
end


  def test_node_links
    trie = Trie.new
    trie.insert("catapult")
    trie.insert("caterpillar")
    trie.insert("cat")
    trie.insert("a")
    trie.insert("ardvark")
    trie.insert("ark")

    assert_equal trie.node_links(trie.root), ["a", "c"]
    assert_equal trie.node_links(trie.root.c.a.t), ["a", "e"]
    assert_equal trie.node_links(trie.root.a.r), ["d", "k"]
  end

  def test_inserting_words_from_file_path_are_nodes
    trie = Trie.new
      dictionary = File.read("./test/test_words.txt")

      trie.populate(dictionary)
      assert_equal Node, trie.root.a.a.class
      assert_equal Node, trie.root.a.a.l.i.i.class
      assert_equal Node, trie.root.a.a.r.d.v.a.r.k.class
      assert_equal Node, trie.root.a.a.r.d.w.o.l.f.class
  end

  def test_inserting_words_from_file_path_are_words
    trie = Trie.new
    #dictionary = File.read("/usr/share/dict/words") test later
    dictionary = File.read("./test/test_words.txt")

    trie.populate(dictionary)
    assert trie.root.a.is_word
    assert trie.root.a.a.m.is_word
    refute trie.root.a.a.r.d.w.is_word
    assert trie.root.a.a.r.o.n.is_word
  end

  def test_load_full_dictionary_are_nodes
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal Node, trie.root.a.b.d.o.m.i.n.o.h.y.s.t.e.r.e.c.t.o.m.y.class
    assert_equal Node, trie.root.g.l.o.u.c.e.s.t.e.r.class # starts with cap G in dict
    assert_equal Node, trie.root.j.e.a.n.p.i.e.r.r.e.class # Jean-Pierre in dict
    assert_equal Node, trie.root.z.y.m.o.m.e.class
    assert_equal Node, trie.root.z.y.m.o.m.e.t.e.r.class
  end

  def test_load_full_dictionary_are_words

    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert trie.root.a.b.d.o.m.i.n.o.h.y.s.t.e.r.e.c.t.o.m.y.is_word
    refute trie.root.a.b.d.o.m.i.n.o.h.y.s.t.e.r.e.c.t.o.m.is_word
    assert trie.root.g.l.o.u.c.e.s.t.e.r.is_word # starts with cap G in dict
    assert trie.root.j.e.a.n.p.i.e.r.r.e.is_word # Jean-Pierre in dict
    assert trie.root.z.y.m.o.m.e.is_word
    refute trie.root.z.y.m.o.m.e.t.is_word
    assert trie.root.z.y.m.o.m.e.t.e.r.is_word
  end

  def test_count_of_one
    trie = Trie.new
    trie.insert("a")

    assert_equal 1, trie.count
  end

  def test_count_test_file
    trie = Trie.new
    dictionary = File.read("./test/test_words.txt")
    trie.populate(dictionary)

    assert_equal 9, trie.count
  end

  def test_count_full_dictionary

    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal 234371, trie.count # number of words if downcase
  end

  def test_find_node
    trie = Trie.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("crap")

    assert_equal trie.find_node("ca"), trie.root.c.a
    refute_equal trie.find_node("ca"), trie.root.c
    refute trie.find_node("cab")
  end

  def test_suggested_words_returns_array
    trie = Trie.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cart")
    trie.insert("carp")
    trie.insert("crap")
    trie.insert("coffee")
    trie.insert("clump")

    expected = ["car", "carp", "cart", "cat"]
    assert_equal expected, trie.suggest("ca")
  end

  def test_delete_word
    trie = Trie.new
    trie.insert("a")
    assert trie.root.a.is_word
    trie.delete_word("a")
    refute trie.root.a
  end

  def test_delete_more_words
    trie = Trie.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cart")
    trie.insert("carp")
    trie.insert("crap")
    trie.insert("coffee")
    trie.insert("clump")
    trie.delete_word("car")

    refute trie.root.c.a.r.is_word
    assert trie.root.c.a.r.t.is_word
  end

  def test_some_different_delete_cases
    trie = Trie.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cart")
    trie.insert("cartography")
    trie.delete_word("cartography")

    assert trie.root.c.a.r.t.is_word
    refute trie.root.c.a.r.t.o
  end

  def test_does_this_delete_work_with_full_dictionary
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    trie.delete_word("a")

    refute trie.root.a.is_word
  end

  def test_does_this_delete_really_work
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    trie.delete_word("a")
    trie.delete_word("busy")
    trie.delete_word("care")
    trie.delete_word("dog")
    trie.delete_word("man")
    trie.delete_word("bear")
    trie.delete_word("pig")
    trie.delete_word("tree")
    trie.delete_word("use")
    trie.delete_word("zip")

    refute trie.root.a.is_word
    refute trie.root.b.u.s.y.is_word
    refute trie.root.c.a.r.e.is_word
    refute trie.root.d.o.g.is_word
    refute trie.root.m.a.n.is_word
    refute trie.root.b.e.a.r.is_word
    refute trie.root.p.i.g.is_word
    refute trie.root.t.r.e.e.is_word
    refute trie.root.u.s.e.is_word
    refute trie.root.z.i.p.is_word

  end

  def test_delete_some_words_and_other_words_are_still_words
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    trie.delete_word("be")
    trie.delete_word("can")

    refute trie.root.b.e.is_word
    refute trie.root.c.a.n.is_word

    assert trie.root.a.is_word
    assert trie.root.b.e.t.is_word
  end

  def test_select_adds_weight_to_node
    trie = Trie.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cart")

    trie.select("ca", "cat")

    assert_equal 1, trie.root.c.a.t.weight
  end

  def test_suggest_sorts_by_weight_one_run
    trie = Trie.new
    trie.insert("pizza")
    trie.insert("pizzeria")
    trie.insert("pizzacato")

    trie.select("piz", "pizzeria")
    expected = ["pizzeria", "pizza", "pizzacato"]

    assert_equal expected, trie.suggest("piz")
  end

  def test_suggest_sorts_by_weight_multiple_runs
    trie = Trie.new
    trie.insert("pizza")
    trie.insert("pizzeria")
    trie.insert("pizzacato")

    trie.select("piz", "pizzeria")
    trie.select("piz", "pizzacato")
    trie.select("piz", "pizzacato")
    expected = ["pizzacato", "pizzeria", "pizza"]

    assert_equal expected, trie.suggest("piz")

  end

end # end test class
