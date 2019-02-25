class <+ClassName+>(models.Model):
    """<+Docstring+>"""
    id = models.AutoField(primary_key=True)
    project = models.ForeignKey(Project)
    name = models.CharField(max_length = 24)
    description = models.TextField(blank = True)
    icon = '<+iconfilename+>.png'
    <+Extra Fields+>

    class Meta:
        ordering = ('name', )

    def __str__(self):
        return "%s-%s" % (self.project.number, self.name)

    def get_absolute_url(self):
        return "/<+appname+>/<+classname+>/%d/" % (self.id)

    <+Member Functions+>

