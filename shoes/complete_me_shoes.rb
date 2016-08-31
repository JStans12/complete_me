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
    @phrase = para "Enter word phrase: "

    #suggest button
    flow do
      @suggest_phrase_line = edit_line do |e|
        @copy_box.text = @suggest_phrase_line.text
      end

      @suggest_button = button("suggest") do
        suggested_results = trie.suggest(@suggest_phrase_line.text).join(", ")
        # suggested_results.each do |word|
        #   stack(margin: 10) do
        #     para "#{word}"
        #   end
        # end
        @copy_box.text = suggested_results
        #@copy_box.text = clicked_results
      end
    end

    #select button
    stack do
      #title
      flow do
        @select_phrase = para "Phrase"
        para = " "
        @select_word = para "Selected word"
      end
      #edit boxes
      flow do
        @select_phrase_line= edit_line :width => 50
        para = " "
        @select_word_line = edit_line :width => 150
        #button
        @select_button = button("select") do
          trie.select(@select_phrase_line.text, @select_word_line.text)
        end
      end
    end

    @phrase2 = para "Auto-complete suggestions: "
    @copy_box = para "Test"
  end
end
