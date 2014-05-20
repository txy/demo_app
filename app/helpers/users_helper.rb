module UsersHelper
  def gravatar_for(user,options = {size: 40})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    #gravatar_url = "https://secure.gravatar.com/avater/#{gravatar_id}.png?s=#{size}"
    #gravatar_url = "http://mp.ph.126.net/bj2uCusg7xzyWAObLxlzbw==/3268205954589259363.jpg?s=#{size}"
    gravatar_url = "http://love.hinews.cn/img/20120815/20120815110922_zwagalth.jpg?s=#{size}"
    image_tag(gravatar_url,alt:user.name,class: "gravatar")
  end
end
