" Django HTML template settings


" Abbreviations in insert mode
call IMAP('bL', "{% block <++> %}<++>{% endblock %}", '')
call IMAP('eX', "{% extends \"<++>\" %}", '')
call IMAP('fOE', "{% for <++> in <++> %}\<CR><++>\<CR>{% empty %}\<CR><++>\<CR>{% endfor %}", '')
call IMAP('fOR', "{% for <++> in <++> %}\<CR><++>\<CR>{% endfor %}", '')
call IMAP('iF', "{% if <++> %}\<CR><++>\<CR>{% else %}\<CR><++>\<CR>{% endif %}", '')
call IMAP('iN', "{% include \"<++>\" %}", '')
call IMAP('rST', "{% filter restructuredtext %}\<CR><++>\<CR>{% endfilter %}", '')
call IMAP('tAB', "<table class='<++>'>\<CR></table>", '')
call IMAP('tD', "<td class='<++>'>\<CR></td>", '')
call IMAP('tH', "<th class='<++>'>\<CR></th>", '')
call IMAP('tR', "<tr class='<++>'>\<CR></tr>", '')
call IMAP('bR', "<br />", '')

