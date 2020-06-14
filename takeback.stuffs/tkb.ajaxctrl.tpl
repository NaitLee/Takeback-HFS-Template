
{.comment| Macros needed to control files .}

[+special:alias]
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result={.!Bad session.}.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|&quot;|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes

[ajax.mkdir|no log]
{.check session.}
{.set|x|{.postvar|name.}.}
{.break|if={.pos|\|var=x.}{.pos|/|var=x.}|result={.!Illegal action.} (0).}
{.break|if={.not|{.can mkdir.}.}|result={.!Not authorized.} (1).}
{.set|x|{.force ansi|%folder%{.^x.}.}.}
{.break|if={.exists|{.^x.}.}|result={.!Duplicated.} (2).}
{.break|if={.not|{.length|{.mkdir|{.^x.}.}.}.}|result={.!Input empty.} (3).}
{.add to log|User %user% created folder "{.^x.}".}
{.pipe|{.!OK.}.}

[ajax.rename|no log]
{.check session.}
{.break|if={.not|{.can rename.}.}|result={.!Forbidden.} (0).}
{.break|if={.is file protected|{.postvar|from.}.}|result={.!Forbidden.} (1).}
{.break|if={.is file protected|{.postvar|to.}.}|result={.!Forbidden.} (2).}
{.set|x|{.force ansi|%folder%{.postvar|from.}.}.}
{.set|y|{.force ansi|%folder%{.postvar|to.}.}.}
{.break|if={.not|{.exists|{.^x.}.}.}|result={.!Target Not found.} (3).}
{.break|if={.exists|{.^y.}.}|result={.!Duplicated.} (4).}
{.break|if={.not|{.length|{.rename|{.^x.}|{.^y.}.}.}.}|result={.!Failed.} (5).}
{.add to log|User %user% renamed "{.^x.}" to "{.^y.}".}
{.pipe|{.!OK.}.}

[ajax.move|no log]
{.check session.}
{.set|to|{.force ansi|{.postvar|to.}.}.}
{.break|if={.not|{.and|{.can move.}|{.get|can delete.}|{.get|can upload|path={.^to.}.}/and.}.} |result={.!forbidden.} (0).}
{.set|log|{.!Moving items to.} {.^to.}.}
{.for each|fn|{.replace|:|{.no pipe||.}|{.force ansi|{.postvar|from.}.}.}|{:
    {.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
    {.set|x|{.force ansi|%folder%.}{.^fn.}.}
    {.set|y|{.^to.}/{.^fn.}.}
    {.if not |{.exists|{.^x.}.}|{.^x.}: {.!Target Not found.} (2)|{:
        {.if|{.exists|{.^y.}.}|{.^y.}: {.!Duplicated.} (3)|{:
            {.set|comment| {.get item|{.^x.}|comment.} .}
            {.set item|{.^x.}|comment=.} {.comment| this must be done before moving, or it will fail.}
            {.if|{.length|{.move|{.^x.}|{.^y.}.}.} |{:
                {.move|{.^x.}.md5|{.^y.}.md5.}
                {.set|log|{.chr|13.}{.^fn.}|mode=append.}
                {.set item|{.^y.}|comment={.^comment.}.}
            :} | {:
                {.set|log|{.chr|13.}{.^fn.} ({.!Failed.})|mode=append.}
                {.maybe utf8|{.^fn.}.}: {.!Not moved.}
            :}/if.}
        :}/if.}
    :}.}
    ;
:}.}
{.add to log|{.^log.}.}

[ajax.comment|no log]
{.check session.}
{.break|if={.not|{.can comment.}.} |result={.!Forbidden.} (0).}
{.for each|fn|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
     {.break|if={.is file protected|var=fn.}|result={.!Forbidden.} (1).}
     {.set item|{.force ansi|%folder%{.^fn.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|{.!OK.}.}

[ajax.changepwd|no log]
{.check session.}
{.break|if={.not|{.can change pwd.}.} |result={.!Forbidden.} (0).}
{.comment | {.break|if={.substring|{.chr|123|46.}|{.chr|46|125.}|{.base64decode|{.postvar|new.}.}.}|result={.!Macro detected.} (4).} .}
{.if | {.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}
    | {:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|{.!OK.} (1)|{.!Failed.} (2).}:}
    | {:{.!Old password not match.} (3):}
.}