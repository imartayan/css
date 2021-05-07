let size = 9 and sqsize = 3

let parse_grid () = Array.init (size * size) (
  fun _ -> Scanf.scanf "%d " (fun x -> x)
)

let print_grid g =
  for i = 0 to (size - 1) do
    for j = 0 to (size - 1) do
      print_int g.(i * size + j);
      if j < (size - 1) then print_char ' '
    done;
    print_newline ()
  done

let neighbours () =
  let res = Array.make (size * size) [] in
  for line = 0 to (size - 1) do
    for col = 0 to (size - 1) do
      let i = line * size + col in
      for c = 0 to (size - 1) do
        if c <> col then res.(i) <- (line * size + c)::res.(i)
      done;
      for l = 0 to (size - 1) do
        if l <> line then res.(i) <- (l * size + col)::res.(i)
      done;
      let sql = line / sqsize in
      let sqc = col / sqsize in
      for l = sql * sqsize to (sql + 1) * sqsize - 1 do
        for c = sqc * sqsize to (sqc + 1) * sqsize - 1 do
          if (l <> line && c <> col)
            then res.(i) <- (l * size + c)::res.(i)
        done
      done
    done
  done;
  res
