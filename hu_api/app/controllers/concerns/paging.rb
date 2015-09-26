module Paging
  extend ActiveSupport::Concern

  included do
    has_scope :page, default: 1
    has_scope :per, default: 15
  end

  def define_pagination_headers klass
    headers['X-Pagination-Per-Page'] = current_scopes[:per].to_i
    headers['X-Pagination-Current-Page'] = current_scopes[:page].to_i
    total_items = total_items(klass)
    headers['X-Pagination-Total-Pages'] = (total_items.to_f/headers['X-Pagination-Per-Page']).ceil
    headers['X-Pagination-Total-Entries'] = total_items
  end

  private

  def total_items klass
    result = current_scopes_without_paging(klass)
    count = result.count
    count.is_a?(Hash) ? count.length : count
  end

  def current_scopes_without_paging klass
    scopes = current_scopes.reject{|scope_name, value| scope_name.in?([:per, :page])}
    apply_scopes(klass,scopes)
  end

end