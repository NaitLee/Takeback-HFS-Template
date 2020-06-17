
[+special:strings]

{.comment| Use special date&time format? 0 to disable, other values to enable .}
UseSpecialDateTimeFormat=1
DateTimeFormat=dd/mm/yyyy
{.comment| Format sample: DateTimeFormat=mm/dd/yyyy hh:MM:ss ampm .}

{.comment| What will the title(browser tab) show? .}
TitleText=HFS::%folder%

{.comment| Use JQuery instead of FaikQuery? .}
UseJquery=0
{.comment|
    The webpage goes fast with FaikQuery, because this only includes functions
        that are needed in this webpage/template, with less operations.
    If you need edit this template with jQuery features(other than animations), turn it on.
.}

{.comment|
    Enable image background?
    Put pictures in your speciefied folder to see them randomly appear
    as the background of your page
.}
EnableImageBg=0
BgFolder=/pic/img/bg/

{.comment| What will the header show?   -- Texts wrapped by {.! .} will be able to be replaced("translated") by defining them like those ones below.}
EnableHeader=0
HeaderText={.!HTTP File System.}

{.comment| What will the statustext show? .}
EnableStatus=1
StatusText={.!Files here are available for view & download.}

{.comment| How will Fais looked like? .}
HowDjFaisLooksLike=\( •̀ ω •́ )✧ ♫

{.comment| ... and more below .}
MaxArchiveSizeAllowedToDownloadKb=128000
ThresholdConnectionsOfTuringStatusRed=64
