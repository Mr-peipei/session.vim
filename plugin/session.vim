"すでにスクリプトをロードした場合は終了
if exists('g:loaded_sessions')
    finish
endif
let g:loaded_session=1

":SessionListコマンドを実行すると、call
"session#sessions()が実行されるようになる
command! SessionList call session#sessions()

" -nargsでコマンドが受け取る引数の数を設定できます
"1つの引数を受け取れるようにする
command! -nargs=1 SessionCreate call session#create_session(<q-args>)
