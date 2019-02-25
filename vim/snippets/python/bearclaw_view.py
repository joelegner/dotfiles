from bearclaw.<+appname+>.models import <+ClassName+>
from bearclaw.<+appname+>.forms import <+ClassName+>Form

@login_required
def add_<+classname+>(request, project_id):
    project = get_object_or_404(Project, id = project_id)
    title = "Add <+ClassName+>"

    if request.method == 'POST':
        # The form has been submitted, so create a bound form
        form = <+ClassName+>Form(data = request.POST)
        if form.is_valid():
            # All validation rules has passed, so save
            <+classname+> = form.save(commit = False)
            <+classname+>.project = project
            <+classname+>.save()
            # Redirect to the new item's page
            return HttpResponseRedirect(form.instance.get_absolute_url())
    else:
        # The form has not been submitted, so create an unbound form
        form = <+ClassName+>Form()
    c = RequestContext(request, { 'form': form, 'title' : title,
        'm' : form.instance})
    return render_to_response('model_form.html', c)


@login_required
def edit_<+classname+>(request, object_id):
    <+classname+> = get_object_or_404(<+ClassName+>, id = int(object_id))
    title = "Edit %s" % (<+classname+>)

    if request.method == 'POST':
        # The form has been submitted, so create a bound form
        form = <+ClassName+>Form(data = request.POST, instance = <+classname+>)
        if form.is_valid():
            <+classname+> = form.save()
            return HttpResponseRedirect(form.instance.get_absolute_url())
    else:
        # The form has not been submitted, so create an unbound form
        form = <+ClassName+>Form(instance = <+classname+>)
    c = RequestContext(request,{ 'form': form, 'title' : title,
        'm' : form.instance})
    return render_to_response('<+appname+>/<+classname+>_detail.html', c)

