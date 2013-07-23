%%%-------------------------------------------------------------------
%%% @copyright (C) 2010-2013, 2600Hz
%%% @doc
%%%
%%% @end
%%% @contributors
%%%   James Aimonetti
%%%-------------------------------------------------------------------
-module(cdr_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, start_v3_migrate/0]).

%% Supervisor callbacks
-export([init/1]).

-include("cdr.hrl").

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({'local', ?MODULE}, ?MODULE, []).

start_v3_migrate() ->
    supervisor:start_child(?MODULE, {?MODULE, {'v3_migrate_server', 'start_link', []}, 'permanent', 5000, 'worker', ['v3_migrate_server']}).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {'ok', { {'one_for_one', 5, 10}
             ,[?WORKER('cdr_listener')]
           } }.

