import {
  getSwiftUIGlassMaterial,
  SWIFT_UI_RADIUS_CARD,
  SWIFT_UI_SPACING_LARGE,
  SWIFT_UI_SPACING_MEDIUM,
  SWIFT_UI_SPACING_SMALL,
  swiftUIColorWithOpacity,
  SwiftUITone
} from 'theme'

@Builder
function EmptyBuilder() {
  Blank()
}

@Component
export struct SwiftUIPanel {
  @Prop spacing: number = SWIFT_UI_SPACING_MEDIUM
  @Prop accentColor: ResourceColor = '#00000000'
  @Prop showAccent: boolean = false
  @Prop tone: SwiftUITone = SwiftUITone.GlassBlack
  @Prop componentWidth: Length = '100%'
  @Prop componentHeight: Length = 'auto'
  @Prop fillColor: ResourceColor = '#E6111111'
  @Prop tintColor: ResourceColor = '#00000000'
  @Prop customBorderColor: ResourceColor = '#00000000'
  @Prop customBorderWidth: number = 1.2
  @Prop cornerRadius: number = SWIFT_UI_RADIUS_CARD
  @Prop contentPadding: number = SWIFT_UI_SPACING_LARGE
  @Prop shadowColor: ResourceColor = '#00000000'
  @Prop shadowRadius: number = 22
  @State panelHeight: number = 0
  @BuilderParam contentBuilder: () => void = EmptyBuilder

  private resolvedTintColor(): ResourceColor {
    return this.tintColor === '#00000000' ? getSwiftUIGlassMaterial(this.tone).tint : this.tintColor
  }

  private resolvedBorderColor(): ResourceColor {
    return this.customBorderColor === '#00000000' ? getSwiftUIGlassMaterial(this.tone).border : this.customBorderColor
  }

  private resolvedShadowColor(): ResourceColor {
    return this.shadowColor === '#00000000' ? getSwiftUIGlassMaterial(this.tone).shadow : this.shadowColor
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(getSwiftUIGlassMaterial(this.tone).highlight)
        .opacity(0.86)

      Column({ space: this.spacing }) {
        this.contentBuilder()
      }
      .width('100%')
      .padding({ left: this.contentPadding, right: this.contentPadding, top: SWIFT_UI_SPACING_SMALL, bottom: SWIFT_UI_SPACING_SMALL })
      .backgroundColor(this.fillColor)
      .linearGradient({
        direction: GradientDirection.RightBottom,
        colors: [
          [this.fillColor, 0.0],
          [this.fillColor, 0.56],
          [this.showAccent ? swiftUIColorWithOpacity(this.accentColor, 0.16) : this.resolvedTintColor(), 1.0]
        ]
      })
      .backgroundBlurStyle(BlurStyle.Regular)
      .borderRadius(this.cornerRadius)
      .border({ width: this.customBorderWidth, color: this.resolvedBorderColor() })
      .shadow({ radius: this.shadowRadius, color: this.resolvedShadowColor(), offsetX: 0, offsetY: 10 })
      .onAreaChange((oldArea, newArea) => {
        this.panelHeight = Number(newArea.height)
      })

      if (this.showAccent) {
        Row()
          .width(3)
          .height(Math.max(0, this.panelHeight - SWIFT_UI_SPACING_MEDIUM * 2))
          .backgroundColor(this.accentColor)
          .borderRadius(2)
          .margin({ left: 0, top: SWIFT_UI_SPACING_MEDIUM })
      }
    }
    .width(this.componentWidth)
    .height(this.componentHeight)
  }
}
