module EachHead
	def each_head(collection)
		if collection.is_a? Array
			collection.each do |el|
				each_head(el) { |e, f| yield e, f }
			end
		elsif collection.is_a? Hash
			collection.each do |k, subcollection|
				if k.to_sym == :head
					yield subcollection, collection
				elsif (subcollection.is_a? Array) || (subcollection.is_a? Hash)
				 each_head(subcollection) { |e, f| yield e, f }
				end
			end
		end
	end

	def substitute_heads(collection)
    if collection.is_a? Array
      new_collection = []
      collection.each_with_index do |element, i|
        new_collection[i] = substitute_heads(element) { |e| yield e }
      end
    elsif collection.is_a? Hash
      new_collection = {}
      collection.each do |k, v|
        if k.to_s == 'head'
          new_collection[:head] = yield v
        elsif (v.is_a? Array)
          new_collection[k] = substitute_heads(v) { |e| yield e }
        elsif (v.is_a? Hash)
          new_collection[k] = substitute_heads(v) { |e| yield e }
        end
      end
    else
    	new_collection = collection.clone
    end
    new_collection
	end
end