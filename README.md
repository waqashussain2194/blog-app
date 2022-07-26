# RailsTestProjectBlogApp
This repository contains a Blog App Implementation for a test project, maintained by Muhammad Saqib Ejaz.

FLOW OF APPLICATION:

1. Sign up
2. Login
3. View Post, Reactions, Comments
4. View Suggestions (authorized)
5. [Create Post, Update Post, Report Comment, Remove Post] (authorized)
6. [Create Comment, Update Comment, Remove Comment]-> On post, On comment, On Suggestion (authorized)
7. [Create Reaction, Remove Reaction] -> On Post, On comment (authorized)
8. [Create Report, Remove Report] -> On Post, On Comment (authorized)
9. [Create Suggestion, Remove Suggestion, Accept Suggestion] -> On Post (authorized)

FREQUENT GEMs USED:

1. devise -> User Authentication
2. pundit -> Authorization
3. rolify -> For User Roles
4. ckeditor -> Adding an editor for posts and comments
5. paperclip -> For attachment handling
6. bootstrap-sass -> For adding bootstrap
7. kaminari -> For Pagination
8. Figaro -> ENV variables
9. i18n -> Internationalize
10. font-awesome-rails -> For Font Awesome
11. pg -> For postgres


USER ROLES:

1. Admin
2. Moderator
3. Simple User

Admin has a full fledged dashboaord from where he/she can add, change, remove any model intance.
Moderator has access to a profile page from where he/she can approve or delete a post.
Simple User can do everything on his/her post/comment/like/report but cannot do anything on other's.

DESCRIPTION:

This is a Blog Post Application which can be used for adding posts, viewing posts, liking, reporting and providing suggestions on a particular post.
Any post can be commented, Liked, Reported by a legit user who is logged in.
This application covers all the basic concepts of rails which were learnt during the training process. From Controller basics to Model Validations and frontend implementation and Deployment on Heroku, everything was done and a lot of new things were learnt which were not implemented before.
