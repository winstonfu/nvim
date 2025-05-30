local ls = require 'luasnip'
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node

local get_visual = function(args, parent, default_text)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1, default_text))
    end
end

local function v(pos, default_text)
    return d(pos, function(args, parent)
        return get_visual(args, parent, default_text)
    end)
end

return {
    s(
        { trig = 'cls', name = 'New class' },
        fmta(
            [[
            class <name>:
                def __init__(self, <args>):
                    <body>
                <next>
            ]],
            { name = i(1), args = i(2), body = i(3), next = i(0) }
        )
    ),

    s(
        { trig = 'imp-std', name = 'Import standard' },
        fmta(
            [[
            import numpy as np
            import matplotlib.pyplot as plt
            import pandas as pd
            from tqdm import tqdm, trange
            ]],
            {}
        )
    ),

    s(
        { trig = 'logger-std', name = 'Logger standard' },
        fmta(
            [[
            import logging
            logger = logging.getLogger(__name__)
            logger.setLevel(logging.DEBUG)
            ch = logging.StreamHandler()
            formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
            ch.setFormatter(formatter)
            ch.setLevel(logging.DEBUG)
            logger.addHandler(ch)
            ]],
            {}
        )
    ),

    s(
        { trig = 'logger-w-file', name = 'Logger write file' },
        fmta(
            [[
            fh = logging.FileHandler("<>")
            fh.setLevel(logging.INFO)
            fh.setFormatter(formatter)
            logger.addHandler(fh)
            ]],
            { i(1, 'logs.log') }
        )
    ),

    s({ trig = 'ds', name = 'Docstring' }, { t [[''']], t { '', '' }, v(1), t { '', '' }, t [[''']] }),

    s(
        { trig = 'ifmain', name = 'if name main' },
        fmta(
            [[
            if __name__ == "__main__":
                main()
            ]],
            {}
        )
    ),
}
