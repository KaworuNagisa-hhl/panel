import {
  getSwiftUIGlassMaterial,
  SWIFT_UI_RADIUS_CARD,
  SWIFT_UI_SPACING_LARGE,
  SWIFT_UI_SPACING_MEDIUM,
  SWIFT_UI_SPACING_SMALL,
  swiftUIColorWithOpacity,
  SwiftUIComponentConfig,
  SwiftUITone
} from 'theme'

@Builder
function EmptyBuilder() {
  Blank()
}

@Component
export struct SwiftUIPanel {
  @Prop config: SwiftUIComponentConfig = new SwiftUIComponentConfig()
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

  private resolvedTone(): SwiftUITone {
    return this.config.tone === undefined ? this.tone : this.config.tone
  }

  private resolvedSpacing(): number {
    return this.config.spacing === undefined ? this.spacing : this.config.spacing
  }

  private resolvedWidth(): Length {
    return this.config.width === undefined ? this.componentWidth : this.config.width
  }

  private resolvedHeight(): Length {
    return this.config.height === undefined ? this.componentHeight : this.config.height
  }

  private resolvedFillColor(): ResourceColor {
    return this.config.fillColor === undefined ? this.fillColor : this.config.fillColor
  }

  private resolvedCornerRadius(): number {
    return this.config.cornerRadius === undefined ? this.cornerRadius : this.config.cornerRadius
  }

  private resolvedBorderWidth(): number {
    return this.config.borderWidth === undefined ? this.customBorderWidth : this.config.borderWidth
  }

  private resolvedContentPadding(): number {
    return this.config.contentPadding === undefined ? this.contentPadding : this.config.contentPadding
  }

  private resolvedTintColor(): ResourceColor {
    if (this.config.tintColor) {
      return this.config.tintColor
    }
    return this.tintColor === '#00000000' ? getSwiftUIGlassMaterial(this.resolvedTone()).tint : this.tintColor
  }

  private resolvedBorderColor(): ResourceColor {
    if (this.config.borderColor) {
      return this.config.borderColor
    }
    return this.customBorderColor === '#00000000' ? getSwiftUIGlassMaterial(this.resolvedTone()).border : this.customBorderColor
  }

  private resolvedShadowColor(): ResourceColor {
    if (this.config.shadowColor) {
      return this.config.shadowColor
    }
    return this.shadowColor === '#00000000' ? getSwiftUIGlassMaterial(this.resolvedTone()).shadow : this.shadowColor
  }

  private resolvedShadowRadius(): number {
    return this.config.shadowRadius === undefined ? this.shadowRadius : this.config.shadowRadius
  }

  private resolvedAccentColor(): ResourceColor {
    return this.config.accentColor === undefined ? this.accentColor : this.config.accentColor
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(1)
      .backgroundColor(getSwiftUIGlassMaterial(this.resolvedTone()).highlight)
        .opacity(0.86)

      Column({ space: this.resolvedSpacing() }) {
        this.contentBuilder()
      }
      .width('100%')
      .padding({ left: this.resolvedContentPadding(), right: this.resolvedContentPadding(), top: SWIFT_UI_SPACING_SMALL, bottom: SWIFT_UI_SPACING_SMALL })
      .backgroundColor(this.resolvedFillColor())
      .linearGradient({
        direction: GradientDirection.RightBottom,
        colors: [
          [this.resolvedFillColor(), 0.0],
          [this.resolvedFillColor(), 0.56],
          [this.showAccent ? swiftUIColorWithOpacity(this.resolvedAccentColor(), 0.16) : this.resolvedTintColor(), 1.0]
        ]
      })
      .backgroundBlurStyle(BlurStyle.Regular)
      .borderRadius(this.resolvedCornerRadius())
      .border({ width: this.resolvedBorderWidth(), color: this.resolvedBorderColor() })
      .shadow({ radius: this.resolvedShadowRadius(), color: this.resolvedShadowColor(), offsetX: 0, offsetY: 10 })
      .onAreaChange((oldArea, newArea) => {
        this.panelHeight = Number(newArea.height)
      })

      if (this.showAccent) {
        Row()
          .width(3)
          .height(Math.max(0, this.panelHeight - SWIFT_UI_SPACING_MEDIUM * 2))
          .backgroundColor(this.resolvedAccentColor())
          .borderRadius(2)
          .margin({ left: 0, top: SWIFT_UI_SPACING_MEDIUM })
      }
    }
    .width(this.resolvedWidth())
    .height(this.resolvedHeight())
  }
}
