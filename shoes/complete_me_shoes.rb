require '../lib/complete_me'
require '../lib/node'

trie = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
trie.populate(dictionary)

Shoes.app do
  background "#add8e6"
  border("#BE8",
         strokewidth: 6)

  stack(margin: 10) do
    @load_dictionary = button("Load dictionary") do
      trie.populate(dictionary)
    end

    #insert
    insert_phrase = para "Enter word to insert: "
    flow do
      @insert_word_line = edit_line
      @insert_button = button("Insert") do
        trie.insert(@insert_word_line.text)
      end
    end

    #suggest
    suggest_phrase = para "Enter word phrase: "
    flow do
      @suggest_phrase_line = edit_line do |e|
        @copy_box.text = @suggest_phrase_line.text
      end

      @suggest_button = button("suggest") do
        suggested_results = trie.suggest(@suggest_phrase_line.text).join(", ")
        @copy_box.text = suggested_results
      end
    end

    #select
      #title
      flow do
        select_phrase = para("Phrase:")
        select_word = para("Selected word:")
      end
      #edit boxes
      flow do
        @select_phrase_line = edit_line :width => 60
        @select_word_line = edit_line :width => 150
        #button
        select_button = button("select") do
          trie.select(@select_phrase_line.text, @select_word_line.text)
        end
      end

    #delete button
    delete_phrase = para "Enter word to delete:"
    flow do
      @delete_word_line = edit_line
      delete_button = button("delete") do
        trie.delete(@delete_word_line.text)
      end
    end

    suggestions = para "Auto-complete suggestions: "
    @copy_box = para ""
  end
end
