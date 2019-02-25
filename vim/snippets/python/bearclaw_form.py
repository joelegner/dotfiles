from bearclaw.<+appname+>.models import <+ClassName+>

class <+ClassName+>(forms.ModelForm):

    class Meta:
        model = <+ClassName+>
        exclude = ["project"]

