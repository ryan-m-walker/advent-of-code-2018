(* read the input into a list of frequency shifts *)
let read_shifts () =
  let ic = open_in "input.txt" in
  let shifts = ref [] in
  (try
     while true do
       let line = input_line ic in
       if String.length line > 0 then shifts := int_of_string line :: !shifts
     done
   with End_of_file -> ());
  close_in ic;
  List.rev !shifts

(* cycle through the shifts, keeping a running total, until we reach a
   total we've already seen before. That repeated total is the answer. *)
let calc shifts =
  let seen = Hashtbl.create 1024 in
  let total = ref 0 in
  let found = ref None in
  Hashtbl.replace seen 0 true;
  while !found = None do
    List.iter
      (fun shift ->
        if !found = None then begin
          total := !total + shift;
          if Hashtbl.mem seen !total then found := Some !total
          else Hashtbl.replace seen !total true
        end)
      shifts
  done;
  match !found with Some n -> n | None -> 0

let () =
  let shifts = read_shifts () in
  Printf.printf "FOUND: %d\n" (calc shifts)
