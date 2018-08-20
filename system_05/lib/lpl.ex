# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

defmodule Lpl do

def start(beb, rlb) do
  receive do
  { :bind, lpls} ->
  map = initMap(lpls, Map.new)
  next(beb, map, rlb) # rlb = reliability
  end
end

def next(beb, map, rlb) do
  receive do
  { :lpl_deliver, :broadcast, max_broadcasts, timeout} ->
    send beb, {:lpl_deliver, :broadcast, max_broadcasts, timeout}
  { :lpl_send, quest, sender, msg} ->
    probabilistic_send(map, quest, sender, msg, rlb)
  { :lpl_transmit, pid, msg} ->
    send beb, {:lpl_deliver, pid, msg}
  end
  next(beb, map, rlb)
end

def probabilistic_send(map, quest, sender, msg, rlb) do
    # 99 so that 100% is fully reliable.
  if :rand.uniform(99) < rlb do
    lpl = Map.get(map, quest)
    send lpl, {:lpl_transmit, sender, msg}
  end
end

# ---- Map Helper Functions ----

def initMap([], map), do: map

def initMap([{p,lpl}|o], map) do
    newMap = Map.put(map, p, lpl)
    initMap(o, newMap)
end

end # module -----------------------
