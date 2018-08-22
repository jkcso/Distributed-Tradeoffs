defmodule Erb do

def start() do
  receive do
  { :bind, beb, app, peers} ->
  next(beb, app, peers, MapSet.new)
  end
end

def next(beb, app, peers, delivered) do
  receive do
  { :beb_deliver, :broadcast, max_broadcasts, timeout} ->
    send app, {:erb_deliver, :broadcast, max_broadcasts, timeout}
    next(beb, app, peers, delivered)
  { :erb_broadcast, sender, msg} ->
    send beb, {:beb_broadcast, sender, msg}
    next(beb, app, peers, delivered)
  # -- NOTE that for systems 1-5 the msg is not unique because is :ok hardcoded.
  # For testing purposes I changed this message found in app.ex line 50 to be
  # unique by being chosen randomly from a very high entropy.
  { :beb_deliver, pid, msg} ->
    if MapSet.member?(delivered, msg) do
      next(beb, app, peers, delivered)
    else
      send app, {:erb_deliver, pid, msg}
      send beb, {:beb_broadcast, pid, msg}
      next(beb, app, peers, MapSet.put(delivered, msg))
    end
  end
end

end # module -----------------------
