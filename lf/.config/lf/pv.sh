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
        # ## Archive
        # a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        # rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
        #     atool --list -- "${FILE_PATH}" | head -n ${PV_HEIGHT}
        #     bsdtar --list --file "${FILE_PATH}" | head -n ${PV_HEIGHT}
        #     exit 1;;
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

        ## BitTorrent
        *.torrent)
            transmission-show -- "${FILE_PATH}"
            ;;

        ## OpenDocument
        *.odt|*.ods|*.odp|*.sxw)
            ## Preview as text conversion
            odt2txt "${FILE_PATH}" ||
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## XLSX
        *.xlsx)
            ## Preview as csv conversion
            ## Uses: https://github.com/dilshod/xlsx2csv
            xlsx2csv -- "${FILE_PATH}"
            ;;

        ## HTML
        *.htm|*.html|*.xhtml)
            ## Preview as text conversion
            w3m -dump "${FILE_PATH}" ||
            lynx -dump -- "${FILE_PATH}" ||
            elinks -dump "${FILE_PATH}" ||
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## JSON
        *.json)
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
        ## RTF and DOC
        text/rtf|*msword)
            ## Preview as text conversion
            ## note: catdoc does not always work for .doc files
            ## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
            catdoc -- "${FILE_PATH}"
            ;;

        ## DOCX, ePub, FB2 (using markdown)
        ## You might want to remove "|epub" and/or "|fb2" below if you have
        ## uncommented other methods to preview those formats
        *wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}"
            ;;

        ## E-mails
        message/rfc822)
            ## Parsing performed by mu: https://github.com/djcb/mu
            mu view -- "${FILE_PATH}"
            ;;

        ## XLS
        *ms-excel)
            ## Preview as csv conversion
            ## xls2csv comes with catdoc:
            ##   http://www.wagner.pp.ru/~vitus/software/catdoc/
            xls2csv -- "${FILE_PATH}"
            ;;

        ## Text
        text/* | */xml)
            bat --color=always --style="plain" --theme=ansi -- "${FILE_PATH}" ||
            head -n ${PV_HEIGHT} "${FILE_PATH}"
            ;;

        ## JSON
        application/json)
            jq --color-output . "${FILE_PATH}" ||
            python -m json.tool -- "${FILE_PATH}"
            ;;

        ## DjVu
        image/vnd.djvu)
            ## Preview as text conversion (requires djvulibre)
            djvutxt "${FILE_PATH}" | fmt -w "${PV_WIDTH}"
            exiftool "${FILE_PATH}"
            ;;

        ## Image
        image/*)
            ## Preview as text conversion
            chafa "${FILE_PATH}" --animate=off||
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
            echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}"
            hexdump --canonical --length 2048 "${FILE_PATH}"
            ;;

    esac
}

handle_extension || handle_mime || exit 1

