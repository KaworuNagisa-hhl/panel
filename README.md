# panel

`panel` 是一个 OpenHarmony/HarmonyOS ArkUI like-ios 毛玻璃圆角面板组件，适合承载详情卡片、表单区块、状态摘要和操作分组。默认是接近 iOS SwiftUI material 的半透明纯色玻璃风格，同时允许业务方覆盖颜色、宽高、圆角、边框、阴影和内边距。

## 实际运行效果

下面展示默认毛玻璃面板、强调竖线和自定义品牌尺寸/颜色状态：

![panel preview](https://cdn.jsdelivr.net/gh/KaworuNagisa-hhl/panel@main/docs/panel-preview.gif)

## 安装

```bash
ohpm install panel
```

本地源码依赖：

```json5
{
  "dependencies": {
    "panel": "file:../panel",
    "theme": "file:../theme"
  }
}
```

## 正常使用样式

```ts
import { SwiftUIPanel } from 'panel'
import { SwiftUITone } from 'theme'

@Builder
function TaskSummaryContent() {
  Column({ space: 8 }) {
    Text('今日护理')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)

    Text('3 项待处理，最近一次记录已同步。')
      .fontSize(14)
      .fontColor('#D6D6D6')
  }
  .width('100%')
  .alignItems(HorizontalAlign.Start)
}

@Component
struct TaskSummaryPanel {
  build() {
    SwiftUIPanel({
      tone: SwiftUITone.GlassBlack,
      showAccent: true,
      accentColor: '#141414',
      contentBuilder: TaskSummaryContent
    })
  }
}
```

## 自定义品牌样式

```ts
SwiftUIPanel({
  componentWidth: '92%',
  componentHeight: 'auto',
  fillColor: '#E6111111',
  tintColor: '#1FFFFFFF',
  customBorderColor: '#33FFFFFF',
  customBorderWidth: 1.2,
  cornerRadius: 8,
  contentPadding: 12,
  shadowColor: '#66000000',
  shadowRadius: 18,
  showAccent: true,
  accentColor: '#141414',
  contentBuilder: TaskSummaryContent
})
```

## SwiftUI 风格链式配置

```ts
import { swiftUIConfig, SwiftUITone } from theme

const glassStyle = swiftUIConfig()
  .withTone(SwiftUITone.SystemGray)
  .withWidth(92%)
  .withHeight(auto)
  .withRadius(8)
  .withFillColor(#E6111111)
  .withTintColor(#22FFFFFF)
  .withBorder(#33FFFFFF, 1)
  .withShadow(#33000000, 16)
  .withPadding(12)

SwiftUIPanel({
  config: glassStyle
})
```

`config` 是可选入口，适合复用一组 SwiftUI modifier 风格的外观配置；原有直接传参方式仍然可用，且业务可以继续通过 Builder 注入自定义内容。

## API

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `config` | `SwiftUIComponentConfig` | 空配置 | SwiftUI modifier 风格链式配置，可覆盖宽高、圆角、颜色、边框、阴影、内边距等通用外观 |
| `spacing` | `number` | `12` | 内容 Builder 内部间距 |
| `accentColor` | `ResourceColor` | `'#00000000'` | 强调竖线颜色 |
| `showAccent` | `boolean` | `false` | 是否显示左侧强调竖线 |
| `tone` | `SwiftUITone` | `GlassBlack` | 默认 like-ios 黑色毛玻璃色调 |
| `componentWidth` | `Length` | `'100%'` | 面板宽度 |
| `componentHeight` | `Length` | `'auto'` | 面板高度 |
| `fillColor` | `ResourceColor` | `'#E6111111'` | 黑色毛玻璃底色 |
| `tintColor` | `ResourceColor` | 自动色调 | 渐变叠色 |
| `customBorderColor` | `ResourceColor` | 自动边框 | 自定义边框色 |
| `customBorderWidth` | `number` | `1.2` | 边框宽度 |
| `cornerRadius` | `number` | `16` | 圆角 |
| `contentPadding` | `number` | `16` | 内容内边距 |
| `shadowColor` | `ResourceColor` | 自动阴影 | 阴影颜色 |
| `shadowRadius` | `number` | `22` | 阴影半径 |
| `contentBuilder` | `() => void` | 空内容 | 自定义内容 |
