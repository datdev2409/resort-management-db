exports.getAll = async (Model) => {
  const docs = await Model.findAll();
  return docs;
}

exports.getOne = async (Model, id) => {
  const doc = await Model.findByPk(id)
  return doc;
}

exports.createOne = async (Model, data) => {
  const doc = await Model.create(data);
  return doc;
} 
