import DAC

defmodule App do

def start(num) do
  IO.puts ["      Peer at ", node_ip_addr(), "  PID: #{self_string()}"]
  receive do
  { :bind, peers, pl, pid} ->
  map = initMap(peers, Map.new)
  next(num, map, pl, pid)
  end
end

def next(num, map, pl, pid) do
  receive do
  { :pl_deliver, :broadcast, max_broadcasts, timeout} ->
  Process.send_after(self(), :dest, timeout)
  init(num, map, max_broadcasts, pl, pid)
  end
end

defp init(num, map, max_broadcasts, pl, pid) do
  receive do
  { :pl_deliver, p, _} ->
      {s,r} = Map.get(map, p)
      newMap = Map.put(map, p, {s, r+1})
      init(num, newMap, max_broadcasts, pl, pid)
  :dest -> timeout(num, map, pl, pid)
  after 0 -> broadcast(num, max_broadcasts, map, pl, pid)
  end
end

defp timeout(num, map, pl, pid) do
  val = Map.values(map)
  sval = for v <- val, do: inspect(v)
  IO.puts("#{num} : #{Enum.join(sval, " ")} " )
  p = Map.keys(map)
  next(num, initMap(p, Map.new), pl, pid)
end

defp broadcast(num, max_broadcasts, map, pl, pid) do
  peers = Map.keys(map)
  {send,_} = Map.get(map, pid)
  if send < max_broadcasts do
    newMap = updateSent(peers, map, pl, pid)
    init(num, newMap, max_broadcasts, pl, pid)
  else
    init(num, map, max_broadcasts, pl, pid)
  end
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([p|o], map) do
    newMap = Map.put(map, p, {0, 0})
    initMap(o, newMap)
end


def updateSent([], map, _, _), do: map

def updateSent([p|o], map, pl, pid) do
  send pl, { :pl_send, p, pid, :ok}
  {s,r} = Map.get(map, p)
  newMap = Map.put(map, p, {s+1, r})
  updateSent(o, newMap, pl, pid)
end


end # module -----------------------
