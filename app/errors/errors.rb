# frozen_string_literal: true

module Errors
  class Error < StandardError
    def status
      500
    end

    def title
      "internal error"
    end

    def detail
      "An unknown error occurred."
    end

    def code
      self.class.name
    end

    def merge
      {}
    end

    def merge=(merge_data)
      @merge_data = merge_data
    end

    def to_h
      to_hash
    end

    def to_hash
      {
        error: {
          status: status,
          title: title,
          detail: detail,
          code: code
        }.merge!(merge).merge!(@merge_data || {})
      }
    end

    def to_json(*)
      to_hash.to_json
    end
  end
end
