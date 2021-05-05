let parse_grid () = Array.init 81 (
  fun _ -> Scanf.scanf "%d " (fun x -> x)
)

let print_grid g =
  for i = 0 to 8 do
    for j = 0 to 8 do
      print_int g.(i * 9 + j);
      if j < 8 then print_char ' '
    done;
    print_newline ()
  done

let neighbours () =
  let res = Array.make 81 [] in
  for line = 0 to 8 do
    for col = 0 to 8 do
      let i = line * 9 + col in
      for c = 0 to 8 do
        if c <> col then res.(i) <- (line * 9 + c)::res.(i)
      done;
      for l = 0 to 8 do
        if l <> line then res.(i) <- (l * 9 + col)::res.(i)
      done;
      let sql = line / 3 in
      let sqc = col / 3 in
      for l = sql * 3 to sql * 3 + 2 do
        for c = sqc * 3 to sqc * 3 + 2 do
          if (l <> line && c <> col)
            then res.(i) <- (l * 9 + c)::res.(i)
        done
      done
    done
  done;
  res
