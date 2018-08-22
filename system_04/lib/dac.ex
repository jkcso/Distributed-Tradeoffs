defmodule DAC do

def lookup name do
  addresses = :inet_res.lookup name, :in, :a
  {a, b, c, d} = hd addresses   # get octets for 1st ipv4 address
  :"#{a}.#{b}.#{c}.#{d}"
end

def node_ip_addr do
  {:ok, interfaces} = :inet.getif()		# get interfaces
  {address, _gateway, _mask}  = hd interfaces	# get data for 1st interface
  {a, b, c, d} = address   			# get octets for address
  "#{a}.#{b}.#{c}.#{d}"
end

def elixir_node "", _ do   # return local elixir node
  node()
end

def elixir_node name, n do
  :'#{name}#{n}@#{name}#{n}.localdomain'
end

def node_spawn where, k, module, function, args do
  Node.spawn elixir_node(where, k), module, function, args
end

# ----

def pid_string(pid) when is_pid(pid), do: inspect(pid)

def self_string, do: inspect self()

# ----

def args, do: System.argv

def int_args do
  for arg <- System.argv, do: String.to_integer(arg)
end

# ----

def random(n), do: Enum.random 1..n

def sqrt(x), do: :math.sqrt x


end # module -----------------------
