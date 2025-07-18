module type OrderedType = sig
    type t

    val compare: t -> t -> int
end

module type S = sig 
    (** The type representing a Markov chain parametrized by the type associated to a node. *)
    type 'a t

    (** The type of a node of a Markov chain. *)
    type node_type

    (** [empty] is an empty Markov chain: no node, no transition. *)
    val empty: _ t

    (** [add_node node associated chain] add [node] to [chain] (iff it doesn't already exist) with [associated] being the associated value of the node. *)
    val add_node: node_type -> 'a -> 'a t -> 'a t
    
    (** [add_transition from to_ weight chain] adds a transition going from [from] to [to_] with weight [weight].
        [weight] must be <= 1, otherwise this fails. *)
    val add_transition: node_type -> node_type -> float -> 'a t -> 'a t

    (** [run initial_state steps chain] collects the result of stepping [steps] times in the Markov chain [chain]. *)
    val run: node_type -> int -> 'a t -> 'a list
end

(** Functor building an implementation of a Markov chain given a totally ordered type. *)
module Make(Ord: OrderedType): S with type node_type := Ord.t