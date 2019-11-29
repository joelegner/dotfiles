#!/usr/bin/env python
"""
$ # Created 2016-05-31 J. M. Legner
$ # Latest  2017-10-14 J. M. Legner
$ # Updated to use on Mac Mini 2019-11-29 J. M. Legner
$ # This is how this program is used:
$ #
$ # python file.py _unfiled/
"""

# These imports will use the virtual environment
import datetime
import exifread
import os
import shutil
import sys
import re

TAGNAME = "EXIF DateTimeOriginal"
dest_dir = os.path.abspath("/media/family/Dropbox/Family/Photos/")
skip_dir = os.path.abspath("/media/family/Dropbox/Family/Photos/_skipped")
expr = re.compile('([0-9]{4})-(1[0-2]|0[1-9])')

# Calculate document expressions and destinations
doc_exprs = []
year = datetime.datetime.now().year
check_stub_path = os.path.abspath("/home/joe/Dropbox/References/Personal/employment/teco/{}_teco".format(year))
expr_check_stub = re.compile('check_stub_([0-9]{4})-(1[0-2]|0[1-9])')
doc_exprs.append((expr_check_stub, check_stub_path))
expr_timecard = re.compile('timecard_([0-9]{4})-(1[0-2]|0[1-9])')
doc_exprs.append((expr_timecard, check_stub_path))


existing = {}


def catalog_existing(dest_dir):
    retval = {}
    for x in os.walk(dest_dir):
        fullname = x[0]
        search_res = expr.search(fullname)
        if search_res is not None:
            shortname = fullname[:(search_res.start() + 10)]
            retval[shortname] = fullname
    return retval


if not os.path.exists(skip_dir):
    os.makedirs(skip_dir)


def get_modified_time(filepath):
    mt = datetime.datetime.fromtimestamp(os.path.getmtime(filepath))
    year = mt.year
    month = mt.month
    day = mt.day
    return os.path.join(dest_dir, "%s" % year, "%02d-%02d-%02d" % (year, month, day))


def get_new_path(f, filepath):
    "Returns EXIF datetime or file creation as backup"
    tags = exifread.process_file(f)
    if TAGNAME in tags.keys():
        dto = tags[TAGNAME].values.split(' ')[0].split(':')
        if len(dto) >=3 :
            year = dto[0]
            month = dto[1]
            day = dto[2]
            retval = os.path.join(dest_dir, "%s" % year, "%s-%s-%s" % (year, month, day))
        else:
            retval = get_modified_time(filepath)
            if "Image DateTime" in tags.keys():
                dto = tags["Image DateTime"].values.split(' ')[0].split(':')
                if len(dto) >=3 :
                    year = dto[0]
                    month = dto[1]
                    day = dto[2]
                    retval = os.path.join(dest_dir, "%s" % year, "%s-%s-%s" % (year, month, day))
    else:
        retval = get_modified_time(filepath)
    return retval

def process_img_file(filepath):
    global existing

    f = open(filepath, "rb")
    d = get_new_path(f, filepath)
    if d in existing.keys():
        d = existing[d]
    else:
        os.makedirs(d)
        existing[d] = d
    f.close()
    if d is not None:
        newfilepath = os.path.join(d, os.path.basename(filepath))
        if newfilepath == filepath:
            newfilepath = os.path.join(skip_dir, os.path.basename(filepath))
    else:
        newfilepath = filepath
        return
    move(filepath, newfilepath)


def move(filepath, newfilepath):
    "Relocate a file by using os.rename for same filesystem or shutil.move otherwise"
    print("\"{}\" => \"{}\"".format(filepath, newfilepath))
    try:
        os.rename(filepath, newfilepath)
    except:
        try:
            shutil.move(filepath, newfilepath)
        except:
            print("Could not move {}".format(filepath))


def process_doc_file(filepath):
    global doc_exprs
    for search_res, dest_dir in doc_exprs:
        search_res = expr.search(filepath)
        if search_res is not None:
            move(filepath, os.path.join(dest_dir, os.path.basename(filepath)))
        else:
            warn_no_rule(filepath)

def usage():
    print """Usage: file.py path"""
    import sys; sys.exit(1)

def warn_no_rule(filename):
    print("No rule for file name \'{}\'".format(filename))
    rules = {}

if __name__ == '__main__':
    print("Starting")
    existing = catalog_existing(dest_dir)

    if len(sys.argv) != 2:
        usage()

    source_dir = os.path.abspath(sys.argv[1])

    if not os.path.exists(source_dir):
        print "Path not found."
        usage()

    img_filepaths = []
    doc_filepaths = []

    i = 0

    print "Scanning %s" % source_dir

    for dirpath, dirnames, filenames in os.walk(source_dir):
        for filename in filenames:
            if filename.lower()[-3:] in ['jpg', 'gif', 'png', 'tif',
                    'bmp' ] or filename.lower()[-4:] in ['jpeg', 'tiff']:
                img_filepaths.append(os.path.join(dirpath, filename))
            elif filename.lower()[-3:] in ['pdf']:
                doc_filepaths.append(os.path.join(dirpath, filename))
            else:
                warn_no_rule(filename)

    print("Scanned {0} image files and {1} document files".format(len(img_filepaths), len(doc_filepaths)))

    for i in range(0, len(img_filepaths)):
        filepath = img_filepaths[i].strip()
        filepath=filepath.strip()
        process_img_file(filepath)

    for i in range(0, len(doc_filepaths)):
        filepath = doc_filepaths[i].strip()
        filepath=filepath.strip()
        process_doc_file(filepath)
