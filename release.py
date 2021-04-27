#!/usr/bin/python3

import os, sys, datetime, zipfile

def read_file(filename: str):
    f = open(filename, 'r', encoding='utf-8')
    content = f.read()
    f.close()
    return content

def write_file(filename: str, content: str):
    f = open(filename, 'w', encoding='utf-8')
    f.write(content)
    f.close()

def release():
    if not os.path.exists('../Super-Tpl/'):
        print('Please include the Super-Tpl toolkit folder as ../Super-Tpl, and convert template to ../Super-Tpl/output.tpl')
        return
    if len(sys.argv) < 2:
        sys.argv.append(input('Input version tag: '))
    
    print('Compiling...', end=' \t')

    # Edit as you want
    tpl_name = 'takeback.standard.tpl'
    gen_name = 'takeback.generator.html'
    zip_name = 'takeback.zip'
    ver = sys.argv[1]
    time = datetime.datetime.now()
    comment = f'The Takeback template for HFS: {ver} | {time}\n\n(C) 2020-2021 NaitLee Soft'

    tpl = read_file('../Super-Tpl/output.tpl')
    gen = read_file('generator-template.html').replace('@template@', tpl)
    write_file(tpl_name, tpl)
    write_file(gen_name, gen)

    z = zipfile.ZipFile(zip_name, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9)
    z.write(tpl_name)
    z.write(gen_name)
    z.comment = comment.encode('utf-8')
    z.close()

    print('OK')

if __name__ == '__main__':
    release()
