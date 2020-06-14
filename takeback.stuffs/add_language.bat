@echo off

set tplver=0.15b
set tplname=takeback_%tplver%.standard.tpl

echo ================
echo For template version: %tplver%
echo Default template language is English.
echo Currently supports:
echo :   zh-hans - ¼òÌåÖÐÎÄ
echo ================

set /p langcode="Type your language code to addon: "

set lngname=takeback_%tplver%.%langcode%.tpl

type %tplname% > %lngname%
type tkb.lng.%langcode%.tpl >> %lngname%

echo ================
echo Complete! See file %lngname%.

pause