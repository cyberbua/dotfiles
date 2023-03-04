#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

## Meanings of exit codes:
## code | meaning    | action of ranger
## -----+------------+-------------------------------------------
## 0    | success    | Display stdout as preview
## 1    | no preview | Display no preview at all

## Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)

FILE_BASENAME=${FILE_PATH##*/}
FILE_BASENAME_LOWER="${FILE_BASENAME,,}"

handle_extension() {
    case "${FILE_BASENAME_LOWER}" in

        ## Archive
        *.tar|*.tar.gz|*.tgz|*.tar.bz|*.tbz|*.tar.bz2|*.tbz2|*.tar.xz|*.txz|*.tar.lzo|*.tzo|*.tar.zst)
            tar --list --file "${FILE_PATH}"
            ;;

        *.zip|*.jar|*.war|*.apk)
            unzip -l "${FILE_PATH}"
            ;;

        *.rar)
            ## Avoid password prompt by providing empty password
            unrar lt -p- -- "${FILE_PATH}"
            ;;
        *.7z)
            ## Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}"
            ;;

        ## PDF
        *.pdf)
            ## Preview as text conversion
            pdftotext -l 2 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${PV_WIDTH}" ||
            mutool draw -F txt -i -- "${FILE_PATH}" 1-2 | fmt -w "${PV_WIDTH}" ||
            exiftool "${FILE_PATH}"
            ;;

        ## OpenDocument
        *.odt|*.ods|*.odp|*.sxw)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## HTML
        *.htm|*.html|*.xhtml)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## JSON
        *.json)
            bat --color=always --style="plain" --theme=base16 -- "${FILE_PATH}" ||
            jq --color-output . "${FILE_PATH}" ||
            python -m json.tool -- "${FILE_PATH}"
            ;;

        *)
            return 1;;

    esac
}


handle_mime() {
    MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
    case "${MIMETYPE}" in

        ## RTF, DOCX, ePub, FB2 (using pandoc)
        text/rtf|*wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## E-mails
        message/rfc822)
            ## Parsing performed by mu: https://github.com/djcb/mu
            mu view -- "${FILE_PATH}"
            ;;

        ## Text
        text/* | */xml)
            bat --color=always --style="plain" --theme=base16 -- "${FILE_PATH}" ||
            cat "${FILE_PATH}"
            ;;

        ## JSON
        application/json)
            bat --color=always --style="plain" --theme=base16 -- "${FILE_PATH}" ||
            jq --color-output . "${FILE_PATH}" ||
            python -m json.tool -- "${FILE_PATH}"
            ;;

        ## Image
        image/*)
            ## Preview as text conversion
            chafa "${FILE_PATH}" --animate=off --size "${PV_WIDTH}x${PV_HEIGHT}"||
            exiftool "${FILE_PATH}"
            ;;

        ## Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}"
            exiftool "${FILE_PATH}"
            ;;

        ## ELF files (executables and shared objects)
        application/x-executable | application/x-pie-executable | application/x-sharedlib)
            readelf -WCa "${FILE_PATH}"
            ;;

        *)
            echo -n 'File Type Classification: '
            file --dereference --brief -- "${FILE_PATH}"
            hexdump --canonical --length 2048 "${FILE_PATH}"
            ;;

    esac
}

handle_extension || handle_mime || exit 1

