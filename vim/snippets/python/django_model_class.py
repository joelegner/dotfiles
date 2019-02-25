from django.db import models
class <+ClassName+>(models.Model):
    """<++>"""
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length = 48, blank = False)
    created = models.DateTimeField(auto_now_add = True)
    modified = models.DateTimeField(auto_now = True)
    <++>

    class Meta:
        ordering = ('id',)

    def __str__(self):
        "Returns informal string representation."
        return "%s" % self.name

    def get_absolute_url(self):
        return "/dintranet/<+classname+>/%d/" % (self.id)

admin.site.register(<+ClassName+>)

