module UsersHelper
  require 'digest/md5'

  def avatar(user)
  	return unless user && user.email
    hash = Digest::MD5.hexdigest(user.email)
    image_tag("https://www.gravatar.com/avatar/#{hash}?d=mm&f=y")
  end

  def avatar_icon(user)
  	return unless user && user.email
    hash = Digest::MD5.hexdigest(user.email)
    image_tag("https://www.gravatar.com/avatar/#{hash}?s=25&d=mm&f=y", { class: "avatar-icon" })
  end
end
