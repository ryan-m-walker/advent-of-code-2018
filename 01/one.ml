(* Day 1, Part 1: sum all the frequency changes. *)

let read_lines filename =
  let ic = open_in filename in
  let rec loop acc =
    match input_line ic with
    | line -> loop (line :: acc)
    | exception End_of_file ->
      close_in ic;
      List.rev acc
  in
  loop []

let calc lines =
  List.fold_left (fun total line -> total + int_of_string line) 0 lines

let () =
  let lines = read_lines "input.txt" in
  Printf.printf "%d\n" (calc lines)
