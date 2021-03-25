module PostsHelper
  def render_with_hashtags(content)
    content.gsub(/[#][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/){|word| link_to word, searches_path(search: word), remote: true }.html_safe
  end 
end
