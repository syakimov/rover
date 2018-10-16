module Sailing
  extend self

  #      sea: two dimentinal boolean array [10, 10]
  #     ship: array [X, Y, D] optional [O, X, Y, D]
  # commands: char array, each element in [N, E, S, W, M]
  def sail_around(commands: '',
                  sea: Array.new(10) { Array.new(10, false) },
                  ship_intial: [0, 0, 'N'])

    commands.split('').reduce(ship_intial) { |ship, cmd| sail_to(sea, ship, cmd) }
  end

  private

  def sail_to(sea, ship, cmd)
    return ship if ship.first == 'O'
    return [ship[0], ship[1], redirect(ship[2], cmd)] if cmd != 'M'

    new_position = new_position(ship)

    return ['O'].concat ship if sea[new_position[0]][new_position[1]]
    new_position
  end

  def redirect(current, direction)
    {
      N: {
        L: 'W',
        R: 'E',
      },
      E: {
        L: 'N',
        R: 'S',
      },
      S: {
        L: 'E',
        R: 'W',
      },
      W: {
        L: 'S',
        R: 'N',
      },
    }[current.to_sym][direction.to_sym]
  end

  def new_position(ship)
    delta_x =
      case ship[2]
      when 'W'
        -1
      when 'E'
        1
      else
        0
      end

    delta_y =
      case ship[2]
      when 'N'
        1
      when 'S'
        -1
      else
        0
      end

    [normalize(delta_x + ship[0]),
     normalize(delta_y + ship[1]),
     ship[2]]
  end

  def normalize(coordinate)
    return 0 if coordinate == 10
    return 9 if coordinate == -1

    coordinate
  end
end
