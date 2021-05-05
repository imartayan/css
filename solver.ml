let neighbours : int list array = Utils.neighbours ()

module ColorSet = Set.Make (Int)

let all_colors = ColorSet.of_list [1;2;3;4;5;6;7;8;9]

let possible_colors (grid : int array) : ColorSet.t array =
  Array.map (fun l -> l
  |> List.map (Array.get grid)
  |> fun l -> List.fold_right ColorSet.remove l all_colors
  ) neighbours

exception Solution of int array
exception NoSolution

let rec explore (grid : int array) (colors : ColorSet.t array) (heap : int Heap.heap) =
  if Heap.is_empty heap then raise (Solution grid);
  let u, n = Heap.take_min heap in
  if n = 0 then raise NoSolution;
  if grid.(u) = 0 then (
    for _ = 1 to n do
      let c = ColorSet.choose colors.(u) in
      colors.(u) <- ColorSet.remove c colors.(u);
      grid.(u) <- c;
      let grid_ = Array.copy grid in
      let colors_ = Array.copy colors in
      let heap_ = Heap.copy heap in
      List.iter (fun v ->
        if Heap.contains heap_ v then (
          colors_.(v) <- ColorSet.remove c colors_.(v);
          let p = ColorSet.cardinal colors_.(v) in
          if p = 0 then raise NoSolution;
          Heap.update heap_ v p
        )
      ) neighbours.(u);
      try explore grid_ colors_ heap_ with NoSolution -> ()
    done; raise NoSolution
  ) else explore grid colors heap

let grid : int array = Utils.parse_grid ()

let colors = possible_colors grid

let heap = Heap.heapify (Array.map ColorSet.cardinal colors);;

try explore grid colors heap with
  | Solution g -> Utils.print_grid g
  | NoSolution -> print_string "There is no solution for this grid.\n"
