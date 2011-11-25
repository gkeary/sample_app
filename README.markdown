# branch updating-users1
#

this branch recovers from several errors.
Note that you can place puts statements in the spec files 
and examine stuff on the fly.

Now the app will sign in and sign out and there are 66 examples in the spec.

Technical debt:  look into a means for DRYing up the spec file(s) around:
  should be successful
  title should be:  'foo'

# Integration tests: signin/signout

 As a capstone to our hard work on authentication, 
 we’ll finish with integration tests 
 for signin and signout 
 (placed in the users_spec.rb file for convenience).
 
 RSpec integration testing is 
 expressive enough that 
 Listing 9.30 
 should need little explanation; 
 I especially like the use of 
 click_link "Sign out", 
    which not only simulates a 
    browser clicking the signout link, 
    but also raises an error 
    if no such link exists
      —thereby testing the URL, 
      the named route, 
      the link text, 
      and the changing of the 
      layout links, all in one line. 
      
If that’s not an integration test, 
   I don’t know what is.


# Heroku link 
 Currently at end of Ch5 and pushed to 
 [* Heroku*](http://blooming-lightning.heroku.com)
   
# User signup:  1st step

  remember:  use bundle exec rspec spec to run all tests

# HTML colors info

   HTML colors can be coded with three base-16 (hexadecimal) numbers, 
     one each for the primary colors red, green, and blue. 
       #fff maxes out all three colors, 
          yielding pure white. 
          See this HTML colors site for more information. ↑ 
          [* HTML colors *](http://www.w3schools.com/html/html_colors.asp)

# Ch4 has its own git branch

# 2nd time going thru Chapter 3

 Built this again and pushed it to [* Heroku*](http://blooming-lightning.heroku.com)

here are the applicable heroku commands:

git push heroku
 2130  ls .git/config
 2131  cat .git/config
 2132  heroku rename blooming-lightning
 2133  git remote -v

Note:  I did not do the exercises in Ch3 i.e. the HELP PAGE and friends.  
The help page may be in a previous commit.


# 2nd iteration: added annotate gem
# Ruby on Rails Tutorial: sample application

This is the sample application for
[*Ruby on Rails Tutorial: Learn Rails by Example*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/).
