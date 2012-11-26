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

## 7. rails console reload
when a model is updated (migrated), you need to reload console 
	
	1.9.3p194 :001 > reload!

## 8. link_to post
	<%= link_to 'my link', post %>
	
	# post is enough, no need post_path(post)
	
## 9. Destroy
	<%= link_to 'Destroy', post, method: :delete, data: { confirm: 'Are you sure?'} %>


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

## 5. Role name
	rails c
	
	u = User.first
	u.roles.first.name
	
	# In rails console you could do that
	# However, in view you cant. 
	
	# Query in view doesnt have cache
	# http://blog.xdite.net/posts/2012/11/20/rubyconf-china-2012-ten-slow-things-you-dont-know/
	
	in user.rb
	
	# add method

	def my_role
		self.roles.map { |r| p r.try(:name) }
	end

	in view files
	
	<% @users.each do |u| %>
		<%= u.my_role %>
	<% end %>	
	
	

# Auther of Post
PostsController create 中加入

	@post.user_id = current_user.id	

爲@post中user_id賦值，否則單憑form_for中的參數，無法爲之賦值，進而無法判斷該post屬於誰
  
    def create
    	@post = Post.new(params[:post])
    	@post.user_id = current_user.id
    	respond_to do |format|
      	if @post.save
        	format.html { redirect_to @post, notice: 'Post was successfully created.' }
        	format.json { render json: @post, status: :created, location: @post }
      	else
        	format.html { render action: "new" }
        	format.json { render json: @post.errors, status: :unprocessable_entity }
      	end
	end

stackflow中有文說在PostsController的new中使用

	@post = current_user.posts.build

	# replace 
	@post = Post.new
	
試驗失敗，估計是create中又用到
	
	@post= Post.new(params[:post])
@post 被覆蓋了


# Active record find method
## if model has property - name
	Post.find_by_name
	
	Post.where(:name => "nino")
	
## scope 
	class Post < ActiveRecord::Base
		scope :nino, where("name = ?", "nino")
		scope :published, lambda { where("published_at <= ?", Time.zone.now)}
	end
  
#Git
## Unmodify a modified file
 !important - your file is back to the last commit and any new update never be found
 	
	git checkout -- <your file>
	git checkout -- app/controller/posts_controller.rb
  
  
  
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