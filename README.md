# General
## 1. Generate scaffold
    rails g scaffold post title:string text:text

## 2. destroy scaffold
    rails destroy scaffold posts

## 3. validate[s]() not validate

## 4. reference[s]() not reference / post not post~~[s]()~~ 
    rails g model comment text:text post:references



## 5. show.html.erb
    <% @post.comments.each do |c| %>
        <p><em>Comment: </em><%= c.text %></p>
        <p><%= time_ago_in_words(c.created_at) %></p>
    <% end %>

    <%= @post.comments.each do |c| %>
        <p><em>Comment: </em><%= c.text %></p>
        <p><%= time_ago_in_words(c.created_at) %></p>
    <% end %>

with the additional "=" sign, it will write out a line with the whole record

    [#<Comment id: 1, text: "123", post_id: 2, created_at: "2012-11-07 16:30:51", updated_at: "2012-11-07 16:30:51">, 
    #<Comment id: 2, text: "sdfas", post_id: 2, created_at: "2012-11-07 16:37:41", updated_at: "2012-11-07 16:37:41">]

## 6. has_many
has_many :comment[s]()

***


# Bootstrap-sass gem
## Gem file
    group :asset do
        gem 'bootstrap-sass'
    end
>remember to restart server 


# Authentication
## 1. Gems
	gem 'devise'
	gem 'cancan'
	gem 'rolify'
## 2. Create and generate
	rails g devise:install
	rails g cancan:ability
	rails g rolify:role
	
	rake db:migrate
## 3. Add role
	rails c
	
	user = User.create(:email => 'nino@gmail.com', :password => '123456')
	
	user.add_role "admin"
	
## 4. Link User to Post
	rails g migration AddDetailsToPosts user_id:integer
	rake db:migrate
	
add [user_id]() to [attr_accessible]() for mass assign:
	
	attr_accessible :text, :title, :user_id

add [belongs_to]() to model/Post.rb
add [has_many]() to model/User.rb

	rails c
	
	user = User.first
	user.update_attributes(:user_id => "1")


## 4. Check ability
	if user.has_role? :admin
		can :manage, :all
	else
		can :read, Post
	end
	
	
	Rails3BootstrapDeviseCancan::Application.routes.draw do
  		authenticated :user do
    		root :to => 'home#index'
		end
  		root :to => "home#index"
		devise_for :users
	end