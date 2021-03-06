require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test
  def test_it_inserts_a_new_node_when_passed_in_data
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_it_verifies_and_rejects_the_presence_of_a_score
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert tree.include?(16)
    refute tree.include?(72)
  end

  def test_reports_the_depth_of_the_tree_where_a_score_appears
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
  end

  def test_reports_the_move_and_score_of_the_highest_scored_movie
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    expected = {"Sharknado 3"=>92}

    assert_equal expected, tree.max
  end

  def test_reports_the_move_and_score_of_the_lowest_scored_movie
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    expected = {"Johnny English"=>16}

    assert_equal expected, tree.min
  end

  def test_returns_array_of_all_movies_and_scores_sorted_in_ascending_order
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    expected = [{"Johnny English"=>16},
    {"Hannibal Buress: Animal Furnace"=>50},
    {"Bill & Ted's Excellent Adventure"=>61},
    {"Sharknado 3"=>92}]

    assert_equal expected, tree.sort
  end

  def test_ignores_scores_already_included
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(61, "Bill & Ted's Bogus Journey")

    expected = {"Bill & Ted's Excellent Adventure"=>61}
    not_expected = {"Bill & Ted's Bogus Journey"=>61}

    assert_equal expected, tree.min
    assert_equal expected, tree.max
    refute_equal not_expected, tree.min
  end

  def test_loads_new_movies_from_file
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")

    expected = 96
    actual = tree.load('bin/movies.txt')

    assert_equal expected, actual
  end

  def test_reports_on_health_of_tree
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end

  def test_count_children
    tree = BinarySearchTree.new
    actual = tree.load('bin/movies.txt')

    expected = 100
    assert_equal expected, actual

    actual = tree.count_children_and_parent(tree.head, 0)
    assert_equal 100, actual
  end

  def test_counts_the_nodes_at_a_given_depth
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.insert(99, "Teen Wolf")
    tree.insert(100, "Labyrinth")

    assert_equal 1, tree.collect_nodes_at_depth(0).length
    assert_equal 2, tree.collect_nodes_at_depth(1).length
    assert_equal 3, tree.collect_nodes_at_depth(2).length
    assert_equal 2, tree.collect_nodes_at_depth(3).length
    assert_equal 1, tree.collect_nodes_at_depth(4).length
  end

  def test_counts_the_leaves
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.insert(99, "Teen Wolf")
    tree.insert(100, "Labyrinth")

    actual = tree.leaves
    expected = 3

    assert_equal expected, actual
  end

  def test_returns_the_depth_of_the_tree
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.insert(99, "Teen Wolf")
    tree.insert(100, "Labyrinth")

    actual = tree.depth
    expected = 4

    assert_equal expected, actual
  end

  def test_collects_children_of_a_node_with_a_given_score
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.insert(99, "Teen Wolf")
    tree.insert(100, "Labyrinth")

    node_for_test = tree.find_node(58)

    collection_array = tree.collect_children(58, node_for_test)
    assert_equal 5, collection_array.length
  end


  def test_deletes_a_node_with_a_given_score
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.insert(99, "Teen Wolf")
    tree.insert(100, "Labyrinth")

    tree.delete(58)

    expected_min = {"Bill & Ted's Bogus Journey"=>36}
    expected_max = {"Labyrinth"=>100}

    assert_equal true, tree.include?(93)
    assert_equal true, tree.include?(36)
    assert_equal true, tree.include?(86)
    assert_equal true, tree.include?(38)
    assert_equal true, tree.include?(69)
    assert_equal false, tree.include?(58)
    assert_equal expected_min, tree.min
    assert_equal expected_max, tree.max
  end
end
