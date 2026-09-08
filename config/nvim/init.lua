require("config.lazy")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

-- Trigger autoread when files change on disk
vim.o.autoread = true
vim.o.updatetime = 1000
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
