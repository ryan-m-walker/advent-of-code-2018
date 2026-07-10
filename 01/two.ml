(* Day 1, Part 2: find the first frequency reached twice, cycling through the
   list of changes repeatedly. *)

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

let calc changes =
  let seen = Hashtbl.create 1024 in
  (* Cycle through the changes until a frequency repeats. [total] carries over
     between passes, so we keep folding over the same list each loop. *)
  let rec loop total =
    let rec step total = function
      | [] -> loop total
      | change :: rest ->
        if Hashtbl.mem seen total then total
        else begin
          Hashtbl.replace seen total ();
          step (total + change) rest
        end
    in
    step total changes
  in
  loop 0

let () =
  let changes = List.map int_of_string (read_lines "input.txt") in
  Printf.printf "%d\n" (calc changes)
