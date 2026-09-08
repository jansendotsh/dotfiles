return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<C-s>", "<cmd>MarkdownPreview<CR>", desc = "Markdown Preview", ft = "markdown" },
  },
  config = function()
    vim.g.mkdp_auto_close = 1        -- auto close preview when leaving markdown buffer
    vim.g.mkdp_refresh_slow = 0      -- refresh in real time
    vim.g.mkdp_open_to_the_world = 0 -- only accessible locally
  end,
} 
