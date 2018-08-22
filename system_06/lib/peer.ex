defmodule Peer do

def start(n,r) do
  receive do
  { :bind, system06, peers} ->
  app = spawn(App, :start, [n])
  erb = spawn(Erb, :start, [])
  beb = spawn(Beb, :start, [])
  lpl = spawn(Lpl, :start, [beb, r]) # reliability parameter

  send app, {:bind, peers, erb, self()}
  send erb, {:bind, beb, app, peers}
  send beb, {:bind, lpl, erb, peers}
  send system06, {:lp2p, self(), lpl}
  end
end

end # module -----------------------
