-module(minimal_app).
-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

start() -> application:start(minimal_app).

start(_Type, _Args) ->
	minimal_sup:start_link().

stop(_State) ->
	ok.
