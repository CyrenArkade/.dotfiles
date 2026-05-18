{ lib }: 

rec {
  luaify = lib.generators.mkLuaInline;
  lambda = body: "function()\n${body}\nend";
  call = list: { _args = list; };
  bind_flags = keys: dispatcher: flags: [keys (luaify dispatcher) flags];
  bind = keys: dispatcher: bind_flags keys dispatcher {};
  bind_exec = keys: cmd: bind keys (''hl.dsp.exec_cmd("${cmd}")'');

  merge_flags = flags: bind:
    let
      start = lib.lists.sublist 0 2 bind;
      init_flags =
        if builtins.length bind > 2 && builtins.isAttrs (builtins.elemAt bind 2)
        then builtins.elemAt bind 2
        else {};
    in
      start ++ [(init_flags // flags)];
  with_flags = flags: binds: map (merge_flags flags) binds;

  on_startup = body: [(call ["hyprland.start" (luaify (lambda body))])];
}