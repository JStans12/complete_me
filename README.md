## About

This repository contains the finished CompleteMe project from the Turing School curriculum.

## Purpose

The purpose of complete me is to build an autocomplete system with a trie data structure. A trie consists of nodes which know the location of their children, but not their parents. Nodes are unaware of the key with which they are associated. Keys are defined entirely by the node's location in the trie. In our case, the only bit of information that a node stores aside from it's children, is a boolean to describe whether or not it is a word.

## Functionality

The autocomplete system should have four basic functions:
- Insert words
- Delete words
- Suggest completed words from a given string
- Update suggestions based on previous selections

## Methods

The most important idea in our implementation of the trie, is the ability to dynamically set and call variables based on a string. For example, when a word is inserted, we look at the letters one at a time, and attach links to the current node based on those letters.

```ruby
current_node.instance_variable_set("@#{letter}", Node.new(is_word))
```

This technique allowed us to created unique links for each letter without writing 26 specific cases.
</br>

Testing functionality is simple with this setup. We can easily confirm that "cat" is a word with this statement:

```ruby
assert trie.root.c.a.t.is_word
```

## Shoes GUI

In addition to the four basic functionalities, our autocomplete system also includes a GUI. The GUI was written with Shoes and Ruby. Initially there are no words loaded into the trie. The ‘Load dictionary’ button will populate the trie with words listed from “/usr/share/dict/words”. There are edit lines for the user to insert words or phrases and buttons that will perform either the insert, suggest, select, or delete functionality.
