defmodule Pl do

def start(app) do
  receive do
  { :bind, pls} ->
  map = initMap(pls, Map.new)
  next(app, map)
  end
end

def next(app, map) do
  receive do
  { :pl_deliver, :broadcast, max_broadcasts, timeout} ->
    send app, {:pl_deliver, :broadcast, max_broadcasts, timeout}
  { :pl_send, quest, sender, msg} ->
    pl = Map.get(map, quest)
    send pl, {:pl_transmit, sender, msg}
  { :pl_transmit, pid, msg} ->
    send app, {:pl_deliver, pid, msg}
  end
  next(app, map)
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([{p,pl}|o], map) do
    newMap = Map.put(map, p, pl)
    initMap(o, newMap)
end

end # module -----------------------
