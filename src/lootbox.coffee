{ config } = require "dotenv"
config()
token = process.env.TOKEN
x_super = client_build_number: 280346
stringify = JSON.stringify x_super
bytes = new TextEncoder().encode stringify
main = ->
  fetch "https://discord.com/api/v9/users/@me/lootboxes/open", 
                    method: "POST"
                    headers: 
                      'Authorization': token 
                      'X-Super-Properties': btoa String.fromCharCode.apply null, bytes
          .then (r) -> r.json().then (d) ->
                                console.log d.opened_item if d.opened_item
                                return main() unless d.retry_after
                                setTimeout main, d.retry_after * 1000
main()