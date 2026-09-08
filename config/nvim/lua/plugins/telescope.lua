return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", ":Telescope find_files<CR>",  mode = "n", desc = "Find files" },
      { "<C-f>", ":Telescope live_grep<CR>",   mode = "n", desc = "Search in files" },
      { "<C-b>", ":Telescope buffers<CR>",     mode = "n", desc = "List buffers" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
    },
  }
}
