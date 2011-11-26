# this is my attempt to DRY up my pages_controller_spec.rb file.
#
# it is turning into:  eval and quote hell
# so let's just ignore DRY ness 
# and use RSPEC as a DSL with its nesting hierarchy.
#
# reverting the file
# rgk 11/26/2011

def describe(string)
string
end

def it(string)
string
end

 basetext =  "Ruby on Rails Tutorial Sample App "
  pages= ['home', 'contact', 'about']
  tests = ['should be successful', 'should have the right title']
  contents = [ basetext + '| Home', 
               basetext + '| Contact',
               basetext + '| About']
  i = 0
  pages.each do  |p|
    i += 1
#describe "GET #{p}" do
    "GET #{p}" 
      tests.each do |t|
#it  t 
#           if ii == 0
#             response.should be_success
#           else
#             response.should have_selector("title", content: contents[i])
#           end
         puts "DESCRIBE: #{p}  TEST: #{t} RESPONSE: #{contents[i]}"
      end
    end
#end
