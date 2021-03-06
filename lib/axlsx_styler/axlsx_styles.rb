module AxlsxStyler
  module Styles

    # An index for cell styles
    #   {
    #     1 => < style_hash >,
    #     2 => < style_hash >,
    #     ...
    #     K => < style_hash >
    #   }
    # where keys are Cell#raw_style and values are styles codes as per Axlsx::Style
    def style_index
      @style_index ||= {}
    end

    # Ensure plain axlsx styles are added to the axlsx_styler style_index cache
    def add_style(options={})
      if options[:type] == :dxf
        super
      else
        raw_style = {type: :xf, name: 'Arial', sz: 11, family: 1}.merge(options)

        if raw_style[:format_code]
          raw_style.delete(:num_fmt)
        end

        index = style_index.key(raw_style)

        if !index
          index = super 

          style_index[index] = raw_style
        end
      end

      return index
    end

  end
end

Axlsx::Styles.send(:prepend, AxlsxStyler::Styles)
