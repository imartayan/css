let neighbours : int list array = Utils.neighbours ()

module ColorSet = Set.Make (Int)

let all_colors = ColorSet.of_seq (Array.to_seq (Array.init Utils.size (fun i -> i)))

let possible_colors (grid : int array) : ColorSet.t array =
  Array.map (fun l -> l
  |> List.map (Array.get grid)
  |> fun l -> List.fold_right ColorSet.remove l all_colors
  ) neighbours

exception Solution of int array
exception NoSolution

let rec explore (grid : int array) (colors : ColorSet.t array) (heap : int Heap.heap) =
  if Heap.is_empty heap then raise (Solution grid);
  let i, n = Heap.take_min heap in
  if n = 0 then raise NoSolution;
  if grid.(i) = 0 then (
    for k = 1 to n do
      let c = ColorSet.choose colors.(i) in
      grid.(i) <- c;
      colors.(i) <- ColorSet.remove c colors.(i);
      let grid_ = if k = n then grid else Array.copy grid in
      let colors_ = if k = n then colors else Array.copy colors in
      let heap_ = if k = n then heap else Heap.copy heap in
      List.iter (fun j ->
        if Heap.contains heap_ j then (
          colors_.(j) <- ColorSet.remove c colors_.(j);
          let p = ColorSet.cardinal colors_.(j) in
          if p = 0 then raise NoSolution;
          Heap.update heap_ j p
        )
      ) neighbours.(i);
      try explore grid_ colors_ heap_ with NoSolution -> ()
    done; raise NoSolution
  ) else explore grid colors heap

let grid : int array = Utils.parse_grid ()
let colors = possible_colors grid
let heap = Heap.heapify (Array.map ColorSet.cardinal colors);;

try explore grid colors heap with
  | Solution g -> Utils.print_grid g
  | NoSolution -> print_string "There is no solution for this grid.\n"
