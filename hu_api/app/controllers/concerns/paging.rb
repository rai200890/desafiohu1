
module Paging
  extend ActiveSupport::Concern

  included do
    has_scope :page, default: 1
    has_scope :per, default: 15
  end

  def define_pagination_headers(items)
    if current_scopes.keys.sort == [:page, :per]
      headers['X-Pagination-Total-Pages'] = (items.unscoped.count.to_f/current_scopes[:per]).ceil
      headers['X-Pagination-Total-Entries'] = items.unscoped.count
    else
      headers['X-Pagination-Total-Pages'] = (items.count.to_f/current_scopes[:per]).ceil
      headers['X-Pagination-Total-Entries'] = items.count
    end
    headers['X-Pagination-Per-Page'] = current_scopes[:per]
    headers['X-Pagination-Current-Page'] = current_scopes[:page]
  end

end