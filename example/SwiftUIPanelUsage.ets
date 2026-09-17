import { SwiftUIPanel } from 'panel'

@Component
export struct SwiftUIPanelUsage {
  build() {
    SwiftUIPanel({
      showAccent: true,
      accentColor: '#0B7063',
      contentBuilder: () => {
        Text('Panel content')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F8F8F8')
        Text('Use this container for grouped ArkUI content.')
          .fontSize(13)
          .fontColor('#D6D6D6')
      }
    })
  }
}
