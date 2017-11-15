# calling this method will return the relavent User object
def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end


# Returns true if the session contains the user ID (the user is logged in)
# Use for actions that require logged in users to view/update
def logged_in?
  session[:user_id] != nil
end


# Takes the user to the login page if they are trying to access a route that requires you to be logged in. Otherwise the action will behave as normal.
def authenticate!
  redirect '/sessions/new' unless logged_in?
end


# If the user is trying to view/edit something that does not belong to them, or that they are not allowed to view/edit, they will be taken to the /not_authorized view.
def authorize!(user)
  redirect '/not_authorized' unless authorized?(user)
end


# Makes sure the user resource a user is attempting to view/edit belongs to them. (User) in the argument is user data being passed into the request. current_user is the person attempting to make the request.
def authorized?(user)
  current_user == user
end
