```
,ggggggggggg,                                                  ,ggggggggggggggg
dP"""88""""""Y8,             ,dPYb, ,dPYb,                     dP""""""88"""""""
Yb,  88      `8b             IP'`Yb IP'`Yb                     Yb,_    88
 `"  88      ,8P             I8  8I I8  8I                      `""    88
     88aaaad8P"              I8  8' I8  8'                             88
     88""""Y8ba  gg      gg  I8 dP  I8 dP   ,ggg,    ,gggggg,          88  ,gggggg,   ,ggg,    ,ggg,
     88      `8b I8      8I  I8dP   I8dP   i8" "8i   dP""""8I          88  dP""""8I  i8" "8i  i8" "8i
     88      ,8P I8,    ,8I  I8P    I8P    I8, ,8I  ,8'    8I    gg,   88 ,8'    8I  I8, ,8I  I8, ,8I
     88_____,d8',d8b,  ,d8b,,d8b,_ ,d8b,_  `YbadP' ,dP     Y8,    "Yb,,8P,dP     Y8, `YbadP'  `YbadP'
    88888888P"  8P'"Y88P"`Y8PI8"888PI8"888888P"Y8888P      `Y8      "Y8P'8P      `Y8888P"Y888888P"Y888
                             I8 `8, I8 `8,
                             I8  `8,I8  `8,
                             I8   8II8   8I
                             I8   8II8   8I
                             I8, ,8'I8, ,8'
                              "Y8P'  "Y8P'
```
<h1>buffer-tree</h1>
A vim-plugin for rendering your buffer-list as an ascii-tree, written entirely in Vimscript.


<h2>Why?</h2>
I am a fan of both <a href='https://github.com/jceb/vmux'>vmux</a> and <a href='https://github.com/tpope/vim-obsession'>vim-obsession</a>, so I often have a *lot* of vim-buffers open at once. Sometimes it can be hard to parse where all of my buffers are using the ``:buffers`` command because the buffers are often listed in an inconvenient order, and the paths are quite long. As an example:

```
:buffers
  1  h   "~/.config/nvim/init.vim"      line 234
 22  h   "~/.config/nvim/demo.txt"      line 1
 23  h   "plugin/tree.py"               line 27
 25  h   "~/.config/nvim/autoload/plug.vim" line 563
 27 #h   "plugin/buffer-tree.vim"       line 91
 28 %a   "README.md"                    line 35
```

``BufferTree`` lets you view your vim-buffers in an ascii-tree format instead.

```
:BufferTree
└─ home
   └─ el
      ├─ personal
      │  └─ vim
      │     └─ buffer-tree
      │        ├─ README.md ⇒ 28
      │        └─ plugin
      │           ├─ tree.py ⇒ 23
      │           └─ buffer-tree.vim ⇒ 27
      └─ .config
         └─ nvim
            ├─ demo.txt ⇒ 22
            ├─ autoload
            │  └─ plug.vim ⇒ 25
            └─ init.vim ⇒ 1
```

Note that the numbers after the arrow next to each file represent the buffer numbers of each file.

<h2>Installation</h2>

Add this line to your `init.vim` / `.vimrc` file (though you may need to modify it slightly if you use a different plugin manager.
```
Plug 'el-iot/buffer-tree.vim'
```

<h2>Usage</h2>
All you need is the ``BufferTree`` command.

<h2>Configuration</h2>

<h3> Compressing the BufferTree </h3>
Sometimes your buffers will be very sparse and the ``BufferTree`` will look a little large for so few files.
As an example,

```
└─ home
   └─ el
      ├─ personal
      │  ├─ vim
      │  │  └─ buffer-tree
      │  │     ├─ README.md ⇒ 2
      │  │     └─ plugin
      │  │        └─ buffer-tree.vim ⇒ 3
      │  └─ repos
      │     └─ themerator
      │        └─ themerator.py ⇒ 14
      └─ .config
         └─ nvim
            ├─ plugged
            │  ├─ buffer-tree
            │  │  └─ plugin
            │  │     └─ buffer-tree.vim ⇒ 4
            │  └─ buffer-minimalism
            │     └─ plugin
            │        └─ buffer-minimalism.vim ⇒ 10
            └─ init.vim ⇒ 1
```

This is a little inconvenient, as a lot of vertical space is taken up by directories with no buffers.
You can set ``g:buffertree_compress`` to 1 to "compress" your trees where possible. In this case, the tree above would look like

```
└─ home/el
   ├─ .config/nvim
   │  ├─ plugged
   │  │  ├─ buffer-minimalism/plugin/buffer-minimalism.vim ⇒ 10
   │  │  └─ buffer-tree/plugin/buffer-tree.vim ⇒ 4
   │  └─ init.vim ⇒ 1
   └─ personal
      ├─ repos/themerator/themerator.py ⇒ 14
      └─ vim/buffer-tree
         ├─ README.md ⇒ 2
         └─ plugin/buffer-tree.vim ⇒ 3

```

<h3>Highlight groups</h3>
The plugin uses a highlight group ``BufferTreeFile`` to highlight files to make it easier to parse the relevant parts of the tree.

<h2>Contributing</h2>
Please do! If you find the plugin useful then any contributions are welcome. Things that need doing:<br>
 - add line number and column number for each buffer
