# griddler class to handle incoming mails
class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by email: @email.from
    friend = User.find_by email: @email.body

    # if the users are not valid simply return
    return unless user && friend

    case @email.subject
    when 'add friend'
      user.add_friend(friend)
    when 'remove friend'
      user.remove_friend(friend)
    else
      raise('invalid mailer action')
    end
    return user, friend
  end
end
