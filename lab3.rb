# Define the User class
class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    # Method for a user to enter a room
    def enter_room(room)
      room.users << self unless room.users.include?(self)
      @rooms << room unless @rooms.include?(room)
    end
  
    # Method for a user to send a message to a room
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message)
    end
  
    # Method to acknowledge a message
    def acknowledge_message(room, message)
      if room.users.include?(self)
        puts "#{name} acknowledged message: '#{message.content}' from room '#{room.name}'."
      else
        puts "#{name} is not in room '#{room.name}' and cannot acknowledge this message."
      end
    end
  end
  
  # Define the Room class
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    # Method to broadcast a message to all users in the room
    def broadcast(message)
      @users.each do |user|
        puts "Broadcasting message to #{user.name}: '#{message.content}'"
      end
    end
  end
  
  # Define the Message class
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  # Example usage:
  # Create users
  user1 = User.new("Alice", "alice@example.com", "password123")
  user2 = User.new("Bob", "bob@example.com", "password456")
  
  # Create a room
  room1 = Room.new("Ruby Room", "A place to discuss Ruby programming.")
  
  # Users enter the room
  user1.enter_room(room1)
  user2.enter_room(room1)
  
  # User1 sends a message to the room
  user1.send_message(room1, "Hello, everyone!")
  
  # User2 acknowledges the message
  user2.acknowledge_message(room1, Message.new(user1, room1, "Hello, everyone!"))
  