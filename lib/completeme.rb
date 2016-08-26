require_relative 'node.rb'

class Trie
  attr_reader :root ,:current_node

  def initialize(root = nil)
    @root = root
  end


  def insert(word, current_node = @root, is_word = false)

    #if the root is nil, initialize it
    if @root == nil
      initialze_root
    end

    # create an array of letters and insert each one individually
    letters = word.split
    letters.last << "a"
    letters.each do |letter|

      # ^ added a letter to the last letter
      # now if the length is 2, we know we're at the end
      # chop! the bitch off and set is_word to true
      is_word = false
      if letter.length == 2
        letter.chop!
        is_word = true
      end

      # if link == nil, initialize_link
      # else view link
      # should be current_node, not root ******
      root.instance_variable_set("@#{letter}", Node.new(is_word))

    end

  end

  def initialze_root
    @root = Node.new(is_word = false)
  end

end # end Trie class
