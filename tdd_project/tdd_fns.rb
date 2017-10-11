require 'byebug'
class Array 

  def my_uniq 
    hash = Hash.new{|h,k| h[k] = []}
    self.each_with_index do |el, idx| 
      hash[el] << idx
    end
    hash.keys
  end

  def two_sum
    idx1 = 0 
    res = []
    while idx1<self.length-1 
      idx2 = idx1+1 
      while idx2<self.length 
        res << [idx1, idx2] if self[idx1] + self[idx2]==0 
        idx2 += 1 
      end
      idx1 += 1 
    end
    res 
  end

  def my_transpose 

    raise "Empty array" if self.empty?

    self.each do |el| 
      raise "We need an array of arrays" if !el.is_a?(Array)
    end

    new_arr = []

    col_idx = 0 
    while col_idx<self.length 
      row_idx = 0 
      new_row = []
      while row_idx<self.length 
        new_row << self[row_idx][col_idx]
        row_idx += 1 
      end
      new_arr << new_row
      col_idx += 1 
    end
    new_arr
  end

end

def stock_picker(stocks)
  raise "Need more than two days" if stocks.length<=1
  buy = 0 
  biggest = -1.0/0.0
  #byebug
  biggest_arr = []
  while buy<stocks.length-1
    sell = buy+1 
    while sell<stocks.length 
      if stocks[sell]-stocks[buy]>biggest 
        biggest = stocks[sell]-stocks[buy] 
        biggest_arr = [buy, sell]
      end
      sell +=1
    end
    buy += 1 
  end
  biggest_arr
end
















