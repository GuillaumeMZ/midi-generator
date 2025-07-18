module type OrderedType = sig
  type t

  val compare: t -> t -> int
end

module type S = sig
  type 'a t
  type node_type

  val empty: _ t
  val add_node: node_type -> 'a -> 'a t -> 'a t
  val add_transition: node_type -> node_type -> float -> 'a t -> 'a t
  val run: node_type -> int -> 'a t -> 'a list
end

module Make(Ord: OrderedType) = struct
  module KeyMap = Map.Make(Ord)

  type node_type = Ord.t
  
  type 'a t = {
    nodes: 'a KeyMap.t;
    transitions: (node_type * node_type * float) list 
  }

  let empty = {
    nodes = KeyMap.empty;
    transitions = [];
  }

  let add_node node associated chain = {chain with nodes = KeyMap.add node associated chain.nodes}

  let add_transition from to_ weight chain = 
    assert (weight >= 0.0 && weight <= 1.0);
    {chain with transitions = (from, to_, weight) :: chain.transitions}

  let select_random_transition transitions =
    let sum_of_weigths = List.fold_left (fun acc (_, _, weight) -> acc +. weight) 0.0 transitions in
    assert (sum_of_weigths = 1.0);
    let rec inner transitions probability =
      let random_float = Random.float probability in
      match transitions with
      | [] -> failwith "Unreachable"
      | (_, _, weight) as hd :: tl -> if random_float <= weight then hd else inner tl (probability -. random_float)
    in inner transitions 1.0

  let rec run initial_state steps chain =
    assert (steps >= 0);

    if steps = 0 then [] else begin
      let possible_transitions = List.filter (fun (source, _, _) -> source = initial_state) chain.transitions in
      assert (possible_transitions <> []);
      let (source, destination, _) = select_random_transition possible_transitions in
      (KeyMap.find source chain.nodes) :: (run destination (steps - 1) chain)
    end
end