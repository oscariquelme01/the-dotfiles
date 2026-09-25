def draw_title(data):
    index = data["index"]
    title = data["title"]
    session = data["session_name"]
    fmt = data["fmt"]

    if index == 1 and session:
        return f"{fmt.fg._DFDFDF}󰉋 {session}{fmt.fg.tab}   {index} -> {title}"

    return f" {index} -> {title}"
