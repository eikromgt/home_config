-- leetcode.nvim — an application, not a text-editor feature, so it lives here
-- rather than in init.lua. Auto-sourced by Neovim at startup (`plugin/` files
-- are loaded automatically; `lua/` files are not).

local leetcodeCppBeforeInjection = [[
#include <iostream>
#include <string>
#include <stdint.h>
#include <memory>
#include <cmath>
#include <random>
#include <vector>
#include <list>
#include <array>
#include <map>
#include <unordered_map>
#include <set>
#include <unordered_set>
#include <queue>
#include <stack>
#include <bitset>
#include <limits>
#include <utility>
#include <algorithm>
#include <functional>
#include <mutex>
#include <ranges>
#include <print>
using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

struct TreeNode {
 int val;
 TreeNode *left;
 TreeNode *right;
 TreeNode() : val(0), left(nullptr), right(nullptr) {}
 TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};
]]

local leetcodePythonBeforeInjection = [[
from typing import Optional
from typing import List
import collections
import itertools
import math
import heapq
import bisect
import copy
import numpy
import random
]]

local leetcodeGoBeforeInjection = [[
package main

import (
    "fmt"
    "strings"
    "math"
    "math/bits"
)

type TreeNode struct {
  Val int
  Left *TreeNode
  Right *TreeNode
}
]]

-- nui.nvim is only used by leetcode, so install it here rather than in init.lua.
vim.pack.add({
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/kawre/leetcode.nvim",
}, { confirm = false })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "leetcode.nvim",
    callback = function()
        vim.cmd("Copilot disable")
    end,
})

require("leetcode").setup({
    arg = "leetcode",
    lang = "golang",
    cn = {
        enabled = true,
        translator = false,
        translate_problems = false,
    },
    injector = {
        ["cpp"] = { before =  { leetcodeCppBeforeInjection }},
        ["python3"] = { before =  { leetcodePythonBeforeInjection }},
        ["golang"] = { before =  { leetcodeGoBeforeInjection }},
    }
})

vim.keymap.set("n", "<Leader>ll", "<Cmd>Leet list<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>li", "<Cmd>Leet inject<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lr", "<Cmd>Leet reset<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lt", "<Cmd>Leet test<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ls", "<Cmd>Leet submit<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lc", "<Cmd>Leet console<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lh", "<Cmd>Leet hints<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lm", "<Cmd>Leet menu<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lp", "<Cmd>Leet lang<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ld", "<Cmd>Leet daily<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lq", "<Cmd>Leet exit<CR>", { noremap = true })
