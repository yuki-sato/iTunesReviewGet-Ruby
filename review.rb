class Review

  attr_accessor :id, :title, :updated, :content, :rate, :version, :author, :country
  
  #初期化
  def initialize
    @id=0
    @title = nil
    @updated = nil
    @content = nil
    @rate = 0
    @version =nil
    @author = nil
    @country = nil
  end

end