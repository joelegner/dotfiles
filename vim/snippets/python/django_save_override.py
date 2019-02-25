    def save(self):
        "Over-ride save() method to take action when first saved."
        # Object has None for id if not ever saved
        if self.id is None:
            # First time object has been saved - now get its id
            super(<+ClassName+>, self).save()
            # Perform action with object which now has an id
            <++>
        else:
            super(<+ClassName+>, self).save()
