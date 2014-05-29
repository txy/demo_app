module MicropostsHelper
  #换行显示长单词的帮助方法
  def wrap(content)
    sanitize(raw(content.aplit.map {|s| wrap_long_string(s)}.join(' ')))
  end

  private
  
    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width ) ? text :
                                   text.scan(regex).join(zero_width_space)
    end
end
