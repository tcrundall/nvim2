local jdtls_config = require("config.lsp-jdtls").setup()
local pkg_status, jdtls = pcall(require, "jdtls")
if not pkg_status then
  vim.notify("unable to load nvim-jdtls", vim.log.levels.ERROR)
  return
end
-- -- Comment this line out to not enable java lsp
-- jdtls.start_or_attach(jdtls_config)
