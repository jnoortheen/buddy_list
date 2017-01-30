# griddler class to handle incoming mails
class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    action, friend_mail_id = @email.subject.split(' ')
    user = User.find_by email: @email.from[:email]
    friend = User.find_by email: friend_mail_id

    # if the users are not valid simply return
    return unless user && friend

    case action
    when 'add'
      user.add_friend(friend)
    when 'remove'
      user.remove_friend(friend)
    else
      raise('invalid mailer action')
    end
    return user, friend
  end
end
