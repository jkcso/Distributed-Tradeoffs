# Joseph KATSIOLOUDES (jk2714) and Ben Sheng TAN (bst15)

# DISTRIBUTED RUN
# import DAC

defmodule Peer do

def start(n,r) do
  receive do
  { :bind, system07lazy, peers} ->
  app = spawn(App, :start, [n])
  erb = spawn(Erb, :start, [])
  beb = spawn(Beb, :start, [])
  pfd = spawn(Pfd, :start, [])
  lpl = spawn(Lpl, :start, [beb, pfd, r])

  # DISTRIBUTED RUN
  # app = Node.spawn(:'app@app.localdomain', App, :start, [n])
  # beb = Node.spawn(:'beb@beb.localdomain', Beb, :start, [])
  # erb = Node.spawn(:'erb@erb.localdomain', Erb, :start, [])
  # pfd = Node.spawn(:'pfd@pfd.localdomain', Pfd, :start, [])
  # lpl = Node.spawn(:'lpl@lpl.localdomain', Lpl, :start, [beb, pfd, r])

  send app, {:bind, peers, erb, self()}
  send erb, {:bind, beb, app, peers}
  send beb, {:bind, lpl, erb, peers}
  send pfd, {:bind, app, lpl, peers, 4_000} # last param is PFD timeout
  send system07lazy, {:lp2p, self(), lpl}
  end
end

end # module -----------------------
