-- Порядок важен:
--   1. options — в том числе leader, который нужен маппингам.
--   2. lazy    — bootstrap и загрузка плагинов.
--   3. keymaps — после плагинов, чтобы не перетирать их маппинги.
require("config.options")
require("config.lazy")
require("config.keymaps")
