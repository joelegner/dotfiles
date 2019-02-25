#!/bin/python

class Settings:
    def __init__(self):
        self.server = "news.usenetserver.com"
        self.port = 119
        self.user = "joelegner"
        self.password = "moocow01"
#         self.group = "alt.binaries.multimedia.erotica.asian"
        self.group = "alt.binaries.erotica"

MAX = 1000000

import nntplib

s = Settings()

conn = nntplib.NNTP(s.server, s.port, s.user, s.password)
rep, count, first, last, name = conn.group(s.group)
# print rep, count, first, last, name
first = "%s" % (int(last) - MAX)

resp, items = conn.xover(first, last)

print "Searching..."

for id, subject, author, date, message_id, references, size, lines in items:
    if not subject.lower().find("lesb") == -1:
        print id, subject

print "Done."

conn.quit()

