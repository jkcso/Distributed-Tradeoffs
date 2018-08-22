import DAC

defmodule System01 do

def main do
  create(5)
end

defp create(n) do
  max_broadcasts = 1000
  timeout =3000

  # LOCAL RUN
  peers= Enum.map(0..(n-1), fn(n) -> spawn(Peer, :start, [n]) end)
  IO.puts("Max_broadcasts : #{max_broadcasts}, timeout :#{timeout}" )

  for p <- peers, do: send p, { :bind, peers }
  for p <- peers, do: send p, { :broadcast, max_broadcasts, timeout }
end

defp main_net do
  # DISTRIBUTED RUN
  peer0 = Node.spawn(:'peer0@peer0.localdomain', Peer, :start, [0])
  peer1 = Node.spawn(:'peer1@peer1.localdomain', Peer, :start, [1])
  peer2 = Node.spawn(:'peer2@peer2.localdomain', Peer, :start, [2])
  peer3 = Node.spawn(:'peer3@peer3.localdomain', Peer, :start, [3])
  peer4 = Node.spawn(:'peer4@peer4.localdomain', Peer, :start, [4])

  max_broadcasts = 1000
  timeout =3000
  peers = [peer0, peer1, peer2, peer3, peer4]

  IO.puts("Max_broadcasts : #{max_broadcasts}, timeout :#{timeout}" )

  for p <- peers, do: send p, { :bind, peers }
  for p <- peers, do: send p, { :broadcast, max_broadcasts, timeout }
end


end
