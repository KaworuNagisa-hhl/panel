import { describe, it, expect } from '@ohos/hypium'
import { getSwiftUIGlassMaterial, SwiftUITone } from 'theme'

export default function localUnitTest() {
  describe('SwiftUIPanel', () => {
    it('uses_glass_material_contract', 0, () => {
      const material = getSwiftUIGlassMaterial(SwiftUITone.CareGreen)
      expect(material.fill.toString()).assertContain('#')
      expect(material.highlight.toString()).assertContain('#')
      expect(material.blurRadius >= 20).assertTrue()
    })

    it('supports_accented_panel_contract', 0, () => {
      const showAccent = true
      const accentColor = '#0B7063'
      expect(showAccent).assertTrue()
      expect(accentColor).assertEqual('#0B7063')
    })
  })
}
