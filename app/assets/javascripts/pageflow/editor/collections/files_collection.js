pageflow.FilesCollection = Backbone.Collection.extend({
  initialize: function(models, options) {
    options = options || {};

    this.entry = options.entry;
    this.fileType = options.fileType;
    this.name = options.fileType.collectionName;
  },

  comparator: function(file) {
    var fileName = file.get('file_name');
    return (fileName && fileName.toLowerCase) ? fileName.toLowerCase() : fileName;
  },

  url: function() {
    return '/editor/entries/' + this.getEntry().get('id') + '/files/' + this.name;
  },

  getEntry: function() {
    return this.entry || pageflow.entry;
  },

  confirmable: function() {
    return new pageflow.SubsetCollection({
      parent: this,
      watchAttribute: 'state',

      filter: function(item) {
        return item.get('state') === 'waiting_for_confirmation';
      },
    });
  }
});

pageflow.FilesCollection.createForFileTypes = function(fileTypes, files, options) {
  return fileTypes.reduce(function(result, fileType) {
    result[fileType.collectionName] = pageflow.FilesCollection.createForFileType(
      fileType,
      files[fileType.collectionName],
      options
    );
    return result;
  }, {});
};

pageflow.FilesCollection.createForFileType = function(fileType, files, options) {
  return new pageflow.FilesCollection(
    files,
    _.extend({
      fileType: fileType,
      model: fileType.model
    }, options || {})
  );
};