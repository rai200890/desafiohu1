
module Paging
  extend ActiveSupport::Concern

  included do
    has_scope :page, default: 1
    has_scope :per, default: 15
  end

  def define_pagination_headers(klass)
    headers['X-Pagination-Per-Page'] = current_scopes[:per].to_i
    headers['X-Pagination-Current-Page'] = current_scopes[:page].to_i
    headers['X-Pagination-Total-Pages'] = (total_items(klass).to_f/headers['X-Pagination-Per-Page']).ceil
    headers['X-Pagination-Total-Entries'] = total_items(klass)
  end

  private

  def total_items(klass)
    scopes = current_scopes
    scopes.delete(:per)
    scopes.delete(:page)
    result = klass.unscoped
    scopes.each{|scope_name,value| result = result.send(scope_name, value) }
    result.count
  end

end