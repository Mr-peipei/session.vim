let s:sep = fnamemodify('.', ':p')[-1:]

function! session#create_session(file) abort
    "SeddionCreateの引数をfileで受け取れるようにする
    "join()でセッションファイル保存先へのフルパスを生成し、mksession!でセッションファイルを作成
    execute 'mksession!' join([g:session_path, a:file], s:sep)

    "再描画する
    redraw
    echo 'session.vim: created'
endfunction

function! session#load_session(file) abort
    " :source で渡されるセッションファイルをロードする
    execute 'source' join([g:session_path, a:file], s:sep)
endfunction

"エラ〜メッセ時表示
function! s:echo_err(msg) abort
    echohl ErrorMsg
    echomsg 'sessoin.vim:' a:msg
    echohl None
endfunction

"結果 => ['file1', 'file2', ...]
function! s:files() abort
    "g:session_pathから保存先を呼び出す
    "g:はグルーバル辞書変数、get()より指定したキーを取得できる
    let session_path = get(g:, 'session_path', '')

    if session_path is# ''
        call s:echo_err('g:session_path is empty')
        return []
    endif

    "fileという引数を受け取り、そのファイルがディレクトリ出なければ、1を返す
    let Filter = { file -> !isdirectory(session_path . s:sep . file) }

    "readdirの第2引数にFileterを使用することでファイルだけが入ったリストを取得できる
    return readdir(session_path, Filter)
endfunction


let s:session_list_buffer = 'SESSION'


function! session#sessions() abort
    let files = s:files()
    if empty(files)
        return 
    endif

    if bufexists(s:session_list_buffer)
        "バッファがウィンドウに表示されている場合は、'win_gotoid'でウィンドウに移動
        let winid = bufwinid(s:session_list_buffer)
        if winid isnot# -1
            call win_gotoid(winid)
        else
            execute 'sbuffer' s:session_list_buffer
        endif
    else
        execute 'new' s:session_list_buffer

        "バッファの種類を選択する
        set buftype=nofile

        " 1. セッション一覧のバッファで`q`を押下するとバッファを破棄
        " 2. `Enter`でセッションをロード
        " の2つのキーマッピングを定義します。
        "
        " <C-u>と<CR>はそれぞれコマンドラインでCTRL-uとEnterを押下した時の動作になります
        " <buffer>は現在のバッファにのみキーマップを設定します
        " <silent>はキーマップで実行されるコマンドがコマンドラインに表示されないようにします
        " <Plug>という特殊な文字を使用するとキーを割り当てないマップを用意できます
        " ユーザはこのマップを使用して自分の好きなキーマップを設定できます
        nnoremap <silent> <buffer>
            \ <Plug>(session-close)
            \ :<C-u>bwipeout!<CR>

        nnoremap <silent> <buffer>
            \ <Plug>(session-open)
            \ :<C-u>call session#load_session(trim(getline('.')))<CR>

        nmap <buffer> q <Plug>(sessoin-close)
        nmap <buffer> <CR> <Plug>(session-open)

        "セッションファイルを表示する一時バッファのテキストを全て削除して、取得したファイル一覧をバッファに挿入する
        %delete _
        call setline(1, files)
    endif
endfunction
