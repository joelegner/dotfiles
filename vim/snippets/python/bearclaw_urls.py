    (r'^<+classname+>/(?P<object_id>\d+)/$', 'bearclaw.<+appname+>.views.edit_<+classname+>'),
    (r'^<+classname+>/add/(?P<project_id>\d+)/$', 'bearclaw.<+appname+>.views.add_<+classname+>'),
    url(r'^<+classname+>/(?P<member_id>\d+)/delete/$', 'bearclaw.views.delete_member', kwargs = {"classname": <+ClassName+>}),

