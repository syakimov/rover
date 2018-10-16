require_relative 'kata'

describe Sailing do
  it 'base example' do
    Sailing.sail_around.should eq [0, 0, 'N']
  end

  it 'move correctly' do
    Sailing.sail_around(commands: 'M').should eq [0, 1, 'N']
  end

  it 'turns left' do
    Sailing.sail_around(commands: 'L').should eq [0, 0, 'W']
  end

  it 'turns right' do
    Sailing.sail_around(commands: 'R').should eq [0, 0, 'E']
  end

  it 'wraps around on the X' do
    Sailing.sail_around(commands: 'LM').should eq [9, 0, 'W']
  end

  it 'wraps around on the Y' do
    Sailing.sail_around(commands: 'LM').should eq [9, 0, 'W']
  end

  it 'stops when blocked' do
    sea = Array.new(10) { Array.new(10, false) }
    sea[0][2] = true

    destination = Sailing.sail_around(sea: sea, commands: 'MMM')

    destination.should eq ['O', 0, 1, 'N']
  end
end
