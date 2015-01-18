void() tree =
{
	if (!self.model)
		self.model = "progs/tree.mdl";
	precache_model(self.model);
	setmodel(self, self.model);
	makestatic(self);
};


