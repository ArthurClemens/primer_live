-module(expo_plural_forms_parser).
-export([parse/1, parse_and_scan/1, format_error/1]).
-file("src/expo_plural_forms_parser.yrl", 48).

value({int, _Line, Int}) -> Int.

operator({Op, _Line}) -> Op.

-file("/Users/andrea/.asdf/installs/erlang/25.0/lib/parsetools-2.4/include/yeccpre.hrl", 0).
%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 1996-2021. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parser generator will insert appropriate declarations before this line.%

-type yecc_ret() :: {'error', _} | {'ok', _}.

-spec parse(Tokens :: list()) -> yecc_ret().
parse(Tokens) ->
    yeccpars0(Tokens, {no_func, no_location}, 0, [], []).

-spec parse_and_scan({function() | {atom(), atom()}, [_]}
                     | {atom(), atom(), [_]}) -> yecc_ret().
parse_and_scan({F, A}) ->
    yeccpars0([], {{F, A}, no_location}, 0, [], []);
parse_and_scan({M, F, A}) ->
    Arity = length(A),
    yeccpars0([], {{fun M:F/Arity, A}, no_location}, 0, [], []).

-spec format_error(any()) -> [char() | list()].
format_error(Message) ->
    case io_lib:deep_char_list(Message) of
        true ->
            Message;
        _ ->
            io_lib:write(Message)
    end.

%% To be used in grammar files to throw an error message to the parser
%% toplevel. Doesn't have to be exported!
-compile({nowarn_unused_function, return_error/2}).
-spec return_error(erl_anno:location(), any()) -> no_return().
return_error(Location, Message) ->
    throw({error, {Location, ?MODULE, Message}}).

-define(CODE_VERSION, "1.4").

yeccpars0(Tokens, Tzr, State, States, Vstack) ->
    try yeccpars1(Tokens, Tzr, State, States, Vstack)
    catch 
        error: Error: Stacktrace ->
            try yecc_error_type(Error, Stacktrace) of
                Desc ->
                    erlang:raise(error, {yecc_bug, ?CODE_VERSION, Desc},
                                 Stacktrace)
            catch _:_ -> erlang:raise(error, Error, Stacktrace)
            end;
        %% Probably thrown from return_error/2:
        throw: {error, {_Location, ?MODULE, _M}} = Error ->
            Error
    end.

yecc_error_type(function_clause, [{?MODULE,F,ArityOrArgs,_} | _]) ->
    case atom_to_list(F) of
        "yeccgoto_" ++ SymbolL ->
            {ok,[{atom,_,Symbol}],_} = erl_scan:string(SymbolL),
            State = case ArityOrArgs of
                        [S,_,_,_,_,_,_] -> S;
                        _ -> state_is_unknown
                    end,
            {Symbol, State, missing_in_goto_table}
    end.

yeccpars1([Token | Tokens], Tzr, State, States, Vstack) ->
    yeccpars2(State, element(1, Token), States, Vstack, Token, Tokens, Tzr);
yeccpars1([], {{F, A},_Location}, State, States, Vstack) ->
    case apply(F, A) of
        {ok, Tokens, EndLocation} ->
            yeccpars1(Tokens, {{F, A}, EndLocation}, State, States, Vstack);
        {eof, EndLocation} ->
            yeccpars1([], {no_func, EndLocation}, State, States, Vstack);
        {error, Descriptor, _EndLocation} ->
            {error, Descriptor}
    end;
yeccpars1([], {no_func, no_location}, State, States, Vstack) ->
    Line = 999999,
    yeccpars2(State, '$end', States, Vstack, yecc_end(Line), [],
              {no_func, Line});
yeccpars1([], {no_func, EndLocation}, State, States, Vstack) ->
    yeccpars2(State, '$end', States, Vstack, yecc_end(EndLocation), [],
              {no_func, EndLocation}).

%% yeccpars1/7 is called from generated code.
%%
%% When using the {includefile, Includefile} option, make sure that
%% yeccpars1/7 can be found by parsing the file without following
%% include directives. yecc will otherwise assume that an old
%% yeccpre.hrl is included (one which defines yeccpars1/5).
yeccpars1(State1, State, States, Vstack, Token0, [Token | Tokens], Tzr) ->
    yeccpars2(State, element(1, Token), [State1 | States],
              [Token0 | Vstack], Token, Tokens, Tzr);
