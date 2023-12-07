local ua = require("ultimate-autopair")
ua.setup()
ua.init { ua.extend_default({
  tabout = {
    enable = true,
    hopout = true,
  },
  fastwarp = {
    multi = true,
    p=20,
    {map='<A-e>', faster = false},
    {map='<A-f>', rmap='<A-F>', faster = true},
  },
})
}
