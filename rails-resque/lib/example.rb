class Example
  @queue = :example

  def self.perform(something)
    puts "Runing resque task: #{something}"
    raise "broke in resque task"
  end
end