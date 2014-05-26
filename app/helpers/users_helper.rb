module UsersHelper
  def gravatar_for(user,options = {size: 40})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    #gravatar_url = "https://www.gravatar.com/avater/#{gravatar_id}.png?s=#{size}"
    gravatar_url = "http://pic.baike.soso.com/p/20090113/20090113120000-101577.jpg"
    #gravatar_url = "http://love.hinews.cn/img/20120815/20120815110922_zwagalth.jpg"
    image_tag(gravatar_url,alt:user.name,class: "gravatar")
  end
end
