import DAC

defmodule Peer do

def start(num) do
  IO.puts ["      Peer at ", node_ip_addr(), "  PID: #{self_string()}"]
  receive do
  { :bind, peers} ->
  map = initMap(peers, Map.new)
  next(num, map)
  end
end

def next(num, map) do
  receive do
  { :broadcast, max_broadcasts, timeout} ->
  Process.send_after(self(), :dest, timeout) # stop broadcasting after timeout
  init(num, map, max_broadcasts)
  end
end

defp init(num, map, max_broadcasts) do
  receive do
  { :update, p} ->
       # allocate recorded sent and received messages from the map
      {s,r} = Map.get(map, p)
       # update the number of received message
      newMap = Map.put(map, p, {s, r+1})
      init(num, newMap, max_broadcasts)
  # a directed message to timeout function for printing out its status
  :dest -> timeout(num, map)
  # broadcast the message without any further delay
  after 0 -> broadcast(num, max_broadcasts, map)
  end
end

defp timeout(num, map) do
  val = Map.values(map)
  sval = for v <- val, do: inspect(v)
  IO.puts("#{num} : #{Enum.join(sval, " ")} " )
  peers = Map.keys(map)
  next(num, initMap(peers, Map.new))
end

defp broadcast(num, max_broadcasts, map) do
  peers = Map.keys(map)
  {send,_} = Map.get(map, self())
  if send < max_broadcasts do
    newMap = updateSent(peers, map)
    init(num, newMap, max_broadcasts)
  else
    init(num, map, max_broadcasts)
  end
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([p|o], map) do
    newMap = Map.put(map, p, {0, 0})
    initMap(o, newMap)
end


def updateSent([], map), do: map

def updateSent([p|o], map) do
  send p, { :update, self()}
  {s,r} = Map.get(map, p)
  newMap = Map.put(map, p, {s+1, r})
  updateSent(o, newMap)
end


end # module -----------------------
