(*
 * Copyright (c) 2016-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
module F = Format

(** Wrappers for making pretty-printable modules *)

module type PrintableOrderedType = sig
  include Caml.Set.OrderedType

  val pp : F.formatter -> t -> unit
end

module type PPSet = sig
  include Caml.Set.S

  val pp_element : F.formatter -> elt -> unit

  val pp : F.formatter -> t -> unit
end

module type PPMap = sig
  include Caml.Map.S

  val pp_key : F.formatter -> key -> unit

  val pp : pp_value:(F.formatter -> 'a -> unit) -> F.formatter -> 'a t -> unit
end

let pp_collection ~pp_item fmt c = IContainer.pp_collection ~fold:List.fold ~pp_item fmt c

module MakePPSet (Ord : PrintableOrderedType) = struct
  include Caml.Set.Make (Ord)

  let pp_element = Ord.pp

  let pp fmt s = pp_collection ~pp_item:pp_element fmt (elements s)
end

module MakePPMap (Ord : PrintableOrderedType) = struct
  include Caml.Map.Make (Ord)

  let pp_key = Ord.pp

  let pp ~pp_value fmt m =
    let pp_item fmt (k, v) = F.fprintf fmt "%a -> %a" Ord.pp k pp_value v in
    pp_collection ~pp_item fmt (bindings m)
end
