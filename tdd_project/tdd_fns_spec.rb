require_relative 'tdd_fns'

describe 'my_uniq' do 
  it 'removes duplicate elements' do 
    expect([1,1,2,3].my_uniq).to eq([1,2,3])
  end

  it 'doesn\'t alter arrays with no duplicates' do 
    expect([1,2,3].my_uniq).to eq([1,2,3])
  end

  it 'handles the empty array' do 
    expect([].my_uniq).to eq([])
  end

  it 'handles arrays of arrays' do 
    expect([[1], [1], [2]].my_uniq).to eq([[1], [2]])
  end


end

describe 'two_sum' do 
  it 'returns empty array if no elements sum to 0' do 
    expect([1,2,3].two_sum).to eq([])
  end

  it 'returns correct indices' do 
    expect([1, -1, 2,3].two_sum).to eq([[0,1]])
  end

  it 'returns indices in order' do 
    expect([1, -1, 2, -2, 3].two_sum).to eq([[0,1], [2,3]])
  end

end

describe 'my_transpose' do 

  it 'raises an error if we don\'t have an array of arrays' do 
    expect{[1].my_transpose}.to raise_error(RuntimeError)
  end

  it 'raises an error if we have an empty' do 
    expect{[].my_transpose}.to raise_error(RuntimeError)
  end

  it 'correctly transposes an array' do 
    expect([[1,2], [3,4]].my_transpose).to eq([[1,3], [2,4]])
  end

end


describe 'stock_picker' do 

  it 'raises an error if we have less than 2 stocks' do 
    expect{stock_picker([1])}.to raise_error(RuntimeError)
  end

  it 'picks the most profitable stocks' do 
    expect(stock_picker([1,2,3,4,5,6])).to eq([0,5])
  end

  it 'picks most profitable stocks at a loss' do 
    expect(stock_picker([6, 3, 2])).to eq([1,2])
  end

end




















