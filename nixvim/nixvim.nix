{ config, lib, ... }:
{
  imports = [
    ./autocommands.nix
    ./keys.nix
    ./sets.nix
    ./highlight.nix

    ./plug/colorscheme/colorscheme.nix

    ./plug/completion/blink.nix
    ./plug/completion/cmp.nix
    ./plug/completion/copilot-cmp.nix
    ./plug/completion/codecompanion.nix
    ./plug/completion/schemastore.nix

    ./plug/git/gitblame.nix
    ./plug/git/gitlinker.nix
    ./plug/git/gitsigns.nix
    ./plug/git/lazygit.nix
    ./plug/git/worktree.nix

    ./plug/lsp/conform.nix
    ./plug/lsp/fidget.nix
    ./plug/lsp/lsp.nix
    ./plug/lsp/lspsaga.nix
    ./plug/lsp/none-ls.nix
    ./plug/lsp/trouble.nix

    ./plug/mini

    ./plug/snippets/luasnip.nix

    ./plug/statusline/lualine.nix
    #./plug/statusline/staline.nix

    ./plug/treesitter/treesitter-context.nix
    ./plug/treesitter/treesitter-textobjects.nix
    ./plug/treesitter/treesitter.nix

    ./plug/ui/alpha.nix
    # ./plug/ui/btw.nix
    ./plug/ui/bufferline.nix
    ./plug/ui/dressing.nix
    ./plug/ui/indent-blankline.nix
    ./plug/ui/noice.nix
    ./plug/ui/nvim-notify.nix
    #./plug/ui/precognition.nix
    ./plug/ui/smart-splits.nix
    ./plug/ui/telescope.nix

    ./plug/utils/auto-session.nix
    ./plug/utils/colorizer.nix
    ./plug/utils/comment-box.nix
    ./plug/utils/comment.nix
    ./plug/utils/flash.nix
    ./plug/utils/grapple.nix
    ./plug/utils/hardtime.nix
    ./plug/utils/harpoon.nix
    ./plug/utils/illuminate.nix
    ./plug/utils/markview.nix
    ./plug/utils/obsidian.nix
    ./plug/utils/oil.nix
    ./plug/utils/spectre.nix
    ./plug/utils/trunk.nix
    ./plug/utils/ufo.nix
    ./plug/utils/undotree.nix
    ./plug/utils/whichkey.nix
    ./plug/utils/yaml-companion.nix
  ];
  options = {
    theme = lib.mkOption {
      default = lib.mkDefault "paradise";
      type = lib.types.enum [
        "paradise"
        "decay"
        "edge-dark"
        "mountain"
        "tokyonight"
        "everforest"
        "everblush"
        "jellybeans"
        "aquarium"
        "gruvbox"
        "oxocarbon"
      ];
    };
    assistant = lib.mkOption {
      default = "none";
      type = lib.types.enum [
        "copilot"
        "none"
      ];
    };
  };
  config = {
    # The base16 theme to use, if you want to use another theme, change it in colorscheme.nix
    theme = "paradise";
    extraConfigLua = ''
      _G.theme = "${config.theme}"
    '';
  };
}