yeccpars1(State1, State, States, Vstack, Token0, [], {{_F,_A}, _Location}=Tzr) ->
    yeccpars1([], Tzr, State, [State1 | States], [Token0 | Vstack]);
yeccpars1(State1, State, States, Vstack, Token0, [], {no_func, no_location}) ->
    Location = yecctoken_end_location(Token0),
    yeccpars2(State, '$end', [State1 | States], [Token0 | Vstack],
              yecc_end(Location), [], {no_func, Location});
yeccpars1(State1, State, States, Vstack, Token0, [], {no_func, Location}) ->
    yeccpars2(State, '$end', [State1 | States], [Token0 | Vstack],
              yecc_end(Location), [], {no_func, Location}).

%% For internal use only.
yecc_end(Location) ->
    {'$end', Location}.

yecctoken_end_location(Token) ->
    try erl_anno:end_location(element(2, Token)) of
        undefined -> yecctoken_location(Token);
        Loc -> Loc
    catch _:_ -> yecctoken_location(Token)
    end.

-compile({nowarn_unused_function, yeccerror/1}).
yeccerror(Token) ->
    Text = yecctoken_to_string(Token),
    Location = yecctoken_location(Token),
    {error, {Location, ?MODULE, ["syntax error before: ", Text]}}.

-compile({nowarn_unused_function, yecctoken_to_string/1}).
yecctoken_to_string(Token) ->
    try erl_scan:text(Token) of
        undefined -> yecctoken2string(Token);
        Txt -> Txt
    catch _:_ -> yecctoken2string(Token)
    end.

yecctoken_location(Token) ->
    try erl_scan:location(Token)
    catch _:_ -> element(2, Token)
    end.

-compile({nowarn_unused_function, yecctoken2string/1}).
yecctoken2string(Token) ->
    try
        yecctoken2string1(Token)
    catch
        _:_ ->
            io_lib:format("~tp", [Token])
    end.

-compile({nowarn_unused_function, yecctoken2string1/1}).
yecctoken2string1({atom, _, A}) -> io_lib:write_atom(A);
yecctoken2string1({integer,_,N}) -> io_lib:write(N);
yecctoken2string1({float,_,F}) -> io_lib:write(F);
yecctoken2string1({char,_,C}) -> io_lib:write_char(C);
yecctoken2string1({var,_,V}) -> io_lib:format("~s", [V]);
yecctoken2string1({string,_,S}) -> io_lib:write_string(S);
yecctoken2string1({reserved_symbol, _, A}) -> io_lib:write(A);
yecctoken2string1({_Cat, _, Val}) -> io_lib:format("~tp", [Val]);
yecctoken2string1({dot, _}) -> "'.'";
yecctoken2string1({'$end', _}) -> [];
yecctoken2string1({Other, _}) when is_atom(Other) ->
    io_lib:write_atom(Other);
