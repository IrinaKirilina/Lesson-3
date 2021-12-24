class Station
  # 1. Имеет название
  attr_reader :name
  # 3. Может возвращать список всех поездов на станции
  attr_reader :trains

  # 1. Имеет название, которое указывается при ее создании
  # 2. Может принимать поезда
  def initialize(name)
    @name = name
    @trains = []
  end

  # 2. Может принимать поезда (по одному за раз)
  def arrival(train)
    # в массив "поезда" добавляем "поезд", который нам передали в методе
    @trains << train
  end

  # 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def departure(train)
    @trains.delete(train)
  end

  # 4. Может возвращать список поездов на станции по типу грузовые, пассажирские
  def trains_by_type(type)
    @@trains.select { |train| train.type == type }
  end
end

class Route
  # 1. Имеет станции
  # 5. Может выводить список всех станций по-порядку от начальной до конечной
  attr_reader :stations

  # 2. Начальная и конечная станции указываются при создании маршрута
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  # 3. Может добавлять промежуточную станцию в список
  # 2.1. промежуточные могут добавляться между ними.
  def add_station(station)
    stations.insert(-2, station)
  end

  # 4. Может удалять промежуточную станцию из списка
  def delete_station(station)
    stations.delete(station)
  end
end

class Train

  # Может возвращать количество вагонов, текущую скорость, текущую станцию
   
  attr_reader :number, :type, :cars_count, :speed, :route :current_station_index

  # Имеет номер (произвольная строка), (грузовой, пассажирский), количество вагонов

  def initialize(number, type, cars_count)
    @number = number
    @type = type
    @cars_count = cars_count
    @speed = 0
    @route = route
    @current_station_index = nil
  end

  #  Может набирать скорость

  def accelerate
    speed += 1
  end

  # Может тормозить (сбрасывать скорость до нуля)

  def deccelerate
    speed -= 1 unless train_stopped?
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию)/ Mетод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def add_car
    cars_count += 1 if train_stopped?
  end

  def remove_car
    cars_count += 1 if train_stopped? && cars_count.positive?
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.

  def assign_route(route)
    @route = route
    @current_station_index = 0
  end

  #Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.

  def move_forward
    @current_station_index += 1 if route && !last_staion?
  end

  def move_backward
    @current_station_index -= 1 if route && !first_station?
  end

  def first_station?
    current_station_index == 1
  end

  def last_station?
    current_station_index == route.stations.count
  end

  def train_stopped?
    speed == 0
  end

  # Возвращать предыдущую станцию

  def previous_station
    route.stations[current_station_index - 2] if !first_station?
  end

  # Возвращать текущую станцию

  def current_station
    route.stations[current_station_index - 1]
  end

  # Возвращать следующую cтанцию на основе маршрута

  def next_station
    route.stations[current_station_index] if !last_station?
  end
end





