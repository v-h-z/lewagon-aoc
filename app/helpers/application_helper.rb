# frozen_string_literal: true

module ApplicationHelper
  def duration_as_text(duration)
    return "-" if duration.nil?

    if duration < 48.hours
      parts = duration.parts
      [parts[:hours].to_i + (24 * parts[:days].to_i), parts[:minutes].to_i, parts[:seconds].to_i].map { |n| n.to_i.to_s.rjust(2, "0") }.join(":")
    else
      ">48h"
    end
  end

  def messages_sanitizer(text)
    sanitize(text, tags: %w[b em del span sub sup], attributes: %w[style])
  end

  DEFAULT_THEME = "base16-ocean.dark"

  def render_markdown(commonmarkdown)
    Commonmarker.to_html(commonmarkdown, plugins: { syntax_highlighter: { theme: DEFAULT_THEME } })
  end
end
