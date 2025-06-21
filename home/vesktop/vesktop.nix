{ inputs, config, ... }:

{

  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    quickCss = builtins.readFile ./quick.css;
    discord.enable = false;

    vesktop = {
      enable = true;
      autoscroll.enable = true;
      # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
      settings = {
        discordBranch = "canary";
        arRPC = true;
        minimizeToTray = true;
      };
    };

    # ~/.config/vesktop/settings/settings.json for all options
    config = {
      themeLinks = [
        "https://cdn.jsdelivr.net/gh/Overimagine1/old-discord-font/source.css"
        "https://catppuccin.github.io/discord/dist/catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}.theme.css"
      ];
      transparent = false;
      useQuickCss = true;
      plugins = {
        alwaysExpandRoles.enable = true;
        alwaysTrust.enable = true;
        betterUploadButton.enable = true;
        copyFileContents.enable = true;
        # expressionCloner.enable = true;
        fixCodeblockGap.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        keepCurrentChannel.enable = true;
        noF1.enable = true;
        noMosaic.enable = true;
        noUnblockToJump.enable = true;
        petpet.enable = true;
        roleColorEverywhere.enable = true;
        shikiCodeblocks.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        viewIcons.enable = true;
        webKeybinds.enable = true;
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;

        noReplyMention = {
          enable = true;
          userList = "1234567890123445,1234567890123445";
          shouldPingListed = true;
          inverseShiftReply = true;
        };
        typingIndicator = {
          enable = true;
          indicatorMode = "animatedDots";
          includeMutedChannels = true;
        };
        typingTweaks = {
          enable = true;
          showAvatars = false;
        };
      };
    };
  };

}