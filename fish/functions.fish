# Yazi
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function backup
    if test (count $argv) -eq 0
        echo "Usage: backup <file1> [file2] [file3] ..."
        return 1
    end

    for file_to_backup in $argv
        set backup_file $file_to_backup.bak

        if test -e $file_to_backup
            if test ! -e $backup_file
                cp $file_to_backup $backup_file
                echo "Backup created for $file_to_backup: $backup_file"
            else
                echo "Backup already exists for $file_to_backup, skipping."
            end
        else
            echo "File not found: $file_to_backup"
        end
    end
end

function metadata
    if test -z $argv
        echo "Usage: metadata <file>"
        return 1
    end

    set file $argv[1]

    if test ! -f $file
        echo "File not found: $file"
        return 1
    end

    set file_extension (string match -r '\.([^\.]+)$' $file --groups)

    switch $file_extension
        case mp4 avi mkv mov flv wmv
            ffprobe -v error -show_entries format=duration,size:stream=codec_name:stream=width:stream=height:stream=bit_rate -of json $file
        case mp3 wav ogg flac m4a aac wma ape
            mediainfo --Inform="General;%Duration%\nAudio;%CodecString%" $file
        case jpg jpeg png gif bmp tiff webp
            exiftool $file
        case "*"
            echo "Unsupported file type: $file_extension"
            return 1
    end
end

function cd
    if contains -- $argv -- --help
        builtin cd $argv
    else if test -d $argv
        builtin cd $argv
        ls
    else
        builtin cd $argv
    end
end

function tmpdir
    if test -z "$argv"
        echo "Usage: tmpdir <directory_name>"
        return 1
    end

    mkdir -p /tmp/$USER/$argv
    cd /tmp/$USER/$argv
end

function mkcd
    if test -z "$argv"
        echo "Usage: mkcd <directory_name>"
        return 1
    end

    set directory_name $argv[1]

    mkdir -p $directory_name
    cd $directory_name
end

function cdd
    cd $argv
    ls
end

function filecount
    ls -1 $argv | wc -l
end

function linecount
    cat $argv | wc -l
end

function charcount
    cat $argv | wc -c
end

function totalfiles
    ls -l | grep "^-" | wc -l
end

function wordcount
    cat $argv | wc -w
end

function gitpullall
    set log_file (pwd)/pull_log.txt

    for dir in *
        if test -d "$dir/.git"
            echo "Pulling in $dir..."
            cd "$dir" || begin
                echo "Failed to enter directory $dir" >>"$log_file"
                continue
            end
            if not git pull
                echo "Failed to pull in $dir" >>"$log_file"
            end
            echo ""
            cd ..
        end
    end
end

function gcomms
    if test -z "$argv"
        git log --pretty=format:"%h %an %ad %s" --date=short
    else
        git log --author="$argv[1]" --pretty=oneline | nl
    end
end

function git-invert-path
    git filter-repo --path $argv[1] --invert-paths
end

function extract
    switch $argv[1]
        case '*.tar.gz'
            tar -xzvf $argv
        case '*.tar.bz2'
            tar -xjvf $argv
        case '*.tar.xz'
            tar -xJvf $argv
        case '*.zip'
            unzip $argv
        case '*.rar'
            unrar x $argv
        case '*.7z'
            7z x $argv
        case '*.gz'
            gunzip $argv
        case '*'
            echo "Unsupported archive format"
    end
end

function httpserver
    python -m http.server $argv[1]
end

function psgrep
    ps aux | grep $argv
end

function now
    date "+%A, %d-%m-%Y %I:%M:%S %p"
end

function nix-run
    if test (count $argv) -eq 1
        nix-shell -p $argv[1] --run $argv[1]
        return
    end

    if test (count $argv) -gt 1
        nix-shell -p $argv[1] --run "$argv[1] $argv[2..-1]"
    end
end

function nix-garbage-clean
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
end

function nix-update-all
    sudo nix-channel --update
    nix-channel --update
end
