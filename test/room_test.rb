require 'test/unit'
require './models/room'

class RoomTest < Test::Unit::TestCase

  def test_find_or_create_should_create_a_new_room
    room = Room.find_or_create 'foobar'
    assert_equal 'foobar', room.name
  end
  
  def test_find_or_create_should_retrieve_an_existing_room
    room = Room.find_or_create 'foobar2'
    assert_equal room.id, Room.find_or_create('foobar2').id 
  end
  
  
end
