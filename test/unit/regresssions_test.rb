require 'test_helper'

class RegressionsTest < MiniTest::Test

  def setup
    @axlsx = Axlsx::Package.new
    @workbook = @axlsx.workbook
  end

  def test_dxf_cell
    @workbook.add_worksheet do |sheet|
      sheet.add_row (1..2).to_a
      sheet.add_style "A1:A1", { bg_color: "AA0000" }

      sheet.add_row (1..2).to_a
      sheet.add_style "B1:B1", { bg_color: "CC0000" }

      sheet.add_row (1..2).to_a
      sheet.add_style "A3:B3", { bg_color: "00FF00" }

      highlight = @workbook.styles.add_style(bg_color: "0000FF", type: :dxf)

      sheet.add_conditional_formatting(
        "A2:B2",
        {
          type: :cellIs,
          operator: :greaterThan,
          formula: "1",
          dxfId: highlight,
          priority: 1
        }
      )
    end

    serialize("test_dxf_cell")
  end

end
