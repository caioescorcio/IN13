let version = "0.01" ;;

let usage () =
  Printf.eprintf
    "Usage: %s [file]\n\tRead a CSH program from file (default is stdin)\n%!"
    Sys.argv.(0);
  exit 1
;;

let main () =
  let input_channel =
    match Array.length Sys.argv with
    | 1 -> stdin
    | 2 ->
        (match Sys.argv.(1) with
         | "-"  -> stdin
         | name ->
             (try open_in name
              with _ ->
                Printf.eprintf "Opening %s failed\n%!" name; exit 1))
    | _ -> usage ()
  in
  Printf.printf "        Welcome to CaioSHell, version %s\n%!" version;
  let lexbuf = Lexing.from_channel input_channel in
  let env = ref [] in
  while true do
    (try
       Printf.printf "csh @ > %!";
       let e = Cshparse.main Cshlex.lex lexbuf in
       let (_, new_env) = Cshinterp.eval e !env in
       env := new_env
     with
     | Cshlex.Eoi ->
         Printf.printf "Bye bye.\n%!"; exit 0
     | Failure msg ->
         Printf.eprintf "Error: %s\n\n%!" msg
     | Parsing.Parse_error ->
         let sp = Lexing.lexeme_start_p lexbuf in
         let ep = Lexing.lexeme_end_p lexbuf in
         Format.printf
           "File %S, line %i, characters %i-%i: Syntax error.\n"
           sp.Lexing.pos_fname
           sp.Lexing.pos_lnum
           (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
           (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
     | Cshlex.LexError (sp, ep) ->
         Printf.printf
           "File %S, line %i, characters %i-%i: Lexical error.\n"
           sp.Lexing.pos_fname
           sp.Lexing.pos_lnum
           (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
           (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
     | Unix.Unix_error (err, fn, _) ->
         Printf.eprintf "%s: %s\n%!" fn (Unix.error_message err))
  done
;;

if !Sys.interactive then () else main ();;
