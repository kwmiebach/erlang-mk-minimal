Generating a minimal erlang release using kerl, erlang.mk and relx
==================================================================

Using the demo "poke" application by Richard Jones: https://github.com/RJ/erlang_rebar_example_project/tree/v1

The original instructions, using rebar instad of erlang.mk: http://www.metabrew.com/article/erlang-rebar-tutorial-generating-releases-upgrades

Why use erlang.mk: https://medium.com/@jlouis666/why-i-use-erlang-mk-708597c0dd08

About erlang.mk (and relx):
- https://github.com/ninenines/erlang.mk/blob/master/README.md
- http://ninenines.eu/articles/erlang.mk-and-relx/

To download erlang.mk into an application root folder:

    $ curl -O https://raw.githubusercontent.com/ninenines/erlang.mk/master/erlang.mk

Step 1 - creating an erlang virtual environment with kerl:
---------------------------------------------------------

Kerl should be installed and on your path.

    $ kerl list builds
    17.1,17.1
    17.1,17.1crypto64
    R14B03,R14B03

We already have 3 builds available on this machine. See https://github.com/yrashk/kerl for how to create builds.

Create a new erlang virtual environment, using the 17.1crypto64 build:

    $ kerl install 17.1crypto64 mk-demo
    $ cd mk-demo
    $ . activate

Step 2 - get the demo application:
---------------------------------

    $ mkdir apps
    $ cd apps
    $ git clone git@github.com:kwmiebach/erlang-mk-minimal.git
    $ mv erlang-mk-minimal minimal
    $ cd minimal

The makefile "Makefile" just defines the project and includes erlang.mk,
the makefile and erlang.mk are already there:

    $ ls
    erlang.mk  Makefile  README.md  src

Get help:

    $ make help

Step 3 - develop / compile / run :
---------------------------------

Compile:

    $ make

Starting an erlang shell:

    $ erl -pa ebin  -s minimal_app

    1> application:loaded_applications().
    [{kernel,"ERTS  CXC 138 10","3.0.1"},
     {stdlib,"ERTS  CXC 138 10","2.1"}]

    2> application:load(minimal).    
    ok

    3> application:start(minimal).
    ok

    4> application:loaded_applications().
    [{kernel,"ERTS  CXC 138 10","3.0.1"},
     {minimal,[],"0.1.0"},
     {stdlib,"ERTS  CXC 138 10","2.1"}]

    5> minimal_app_server:poke().
    {ok,1}
    6> minimal_app_server:poke().
    {ok,2}
    7> minimal_app_server:poke().
    {ok,3}

    8> minimal_app_server:num_pokes(). 
    3

    9> application:stop(minimal).        
    ok

    10> 
    =INFO REPORT==== 8-Feb-2015::21:00:59 ===
        application: minimal
        exited: stopped
        type: temporary


    11> q().
    ok

Step 4 - creating an erlang "release":
-------------------------------------

    $ make bootstrap-rel

From now on running "make" will also build the erlang release
and relx ist downloaded automatically when we do this for the first time.

The erlang release can be found at _rel/minimal_release/
