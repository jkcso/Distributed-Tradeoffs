defmodule System06 do

def main do
  create(5, 50)
end

defp main_net do
  r = 50  #reliability
  # DISTRIBUTED RUN
  peer0 = Node.spawn(:'peer0@peer0.localdomain', Peer, :start, [0, r])
  peer1 = Node.spawn(:'peer1@peer1.localdomain', Peer, :start, [1, r])
  peer2 = Node.spawn(:'peer2@peer2.localdomain', Peer, :start, [2, r])
  peer3 = Node.spawn(:'peer3@peer3.localdomain', Peer, :start, [3, r])
  peer4 = Node.spawn(:'peer4@peer4.localdomain', Peer, :start, [4, r])

  peers = [peer0, peer1, peer2, peer3, peer4]

  for p <- peers, do: send p, { :bind, self(), peers }
  create_lpl(0, [], length(peers))
end

defp create(num, reliability) do
  peers= Enum.map(0..(num-1), fn(num) -> spawn(Peer, :start, [num, reliability]) end)
  for p <- peers, do: send p, { :bind, self(), peers }
  IO.puts("Reliability : #{reliability}" )
  create_lpl(0, [], num)
end

defp create_lpl(c, lpls, t) do
  max_broadcasts = 1000
  timeout = 3000
  receive do
  {:lp2p, peers, lpl} ->
  lpl2s = [{peers,lpl}] ++ lpls
  if c+1 == t do
    IO.puts("Max_broadcasts : #{max_broadcasts}, timeout :#{timeout}" )
    for {_, lpl} <- lpl2s, do: send lpl, {:bind, lpl2s}
    for {_, lpl} <- lpl2s, do: send lpl, {:lpl_deliver, :broadcast, max_broadcasts, timeout}
  end
  create_lpl(c+1, lpl2s, t)
end

end

end # module -----------------------
