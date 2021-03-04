
![Old Reddit Logo](https://variety.com/wp-content/uploads/2014/10/reddit-logo.jpg?w=946)

See deployed version here! [microreddit on heroku](microreddit.herokuapp.com)

# MicroReddit
Micro reddit is a remake of the old and beloved version of reddit when it first started. A simple styled ranking of links found on the internet. The goal with this project was to recreate the old reddit from scratch. The fact it looks and works like reddit was the challenge. I have a different style than the one shown here so part of the challenge for me was to put my personal preferences aside and stick to the design given.

## Features

#### Login or Register
Users can create an account if they want to add their own posts, comments, or votes to Micro Reddit.

![Log In](https://i.imgur.com/dOas4KX.png)


#### Create, Edit, and Delete a post
Creating a Post is easy. Just login and the new Post Form will appear. Here you can add a title and a valid web URL and the post will be added to the page.

![Create post](https://i.imgur.com/gOJ4G2E.png)


#### Vote on a Post
If you see a post you like Upvote it. If there is a post you do not like then Downvote it. You can vote once on every post and all votes will be counted together to give the total points on the post.

![Vote on Post](https://i.imgur.com/ccS25yv.png)


#### See posts in different Sort Order
Automatically all posts are shown in top order. Meaning the posts with the most points will be shown first. The points are calculated by subtracting the Downvotes from the total Upvotes. At the top of the page there are some other options for how to see the posts. You can see all the new posts first or show the Hot posts. Hot posts are calculated by taking the votes and dividing it by how much time has passed since voting. This means a post that was posted 5 seconds ago with 1 upvote will be shown before a post with 2 upvotes that was posted 5 hours ago.

![Sort](https://i.imgur.com/bwhxbX1.png)


#### Create, Edit, Delete and Vote on a Comment
Comments have a similar structure to Posts. They will be shown on the single post page under the post. Comments can be Created, Edited, and Deleted. If you see a Comment you like or don't like you can vote on it.

![Comments](https://i.imgur.com/D3dNGK3.png)


#### Reply to a Comment
Have something to say about another comment ? You can reply to the post. Replies will be shown below the parent Comment so they can be read in order. Replies are styled with indents to show the hierarchy of the Comments.

![Reply](https://i.imgur.com/Mpif7mM.png)


## Technology:

| ![Rails Logo](https://www.yaya.today/img/referral/Technologies/tech_rubyonrails.png) | ![jQuery Logo](https://cdn.freebiesupply.com/logos/large/2x/jquery-1-logo-png-transparent.png) | ![Sass Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Sass_Logo_Color.svg/1280px-Sass_Logo_Color.svg.png) |
|---|---|---|

Micro Reddit was made using Ruby on Rails. Ruby on Rails was used for both the backend and the frontend. The interactivity was added using jquery and the CSS Style with Sass.

![ERD](https://i.imgur.com/ywHqByu.png)


## Challenges
I faced many challenges while working on this project. The main hurdle to overcome was that I had just learned Ruby and Rails 2 weeks prior. Rails and it's MVC pattern was something I did not have prior experience working with. I had heard of the MVC pattern and knew what the letters stood for but I had never worked on a project using it. Another barrier is that I had never used relational databases before this, only Document Style Databases. The difference in how to work with this was greater than I thought it would be and it took a lot of googling to learn things on the fly. Like for example what is a Join Table. Another barrier was that I wanted to get this done in a speedy manner so this project was completed in 13 days.
