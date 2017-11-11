require "active_record_json_map/version"

module ActiveRecordJsonMap
  def self.included klass
    klass.class_variable_set("@@format", klass.to_s.underscore)

    if klass.ancestors.include? ActiveRecord::Base
      const_get("#{klass.to_s}::ActiveRecord_Relation").class_eval do
        def json_map key=nil, *args, **hash
          self.map {|it| it.json key, *args, **hash}
        rescue ArgumentError
          self.map {|it| it.json key}
        end
      end

      const_get("#{klass.to_s}::ActiveRecord_AssociationRelation").class_eval do
        def json_map key=nil, *args, **hash
          self.map {|it| it.json key, *args, **hash}
        rescue ArgumentError
          self.map {|it| it.json key}
        end
      end

      const_get("#{klass.to_s}::ActiveRecord_Associations_CollectionProxy").class_eval do
        def json_map key=nil, *args, **hash
          self.map {|it| it.json key, *args, **hash}
        rescue ArgumentError
          self.map {|it| it.json key}
        end
      end
    end
  end

  def json key=nil, *args, **hash
    format!((key ? self.send(key, *args, **hash) : self.attributes), key: key)
  end

  def format! hash={}, key: nil, **other
    hash.merge! other
    hash[:format] ||= key ? "#{self.class.to_s.underscore}_#{key}" : nil || @format || self.class.class_variable_get("@@format")
    return hash
  end
end
