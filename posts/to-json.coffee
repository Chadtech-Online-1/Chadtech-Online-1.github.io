fs = require "fs"
_ = require "lodash"

padUntilThree = (number) ->
    if number.length is 3 
        number
    else
        padUntilThree ("0" + number)


posts = _.map _.range(16), (post) ->
    post = (padUntilThree (String post)) + ".txt"
    post = fs.readFileSync post, "utf-8"
    post = post.split "|||"

    json = 
        title: post[ 0 ]
        date: post[ 1 ]
        body: post.slice 2

    json.body = _.map json.body, (p) ->
        type = p.slice 0, 1

        if type is "n"
            type = "normal"
        else
            type = "logic"


        body = (p.slice 1).split "\n"
        body = _.filter body, (str) ->
            str isnt ""


        content: body
        type: type

    json


_.forEach posts, (post, i) ->
    fn = (padUntilThree (String i)) + ".json" 
    fs.writeFileSync fn, (JSON.stringify post, null, 2)