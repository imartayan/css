module NodeMap = Map.Make (Int)

type 'a heap = {
  data : 'a array;
  mutable size : int;
  (* maps an index to the corresponding node *)
  node : int array;
  (* maps a node to its index in the heap *)
  mutable index : int NodeMap.t;
}

let copy h =
  let n = h.size in {
  data = Array.sub h.data 0 n;
  size = n;
  node = Array.sub h.node 0 n;
  index = h.index;
}

let is_empty h = h.size = 0

let contains h u = NodeMap.mem u h.index

let swap h i j =
  let x = h.data.(i) and y = h.data.(j) in
  h.data.(i) <- y; h.data.(j) <- x;
  let u = h.node.(i) and v = h.node.(j) in
  h.node.(i) <- v; h.node.(j) <- u;
  h.index <- NodeMap.add v i (NodeMap.add u j h.index)

let rec sift_up h i =
  let j = (i - 1) / 2 in
  if j >= 0 && h.data.(i) < h.data.(j) then (
    swap h i j;
    sift_up h j
  )

let update h u x =
  let i = NodeMap.find u h.index in
  h.data.(i) <- x;
  sift_up h i

let rec sift_down h i =
  let l = 2 * i + 1 and r = 2 * i + 2 in
  let j = if r < h.size && h.data.(r) < h.data.(l) then r else l in
  if j < h.size && h.data.(j) < h.data.(i) then (
    swap h i j;
    sift_down h j
  )

let take_min h =
  if is_empty h then failwith "empty heap";
  let u = h.node.(0) and x = h.data.(0) in
  h.size <- h.size - 1;
  swap h 0 h.size;
  h.index <- NodeMap.remove u h.index;
  sift_down h 0;
  (u, x)

let heapify g =
  let n = Array.length g in
  let id = Array.init n (fun i -> i) in
  let h = {
    data = Array.copy g;
    size = n;
    node = id;
    index = NodeMap.of_seq (Array.to_seqi id)
  } in
  for i = (n - 1) / 2 downto 0 do
    sift_down h i
  done;
  h
