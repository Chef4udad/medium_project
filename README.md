# API HANDLING
LVL 5
1- Reading time - Show in posts

2- Drafts - if draft bool value is true.
     GET - http://localhost:3000/api/posts/drafts

3- Revision history - when you update the post
     GET - http://localhost:3000/api/posts/:id/revisions

4- Save for later
     GET - http://localhost:3000/api/posts/saved_posts
     POST - http://localhost:3000/api/posts/:id/save_for_later

5- LIST
    *Create Lists:*
     POST - http://localhost:3000/api/users/:user_id/lists
     pass in body eg:-
     {
      "list": {
      "title": "My New List"
       }
    }

    *View Lists:*
      GET -  http://localhost:3000/api/users/:user_id/lists

    *Add Posts to Lists:*
     POST - http://localhost:3000/api/users/:user_id/lists/:list_id/add_post
     Body-
     {
       "post_id": 1
     }


     GET - http://localhost:3000/api/users/:user_id/lists/:list_id/add_post

    *Share Lists:*
    POST   -> /api/lists/:id/share
   Body - 
   {
       “user_id”: USER_ID_TO_SHARE_WITH
    }

LVL 4 ->
http://localhost:3000/api/payments/create_order?amount=600 (POST)

LVL 3 ->
Top posts - http://localhost:3000/api/posts/top_posts
Recommended -  http://localhost:3000/api/posts/recommended_posts


LVL 2 ->
Login - http://localhost:3000/login?email=new@gmail.com&password=thik   (POST)
Logout - http://localhost:3000/api/logout
View users - http://localhost:3000/api/users
Add users - http://localhost:3000/api/users?name=harsh&email=123@gmail.com&password=500  (POST)
Update users - http://localhost:3000/api/users/5?password=newp
Delete users - http://localhost:3000/api/users/1  (DEL)
View Posts -  http://localhost:3000/api/posts
Add Posts -  http://localhost:3000/api/posts?title=dddd&category=ghjkl (post)
Update Posts - http://localhost:3000/api/posts/1?title=bvcxz  (Patch)
Delete Posts - http://localhost:3000/api/posts/3 (DEL)
Like - http://localhost:3000/api/likes?post_id=1 (POST)
View Comment -  http://localhost:3000/api/comments
Add Comment -  http://localhost:3000/api/comments?post_id=1&text=yes
Delete Comment - http://localhost:3000/api/comments/comet_id (DEL)
Update Comment - http://localhost:3000/api/comments?post_id=1&text=yes (Patch)
Check Followers - http://localhost:3000/api/follows?users/:id/followers
Check Following - http://localhost:3000/api/follows?users/:id/following
Follow  - http://localhost:3000/api/follows?follower_id=2&following_id=3 (POST)
Filter Follow - http://localhost:3000/api/follows?follower_id=2

LVL 1 ->
User profile - http://localhost:3000/api/users/1 (GET)
Post profile -  http://localhost:3000/api/posts/1 (GET)
Filter Posts By:-(author,  title,  category, start_date, end_date) (GET)
http://localhost:3000/api/posts?category=ghjkl
http://localhost:3000/api/posts?start_date=2023-08-12


