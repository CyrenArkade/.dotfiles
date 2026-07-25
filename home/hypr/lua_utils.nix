{ lib }: 

rec {
  luaify = lib.generators.mkLuaInline;
  lambda = body: "function()\n${body}\nend";
  call = list: { _args = list; };
  bind = bind_args:
    call (lib.imap0
      (i: x: if i == 1 then luaify x else x)
    bind_args);
  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';

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
