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


