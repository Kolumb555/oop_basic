class Station

  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end
  
  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type)
    @trains.find_all { |tr| tr.type == type}
  end
end

class Route

  attr_reader :route_stations
  
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @route_stations = [@start_station, @end_station]
  end

  def add_intermediate_station(station)
    @route_stations.insert(-2, station)
  end

  def exclude_intermediate_station(station)
    @route_stations.delete(station)
  end
end

class Train

  attr_accessor :van_qty, :route
  attr_reader :speed, :type

  def initialize(number, type, van_qty)
    @number = number
    @type = type
    @van_qty = van_qty
    @speed = 0
    @station_number = 0
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def attach_car
    @van_qty += 1 if @speed==0
  end

  def detach_car
    @van_qty -= 1 if @speed==0
  end

  def get_route(route)
    @route = route
    @station_number = 0
  end

  def move_forward
    @station_number += 1 if @station_number < (@route.route_stations.length - 1)
  end
  
  def move_back
    @station_number -= 1 if @station_number >= 1
  end

  def show_previous_station
    @route.route_stations[@station_number - 1] if @station_number >= 1
  end

  def show_current_station
    @route.route_stations[@station_number]
  end

  def show_next_station
    @route.route_stations[@station_number + 1] if @station_number < @route.route_stations.size
  end
end
