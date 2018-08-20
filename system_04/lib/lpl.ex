# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

import DAC

defmodule Lpl do

def start(beb, r) do
  receive do
  { :bind, lpls} ->
  map = initMap(lpls, Map.new)
  next(beb, map, r)
  end
end

def next(beb, map, r) do
  receive do
  { :lpl_deliver, :broadcast, max_broadcasts, timeout} ->
    send beb, {:lpl_deliver, :broadcast, max_broadcasts, timeout}
  { :lpl_send, quest, sender, msg} ->
    number = random(100)
    if r >= number do
      lpl = Map.get(map, quest)
      send lpl, {:lpl_transmit, sender, msg}
    end
  { :lpl_transmit, pid, msg} ->
    send beb, {:lpl_deliver, pid, msg}
  end
  next(beb, map, r)
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([{p,lpl}|o], map) do
    newMap = Map.put(map, p, lpl)
    initMap(o, newMap)
end

end # module -----------------------