yecctoken2string1(Other) ->
    io_lib:format("~tp", [Other]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



-file("src/expo_plural_forms_parser.erl", 188).

-dialyzer({nowarn_function, yeccpars2/7}).
-compile({nowarn_unused_function,  yeccpars2/7}).
yeccpars2(0=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_0(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(1=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_1(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(2=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_2(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(3=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_3(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(4=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_4(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(5=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_5(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(6=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_6(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(7=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_7(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(8=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_8(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(9=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_9(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(10=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_10(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(11=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_11(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(12=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(13=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_13(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(14=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_14(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(15=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_15(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(16=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_16(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(17=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_17(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(18=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_18(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(19=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(20=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_20(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(21=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_21(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(22=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(23=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_23(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(24=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_24(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(25=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_25(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(26=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_26(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(27=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(28=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_28(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(29=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(30=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(31=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_31(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(32=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_32(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(33=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_33(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(34=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_34(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(35=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_35(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(36=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_36(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(37=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_37(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(38=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_38(S, Cat, Ss, Stack, T, Ts, Tzr);
%% yeccpars2(39=S, Cat, Ss, Stack, T, Ts, Tzr) ->
%%  yeccpars2_39(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(40=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_40(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(41=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_41(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(42=S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_42(S, Cat, Ss, Stack, T, Ts, Tzr);
yeccpars2(Other, _, _, _, _, _, _) ->
 erlang:error({yecc_bug,"1.4",{missing_state_in_action_table, Other}}).

-dialyzer({nowarn_function, yeccpars2_0/7}).
-compile({nowarn_unused_function,  yeccpars2_0/7}).
yeccpars2_0(S, 'nplurals', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 2, Ss, Stack, T, Ts, Tzr);
yeccpars2_0(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_1/7}).
-compile({nowarn_unused_function,  yeccpars2_1/7}).
yeccpars2_1(_S, '$end', _Ss, Stack, _T, _Ts, _Tzr) ->
 {ok, hd(Stack)};
yeccpars2_1(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_2/7}).
-compile({nowarn_unused_function,  yeccpars2_2/7}).
yeccpars2_2(S, '=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 3, Ss, Stack, T, Ts, Tzr);
yeccpars2_2(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_3/7}).
-compile({nowarn_unused_function,  yeccpars2_3/7}).
yeccpars2_3(S, 'int', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 4, Ss, Stack, T, Ts, Tzr);
yeccpars2_3(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_4/7}).
-compile({nowarn_unused_function,  yeccpars2_4/7}).
yeccpars2_4(S, ';', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 5, Ss, Stack, T, Ts, Tzr);
yeccpars2_4(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_5/7}).
-compile({nowarn_unused_function,  yeccpars2_5/7}).
yeccpars2_5(S, 'plural', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 6, Ss, Stack, T, Ts, Tzr);
yeccpars2_5(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_6/7}).
-compile({nowarn_unused_function,  yeccpars2_6/7}).
yeccpars2_6(S, '=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 7, Ss, Stack, T, Ts, Tzr);
yeccpars2_6(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_7/7}).
-compile({nowarn_unused_function,  yeccpars2_7/7}).
yeccpars2_7(S, '(', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 12, Ss, Stack, T, Ts, Tzr);
yeccpars2_7(S, 'int', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 13, Ss, Stack, T, Ts, Tzr);
yeccpars2_7(S, 'n', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 14, Ss, Stack, T, Ts, Tzr);
yeccpars2_7(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_8/7}).
-compile({nowarn_unused_function,  yeccpars2_8/7}).
yeccpars2_8(S, ';', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 42, Ss, Stack, T, Ts, Tzr);
yeccpars2_8(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_9/7}).
-compile({nowarn_unused_function,  yeccpars2_9/7}).
yeccpars2_9(_S, '!=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_!='(Stack),
 yeccgoto_expr(hd(Ss), '!=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '%', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_%'(Stack),
 yeccgoto_expr(hd(Ss), '%', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '<', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_<'(Stack),
 yeccgoto_expr(hd(Ss), '<', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '<=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_<='(Stack),
 yeccgoto_expr(hd(Ss), '<=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '==', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_=='(Stack),
 yeccgoto_expr(hd(Ss), '==', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '>', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_>'(Stack),
 yeccgoto_expr(hd(Ss), '>', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, '>=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_9_>='(Stack),
 yeccgoto_expr(hd(Ss), '>=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_9(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_9_(Stack),
 yeccgoto_plural_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_10/7}).
-compile({nowarn_unused_function,  yeccpars2_10/7}).
yeccpars2_10(S, '!=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 28, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '%', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 29, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '<', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 31, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '<=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 32, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '==', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 33, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '>', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 34, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(S, '>=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 35, Ss, Stack, T, Ts, Tzr);
yeccpars2_10(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_11/7}).
-compile({nowarn_unused_function,  yeccpars2_11/7}).
yeccpars2_11(S, '&&', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 20, Ss, Stack, T, Ts, Tzr);
yeccpars2_11(S, '?', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 22, Ss, Stack, T, Ts, Tzr);
yeccpars2_11(S, '||', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 23, Ss, Stack, T, Ts, Tzr);
yeccpars2_11(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_11_(Stack),
 yeccgoto_plural_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_12/7}).
-compile({nowarn_unused_function,  yeccpars2_12/7}).
yeccpars2_12(S, '(', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 12, Ss, Stack, T, Ts, Tzr);
yeccpars2_12(S, 'int', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 18, Ss, Stack, T, Ts, Tzr);
yeccpars2_12(S, 'n', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 14, Ss, Stack, T, Ts, Tzr);
yeccpars2_12(_, _, _, _, T, _, _) ->
 yeccerror(T).

-dialyzer({nowarn_function, yeccpars2_13/7}).
-compile({nowarn_unused_function,  yeccpars2_13/7}).
yeccpars2_13(_S, '!=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_!='(Stack),
 yeccgoto_expr(hd(Ss), '!=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '%', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_%'(Stack),
 yeccgoto_expr(hd(Ss), '%', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '<', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_<'(Stack),
 yeccgoto_expr(hd(Ss), '<', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '<=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_<='(Stack),
 yeccgoto_expr(hd(Ss), '<=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '==', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_=='(Stack),
 yeccgoto_expr(hd(Ss), '==', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '>', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_>'(Stack),
 yeccgoto_expr(hd(Ss), '>', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, '>=', Ss, Stack, T, Ts, Tzr) ->
 NewStack = 'yeccpars2_13_>='(Stack),
 yeccgoto_expr(hd(Ss), '>=', Ss, NewStack, T, Ts, Tzr);
yeccpars2_13(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_13_(Stack),
 yeccgoto_plural_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_14/7}).
-compile({nowarn_unused_function,  yeccpars2_14/7}).
yeccpars2_14(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_14_(Stack),
 yeccgoto_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_15/7}).
-compile({nowarn_unused_function,  yeccpars2_15/7}).
yeccpars2_15(S, ')', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 41, Ss, Stack, T, Ts, Tzr);
yeccpars2_15(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_15_(Stack),
 yeccgoto_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

yeccpars2_16(S, ')', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 40, Ss, Stack, T, Ts, Tzr);
yeccpars2_16(S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_10(S, Cat, Ss, Stack, T, Ts, Tzr).

yeccpars2_17(S, ')', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 21, Ss, Stack, T, Ts, Tzr);
yeccpars2_17(S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_26(S, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_18/7}).
-compile({nowarn_unused_function,  yeccpars2_18/7}).
yeccpars2_18(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_18_(Stack),
 yeccgoto_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

%% yeccpars2_19: see yeccpars2_12

-dialyzer({nowarn_function, yeccpars2_20/7}).
-compile({nowarn_unused_function,  yeccpars2_20/7}).
yeccpars2_20(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_20_(Stack),
 yeccgoto_bool_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_21/7}).
-compile({nowarn_unused_function,  yeccpars2_21/7}).
yeccpars2_21(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_21_(Stack),
 yeccgoto_bool_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

%% yeccpars2_22: see yeccpars2_12

-dialyzer({nowarn_function, yeccpars2_23/7}).
-compile({nowarn_unused_function,  yeccpars2_23/7}).
yeccpars2_23(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_23_(Stack),
 yeccgoto_bool_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_24/7}).
-compile({nowarn_unused_function,  yeccpars2_24/7}).
yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_24_(Stack),
 yeccgoto_expr(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

yeccpars2_25(S, ':', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 30, Ss, Stack, T, Ts, Tzr);
yeccpars2_25(S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_10(S, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_26/7}).
-compile({nowarn_unused_function,  yeccpars2_26/7}).
yeccpars2_26(S, '&&', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 20, Ss, Stack, T, Ts, Tzr);
yeccpars2_26(S, '?', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 22, Ss, Stack, T, Ts, Tzr);
yeccpars2_26(S, '||', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 23, Ss, Stack, T, Ts, Tzr);
yeccpars2_26(_, _, _, _, T, _, _) ->
 yeccerror(T).

%% yeccpars2_27: see yeccpars2_12

-dialyzer({nowarn_function, yeccpars2_28/7}).
-compile({nowarn_unused_function,  yeccpars2_28/7}).
yeccpars2_28(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_28_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

%% yeccpars2_29: see yeccpars2_12

%% yeccpars2_30: see yeccpars2_12

-dialyzer({nowarn_function, yeccpars2_31/7}).
-compile({nowarn_unused_function,  yeccpars2_31/7}).
yeccpars2_31(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_31_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_32/7}).
-compile({nowarn_unused_function,  yeccpars2_32/7}).
yeccpars2_32(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_32_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_33/7}).
-compile({nowarn_unused_function,  yeccpars2_33/7}).
yeccpars2_33(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_33_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_34/7}).
-compile({nowarn_unused_function,  yeccpars2_34/7}).
yeccpars2_34(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_34_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_35/7}).
-compile({nowarn_unused_function,  yeccpars2_35/7}).
yeccpars2_35(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 NewStack = yeccpars2_35_(Stack),
 yeccgoto_comp_op(hd(Ss), Cat, Ss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_36/7}).
-compile({nowarn_unused_function,  yeccpars2_36/7}).
yeccpars2_36(S, '!=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 28, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '%', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 29, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '<', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 31, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '<=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 32, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '==', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 33, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '>', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 34, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(S, '>=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 35, Ss, Stack, T, Ts, Tzr);
yeccpars2_36(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_,_,_|Nss] = Ss,
 NewStack = yeccpars2_36_(Stack),
 yeccgoto_if_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_37/7}).
-compile({nowarn_unused_function,  yeccpars2_37/7}).
yeccpars2_37(S, '%', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 29, Ss, Stack, T, Ts, Tzr);
yeccpars2_37(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_37_(Stack),
 yeccgoto_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_38/7}).
-compile({nowarn_unused_function,  yeccpars2_38/7}).
yeccpars2_38(S, '!=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 28, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '%', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 29, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '<', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 31, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '<=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 32, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '==', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 33, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '>', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 34, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(S, '>=', Ss, Stack, T, Ts, Tzr) ->
 yeccpars1(S, 35, Ss, Stack, T, Ts, Tzr);
yeccpars2_38(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_38_(Stack),
 yeccgoto_bool_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_39/7}).
-compile({nowarn_unused_function,  yeccpars2_39/7}).
yeccpars2_39(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_39_(Stack),
 yeccgoto_bool_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_40/7}).
-compile({nowarn_unused_function,  yeccpars2_40/7}).
yeccpars2_40(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_40_(Stack),
 yeccgoto_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_41/7}).
-compile({nowarn_unused_function,  yeccpars2_41/7}).
yeccpars2_41(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_|Nss] = Ss,
 NewStack = yeccpars2_41_(Stack),
 yeccgoto_if_expr(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccpars2_42/7}).
-compile({nowarn_unused_function,  yeccpars2_42/7}).
yeccpars2_42(_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 [_,_,_,_,_,_,_|Nss] = Ss,
 NewStack = yeccpars2_42_(Stack),
 yeccgoto_plural_form(hd(Nss), Cat, Nss, NewStack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_bool_expr/7}).
-compile({nowarn_unused_function,  yeccgoto_bool_expr/7}).
yeccgoto_bool_expr(7, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_11(11, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(12, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_17(17, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(19=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_39(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(22, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_26(26, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(27, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_26(26, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(29, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_26(26, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_expr(30, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_26(26, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_bool_op/7}).
-compile({nowarn_unused_function,  yeccgoto_bool_op/7}).
yeccgoto_bool_op(11, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(19, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_op(17, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(19, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_op(26, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(19, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_bool_op(39, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(19, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_comp_op/7}).
-compile({nowarn_unused_function,  yeccgoto_comp_op/7}).
yeccgoto_comp_op(10, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_comp_op(16, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_comp_op(25, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_comp_op(36, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_comp_op(37, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_comp_op(38, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_12(27, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_expr/7}).
-compile({nowarn_unused_function,  yeccgoto_expr/7}).
yeccgoto_expr(7, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_10(10, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(12, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_16(16, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(19, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_10(10, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(22, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_25(25, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(27, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_38(38, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(29, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_37(37, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_expr(30, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_36(36, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_if_expr/7}).
-compile({nowarn_unused_function,  yeccgoto_if_expr/7}).
yeccgoto_if_expr(7=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_9(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(12, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_15(15, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(19=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(22=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(27=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(29=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr);
yeccgoto_if_expr(30=_S, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_24(_S, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_plural_expr/7}).
-compile({nowarn_unused_function,  yeccgoto_plural_expr/7}).
yeccgoto_plural_expr(7, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_8(8, Cat, Ss, Stack, T, Ts, Tzr).

-dialyzer({nowarn_function, yeccgoto_plural_form/7}).
-compile({nowarn_unused_function,  yeccgoto_plural_form/7}).
yeccgoto_plural_form(0, Cat, Ss, Stack, T, Ts, Tzr) ->
 yeccpars2_1(1, Cat, Ss, Stack, T, Ts, Tzr).

-compile({inline,'yeccpars2_9_!='/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_!='/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_!='/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_!='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_%'/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_%'/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_%'/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_%'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_<'/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_<'/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_<'/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_<'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_<='/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_<='/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_<='/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_<='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_=='/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_=='/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_=='/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_=='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_>'/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_>'/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_>'/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_>'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,'yeccpars2_9_>='/1}).
-dialyzer({nowarn_function, 'yeccpars2_9_>='/1}).
-compile({nowarn_unused_function,  'yeccpars2_9_>='/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
'yeccpars2_9_>='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,yeccpars2_9_/1}).
-dialyzer({nowarn_function, yeccpars2_9_/1}).
-compile({nowarn_unused_function,  yeccpars2_9_/1}).
-file("src/expo_plural_forms_parser.yrl", 19).
yeccpars2_9_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                         ___1
  end | __Stack].

-compile({inline,yeccpars2_11_/1}).
-dialyzer({nowarn_function, yeccpars2_11_/1}).
-compile({nowarn_unused_function,  yeccpars2_11_/1}).
-file("src/expo_plural_forms_parser.yrl", 18).
yeccpars2_11_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                           ___1
  end | __Stack].

-compile({inline,'yeccpars2_13_!='/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_!='/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_!='/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_!='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_%'/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_%'/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_%'/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_%'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_<'/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_<'/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_<'/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_<'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_<='/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_<='/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_<='/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_<='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_=='/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_=='/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_=='/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_=='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_>'/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_>'/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_>'/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_>'(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,'yeccpars2_13_>='/1}).
-dialyzer({nowarn_function, 'yeccpars2_13_>='/1}).
-compile({nowarn_unused_function,  'yeccpars2_13_>='/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
'yeccpars2_13_>='(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,yeccpars2_13_/1}).
-dialyzer({nowarn_function, yeccpars2_13_/1}).
-compile({nowarn_unused_function,  yeccpars2_13_/1}).
-file("src/expo_plural_forms_parser.yrl", 17).
yeccpars2_13_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                     value(___1)
  end | __Stack].

-compile({inline,yeccpars2_14_/1}).
-dialyzer({nowarn_function, yeccpars2_14_/1}).
-compile({nowarn_unused_function,  yeccpars2_14_/1}).
-file("src/expo_plural_forms_parser.yrl", 31).
yeccpars2_14_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
            n
  end | __Stack].

-compile({inline,yeccpars2_15_/1}).
-dialyzer({nowarn_function, yeccpars2_15_/1}).
-compile({nowarn_unused_function,  yeccpars2_15_/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
yeccpars2_15_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,yeccpars2_18_/1}).
-dialyzer({nowarn_function, yeccpars2_18_/1}).
-compile({nowarn_unused_function,  yeccpars2_18_/1}).
-file("src/expo_plural_forms_parser.yrl", 29).
yeccpars2_18_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
              value(___1)
  end | __Stack].

-compile({inline,yeccpars2_20_/1}).
-dialyzer({nowarn_function, yeccpars2_20_/1}).
-compile({nowarn_unused_function,  yeccpars2_20_/1}).
-file("src/expo_plural_forms_parser.yrl", 41).
yeccpars2_20_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_21_/1}).
-dialyzer({nowarn_function, yeccpars2_21_/1}).
-compile({nowarn_unused_function,  yeccpars2_21_/1}).
-file("src/expo_plural_forms_parser.yrl", 23).
yeccpars2_21_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                                 {paren, ___2}
  end | __Stack].

-compile({inline,yeccpars2_23_/1}).
-dialyzer({nowarn_function, yeccpars2_23_/1}).
-compile({nowarn_unused_function,  yeccpars2_23_/1}).
-file("src/expo_plural_forms_parser.yrl", 42).
yeccpars2_23_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_24_/1}).
-dialyzer({nowarn_function, yeccpars2_24_/1}).
-compile({nowarn_unused_function,  yeccpars2_24_/1}).
-file("src/expo_plural_forms_parser.yrl", 30).
yeccpars2_24_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  ___1
  end | __Stack].

-compile({inline,yeccpars2_28_/1}).
-dialyzer({nowarn_function, yeccpars2_28_/1}).
-compile({nowarn_unused_function,  yeccpars2_28_/1}).
-file("src/expo_plural_forms_parser.yrl", 34).
yeccpars2_28_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_31_/1}).
-dialyzer({nowarn_function, yeccpars2_31_/1}).
-compile({nowarn_unused_function,  yeccpars2_31_/1}).
-file("src/expo_plural_forms_parser.yrl", 37).
yeccpars2_31_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                 operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_32_/1}).
-dialyzer({nowarn_function, yeccpars2_32_/1}).
-compile({nowarn_unused_function,  yeccpars2_32_/1}).
-file("src/expo_plural_forms_parser.yrl", 39).
yeccpars2_32_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_33_/1}).
-dialyzer({nowarn_function, yeccpars2_33_/1}).
-compile({nowarn_unused_function,  yeccpars2_33_/1}).
-file("src/expo_plural_forms_parser.yrl", 36).
yeccpars2_33_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_34_/1}).
-dialyzer({nowarn_function, yeccpars2_34_/1}).
-compile({nowarn_unused_function,  yeccpars2_34_/1}).
-file("src/expo_plural_forms_parser.yrl", 35).
yeccpars2_34_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                 operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_35_/1}).
-dialyzer({nowarn_function, yeccpars2_35_/1}).
-compile({nowarn_unused_function,  yeccpars2_35_/1}).
-file("src/expo_plural_forms_parser.yrl", 38).
yeccpars2_35_(__Stack0) ->
 [___1 | __Stack] = __Stack0,
 [begin
                  operator(___1)
  end | __Stack].

-compile({inline,yeccpars2_36_/1}).
-dialyzer({nowarn_function, yeccpars2_36_/1}).
-compile({nowarn_unused_function,  yeccpars2_36_/1}).
-file("src/expo_plural_forms_parser.yrl", 25).
yeccpars2_36_(__Stack0) ->
 [___5,___4,___3,___2,___1 | __Stack] = __Stack0,
 [begin
                                         {'if', ___1, ___3, ___5}
  end | __Stack].

-compile({inline,yeccpars2_37_/1}).
-dialyzer({nowarn_function, yeccpars2_37_/1}).
-compile({nowarn_unused_function,  yeccpars2_37_/1}).
-file("src/expo_plural_forms_parser.yrl", 28).
yeccpars2_37_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                        {'%', ___1, ___3}
  end | __Stack].

-compile({inline,yeccpars2_38_/1}).
-dialyzer({nowarn_function, yeccpars2_38_/1}).
-compile({nowarn_unused_function,  yeccpars2_38_/1}).
-file("src/expo_plural_forms_parser.yrl", 21).
yeccpars2_38_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                                 {___2, ___1, ___3}
  end | __Stack].

-compile({inline,yeccpars2_39_/1}).
-dialyzer({nowarn_function, yeccpars2_39_/1}).
-compile({nowarn_unused_function,  yeccpars2_39_/1}).
-file("src/expo_plural_forms_parser.yrl", 22).
yeccpars2_39_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                                           {___2, ___1, ___3}
  end | __Stack].

-compile({inline,yeccpars2_40_/1}).
-dialyzer({nowarn_function, yeccpars2_40_/1}).
-compile({nowarn_unused_function,  yeccpars2_40_/1}).
-file("src/expo_plural_forms_parser.yrl", 32).
yeccpars2_40_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                       ___2
  end | __Stack].

-compile({inline,yeccpars2_41_/1}).
-dialyzer({nowarn_function, yeccpars2_41_/1}).
-compile({nowarn_unused_function,  yeccpars2_41_/1}).
-file("src/expo_plural_forms_parser.yrl", 26).
yeccpars2_41_(__Stack0) ->
 [___3,___2,___1 | __Stack] = __Stack0,
 [begin
                             {paren, ___2}
  end | __Stack].

-compile({inline,yeccpars2_42_/1}).
-dialyzer({nowarn_function, yeccpars2_42_/1}).
-compile({nowarn_unused_function,  yeccpars2_42_/1}).
-file("src/expo_plural_forms_parser.yrl", 15).
yeccpars2_42_(__Stack0) ->
 [___8,___7,___6,___5,___4,___3,___2,___1 | __Stack] = __Stack0,
 [begin
                                                      {value(___3), ___7}
  end | __Stack].


-file("src/expo_plural_forms_parser.yrl", 53).
