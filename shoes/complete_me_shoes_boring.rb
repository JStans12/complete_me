require '../lib/complete_me'
require '../lib/node'

trie = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
trie.populate(dictionary)

Shoes.app do

  @back = background('#000000')

  stack(margin: 10) do
    button("Load dictionary") do
      trie.populate(dictionary)
    end

    insert_phrase = para("Enter word to insert: ", :stroke => "#730099", :weight => "bold")
    flow do
      insert_word_line = edit_line
      button("Insert") do
        trie.insert(insert_word_line.text)
      end
    end

    para("Enter word phrase: ", :stroke => "#0000ff", :weight => "bold")
    flow do
      suggest_phrase_line = edit_line do |e|
        @copy_box.text = suggest_phrase_line.text
      end

      button("suggest") do
        suggested_results = trie.suggest(suggest_phrase_line.text).join(", ")
        @copy_box.text = suggested_results
      end
    end

    flow do
      para("Phrase:", :stroke => "#33cc33", :weight => "bold")
      para("Selected word:", :stroke => "#33cc33", :weight => "bold")
    end

    flow do
      select_phrase_line = edit_line :width => 60
      select_word_line = edit_line :width => 150

      select_button = button("select") do
        trie.select(select_phrase_line.text, select_word_line.text)
      end
    end

    para("Enter word to delete:", :stroke => "#e6e600", :weight => "bold")
    flow do
      delete_word_line = edit_line
      button("delete") do
        trie.delete_word(delete_word_line.text)
      end
    end

    para("Auto-complete suggestions: ", :stroke => "#ff6600", :weight => "bold")
    @copy_box = para("", :stroke => "#F00", :weight => "bold")
  end
end
