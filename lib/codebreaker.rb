require "codebreaker/version"

module Codebreaker
  class Game
    def start
      @secret_code = []
      4.times {@secret_code << (1 + rand(6))}
    end

    def im_feeling_lucky(code)  
      #answer = []    
      if code.is_a?(String)
        answer = code.split('').map! {|i| i.to_i}
      else
        answer = code.clone
      end
      return false unless validate(answer)
      result = ""
      local_secret_code = @secret_code.clone
      answer.each_with_index do |i, index|
        if i == local_secret_code[index]
          result << '+'
          answer[index] = 'x'
          local_secret_code[index] = 'y'
        end
      end
      answer.each_with_index do |i, index|
        if match_index = local_secret_code.find_index(i)
          result << '-'
          answer[index] = 'x'
          local_secret_code[match_index] = 'y'         
        end
      end
      if result.count('+') == 4
        return true
      elsif result.count('+') == 0 && result.count('-') == 0
        return false
      end        
      result
    end

    def hint
      @secret_code[rand(@secret_code.size)]
    end

  private 
    def validate(code)
      return false unless code.kind_of?(Array)
      code.each do |i|
        return false if i<0 || i>6 || !i.kind_of?(Fixnum)
      end
      true
    end

  end
end
