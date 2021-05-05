type 'a heap

val copy : 'a heap -> 'a heap

val is_empty : 'a heap -> bool

val contains : 'a heap -> int -> bool

(** update a node with a smaller value *)
val update : 'a heap -> int -> 'a -> unit

val take_min : 'a heap -> int * 'a

(** build a heap from an array in linear time *)
val heapify : 'a array -> 'a heap
