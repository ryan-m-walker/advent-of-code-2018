(* read the input, split by lines and sum each frequency shift *)
let () =
  let ic = open_in "input.txt" in
  let total = ref 0 in
  (try
     while true do
       let line = input_line ic in
       if String.length line > 0 then total := !total + int_of_string line
     done
   with End_of_file -> ());
  close_in ic;
  print_int !total;
  print_newline ()
