import DAC

defmodule App do

def start(num) do
  IO.puts ["      Peer at ", node_ip_addr(), "  PID: #{self_string()}"]
  receive do
  { :bind, peers, beb, pid} ->

  # determines that peer3 is the one who needs to terminate
    if pid == Enum.at(peers, 3) do
      # self termination after 5ms
      Process.send_after(self(), :term, 5)
    end

  map = initMap(peers, Map.new)
  next(num, map, beb, pid)

  # Necessary to capture termination message asynchronously
  :term -> Process.exit(self(), "Terminating Peer3")
  end
end

def next(num, map, beb, pid) do
  receive do
  { :beb_deliver, :broadcast, max_broadcasts, timeout} ->
  Process.send_after(self(), :dest, timeout)
  init(num, map, max_broadcasts, beb, pid)

  # Necessary to capture termination message asynchronously
  :term -> Process.exit(self(), "Terminating Peer3")
  end
end

defp init(num, map, max_broadcasts, beb, pid) do
  receive do
  { :beb_deliver, p, _} ->
      {s,r} = Map.get(map, p)
      newMap = Map.put(map, p, {s, r+1})
      init(num, newMap, max_broadcasts, beb, pid)
  :dest -> timeout(num, map, beb, pid)

  # Necessary to capture termination message asynchronously
  :term -> Process.exit(self(), "Terminating Peer3")

  after 0 -> broadcast(num, max_broadcasts, map, beb, pid)
  end
end

defp timeout(num, map, beb, pid) do
  val = Map.values(map)
  sval = for v <- val, do: inspect(v)
  IO.puts("#{num} : #{Enum.join(sval, " ")} " )
  p = Map.keys(map)
  next(num, initMap(p, Map.new), beb, pid)
end

defp broadcast(num, max_broadcasts, map, beb, pid) do
  peers = Map.keys(map)
  {send,_} = Map.get(map, pid)
  if send < max_broadcasts do
    send beb, {:beb_broadcast, pid, :ok}
    newMap = updateSent(peers, map, beb, pid)
    init(num, newMap, max_broadcasts, beb, pid)
  else
    init(num, map, max_broadcasts, beb, pid)
  end
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([p|o], map) do
    newMap = Map.put(map, p, {0, 0})
    initMap(o, newMap)
end


def updateSent([], map, _, _), do: map

def updateSent([p|o], map, beb, pid) do
  {s,r} = Map.get(map, p)
  newMap = Map.put(map, p, {s+1, r})
  updateSent(o, newMap, beb, pid)
end


end # module -----------------------
