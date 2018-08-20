# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

defmodule Pl do

def start(beb) do
  receive do
  { :bind, pls} ->
  map = initMap(pls, Map.new)
  next(beb, map)
  end
end

def next(beb, map) do
  receive do
  { :pl_deliver, :broadcast, max_broadcasts, timeout} ->
    send beb, {:pl_deliver, :broadcast, max_broadcasts, timeout}
  { :pl_send, quest, sender, msg} ->
    pl = Map.get(map, quest)
    send pl, {:pl_transmit, sender, msg}
  { :pl_transmit, pid, msg} ->
    send beb, {:pl_deliver, pid, msg}
  end
  next(beb, map)
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([{p,pl}|o], map) do
    newMap = Map.put(map, p, pl)
    initMap(o, newMap)
end

end # module -----------------------
