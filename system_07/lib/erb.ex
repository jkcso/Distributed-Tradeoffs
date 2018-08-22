defmodule Erb do

def start() do
  receive do
  { :bind, beb, app, peers} ->
  process_msgs = Map.new(peers, fn p -> {p, MapSet.new} end)
  next(beb, app, peers, process_msgs)
  end
end

def next(beb, app, correct, process_msgs) do
  receive do
  { :beb_deliver, :broadcast, max_broadcasts, timeout} ->
    send app, {:erb_deliver, :broadcast, max_broadcasts, timeout}
    next(beb, app, correct, process_msgs)
      
  { :erb_broadcast, sender, msg} ->
    send beb, {:beb_broadcast, sender, msg}
    next(beb, app, correct, process_msgs)
      
  { :pfd_crash, crashed_pid } ->
    for msg <- process_msgs[crashed_pid], do:
      send beb, { :beb_broadcast, crashed_pid, msg }
      next(beb, app, MapSet.delete(correct, crashed_pid), process_msgs)  
      
  { :beb_deliver, pid, msg} ->
    if MapSet.member?(process_msgs[pid], msg) do
      next(beb, app, correct, process_msgs)          
    else 
      send app, {:erb_deliver, pid, msg}
      
      sender_msgs = MapSet.put(process_msgs[pid], msg)    
      process_msgs = Map.put(process_msgs, pid, sender_msgs)    

      unless Enum.member?(correct, pid) do
        send beb, { :beb_deliver, pid, msg }          
      end
      next(beb, app, correct, process_msgs)                    
    end
  end
end

end # module -----------------------
