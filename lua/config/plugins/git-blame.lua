return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = "           <author> • <date> • <summary> ",
      date_format = "%d %b %Y",
      virtual_text_column = 100,
      delay = 1000,
    },
  }
}
