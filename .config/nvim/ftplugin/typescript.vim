augroup autofmt
    autocmd!
    autocmd BufWritePre *.js Neoformat
    autocmd BufWritePre *.ts Neoformat
augroup END