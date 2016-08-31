require_relative 'node.rb'

class CompleteMe
  attr_reader :root

  def initialize(root = Node.new(is_word = false))
    @root = root
  end

  def insert(word, current_node = @root, is_word = false)

    letters = word.chars
    letters.last << "a"
    letters.each do |letter|
      letter.downcase!

      next if letter == "-"

      if letter.length == 2
        letter.chop!
        is_word = true
      end

      if current_node.instance_variable_get("@#{letter}") != nil

        if is_word
          current_node.instance_variable_get("@#{letter}").is_word = true
        end

      else
        current_node.instance_variable_set("@#{letter}", Node.new(is_word))
      end

      if is_word == false
        current_node = current_node.instance_variable_get("@#{letter}")
      end
    end
  end

  def node_links(current_node)
    links = current_node.instance_variables
    links.map! do |x|
      x.to_s.delete!("@")
    end
    2.times { links.shift }
    links.sort
  end

  def suggest(word)

    all_words(find_node(word), word)
    sorted_suggestions = @suggested_words.sort do |less, more|
      find_node(more).weight <=> find_node(less).weight
    end
    sorted_suggestions
  end

  def all_words(current_node, working_word, working_letter = '', first_run = true)

    @suggested_words = [] if first_run
    working_word << working_letter
    @suggested_words.push(working_word.dup) if current_node.is_word

    links = node_links(current_node)
    links.each do |link|
      all_words(current_node.instance_variable_get("@#{link}"), working_word, link, false)
    end
    working_word.chop!
    @suggested_words
  end

  def populate(input_list)
    words_to_load = input_list.split("\n")
    words_to_load.each do |word|
      insert(word)
    end
  end

  def count(current_node = @root, first_run = true)
    @count = 0 if first_run
    @count += 1 if current_node.is_word

    links = node_links(current_node)
    links.each do |link|
      count(current_node.instance_variable_get("@#{link}"), false)
    end
    @count
  end

  def find_node(word)
    current_node = @root

    letters = word.chars
    letters.each do |letter|
      letter.downcase!
      return false if current_node.instance_variable_get("@#{letter}").nil?
      current_node = current_node.instance_variable_get("@#{letter}")
    end
    current_node
  end

  def delete_word(word)

    current_node = find_node(word)
    current_node.is_word = false

    prune(word) if node_links(current_node).empty?
  end

  def prune(word, current_node = @root, previous_node = '', current_letter = '')

    prune(word, current_node.instance_variable_get("@#{word[0]}"), current_node, word.slice!(0)) unless word.empty?

    if current_node != @root && node_links(current_node).empty? && current_node.is_word == false
      previous_node.remove_instance_variable("@#{current_letter}")
    end
  end

  def select(phrase, selected_word)
    selected_node = find_node(selected_word)
    selected_node.weight += 1
  end

end
