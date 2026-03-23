(* exercices.ml *)

(* identity *)
let id = fun x -> x ;;

(* vowel counter *)
let rec cpt_voy str = 
    let rec foo_voy i str n = 
        if i < String.length str then 
            match str.[i] with
            |'a'|'A'|'e'|'E'|'i'|'I'|'o'|'O'|'u'|'U'|'y'|'Y' -> 
                foo_voy (i+1) str n+1 
            | _ -> foo_voy (i+1) str n  (*in other cases we use _*)
        else n

        in foo_voy 0 str 0;;    (*first use*)

(* interval calculator *)
let somme_inter (a, b : float*float) (c, d : float*float) = (*pair declaration, _tuple_*)
    (a *. c , b *. d);; (* *. for the floating operation *)

(* aplication of a function squared = fof(x)*)
let puiss_2 f x = f (f x);;

let rec base8 (x:int) =
    let rec foo_convert x buff =
        if x / 8 <= 0 then
            string_of_int x ^ buff (* ^ for ensembling 2 strings *)
        else
            foo_convert (x / 8) (string_of_int (x mod 8) ^ buff)
    in foo_convert x "";;

(* define type feu that can be one of 3 options, they are in caps because they are not variables but arbitrary attributes*)
type feu = Rouge | Orange | Vert;;

let nom_feu (f: feu) : string =
    match f with
    | Rouge -> "rouge"
    | Orange -> "orange"
    | Vert -> "vert"


(* recursive tree: alpha = feuille or noeud. Each noeud has 2 other feuilles *)
type 'a arbre =     (* 'a = tree of anything *)
  | Feuille of 'a
  | Noeud of 'a arbre * 'a arbre

let rec prof_max (a : 'a arbre) : int =
  match a with
  | Feuille _ -> 1  (* if a = feuille +1 of deepness. Feuille _ indicates that we wont use its value*)
  | Noeud (g, d) -> 1 + max (prof_max g) (prof_max d)   (* else calculate the max deepness of the other noeuds *)
