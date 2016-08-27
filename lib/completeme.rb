require_relative 'node.rb'

class Trie
  attr_reader :root ,:current_node

  def initialize(root = Node.new(is_word = false))
    @root = root
  end


  def insert(word, current_node = @root, is_word = false)

    # create an array of letters and insert each one individually
    letters = word.chars
    letters.last << "a"
    letters.each do |letter|

      # ^ added a letter to the last letter
      # now if the length is 2, we know we're at the end
      # chop! that sucker off and set is_word to true
      if letter.length == 2
        letter.chop!
        is_word = true
      end

      # if the link exists
      if current_node.instance_variable_get("@#{letter}") != nil

        # if it's the last letter, set next node as a word
        if is_word
          current_node.instance_variable_get("@#{letter}").is_word = true
        end

      else # if the link does not exist, initialize it
        current_node.instance_variable_set("@#{letter}", Node.new(is_word))
      end

      # if it's not the end, look at the next node
      if is_word == false
        current_node = current_node.instance_variable_get("@#{letter}")
      end
    end
  end

  # accept node argument return an array of it's methods minus :is_word
  def node_links(current_node)

    links = current_node.instance_variables
    links.map! do |x|
      x.to_s.delete!("@")
    end

    links.shift
    links.sort

  end

  # accept node argument return all possible words
  def possible_words(word)



  end

end # end Trie class
