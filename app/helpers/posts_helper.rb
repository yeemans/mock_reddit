module PostsHelper

  def PostsHelper.objects_from_results(results)
    objects = []

    results.each do |r| # fetch database models from results
      objects.append(r.searchable_type.constantize.find(r.searchable_id)) 
    end

    return objects
  end

end
