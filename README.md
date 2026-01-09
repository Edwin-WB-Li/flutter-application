## Flutter

### Flutter 安装

- 问题：Downloading the Flutter SDK. This may take a few minutes. 
- 解决：管理员身份 运行 PowerShell
- 输入以下命令
```sh
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"

$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

### flutter 依赖下载

```bash
flutter pub add ant_design_flutter
```

### Flutter 是什么？它的核心优势是什么？

解答：Flutter 是 Google 推出的跨平台 UI 框架，通过自绘引擎（而非 WebView / 原生组件桥接）实现多端一致的 UI，支持 iOS/Android/Windows/macOS/Web 等平台。

核心优势：

  - 跨平台一致性：自绘渲染，无原生组件差异；

  - 高性能：Skia 引擎 + JIT/AOT 编译，接近原生性能；

  - 热重载：开发效率高；

  - 单一代码库：一套代码多端运行；

  - 丰富的组件库：Material Design/Cupertino 组件开箱即用

### Dart 语言的核心特性？为什么 Flutter 选择 Dart？

Dart 核心特性：

  - 强类型（支持动态类型）、面向对象、异步（async/await/Future/Stream）；

  - 支持 JIT（即时编译，热重载）和 AOT（提前编译，发布包高性能）；

  - 单线程 + 事件循环（Isolate 实现多线程）；

  - 空安全（Null Safety）。

选择 Dart 原因：

  - JIT/AOT 兼顾开发效率和运行性能；

  - 单线程模型降低跨线程通信成本；

  - 静态类型减少运行时错误；

  - Google 可控，易与 Flutter 深度优化

### Flutter 的三大核心架构层是什么？

- 框架层（Framework）：Dart 编写的上层 API，如 Widget、RenderObject、Animation 等；

- 引擎层（Engine）：C/C++ 编写的核心，包含 Skia 渲染引擎、Dart 运行时、文本渲染等；

- 嵌入层（Embedder）：适配不同平台的底层封装，如 Android 的 Activity、iOS 的 UIViewController 集成。


### Flutter 核心概念

- 变量声明（var / final / const）

  - var 适用场景：类的成员变量、函数参数、需要明确类型的核心变量，类型推断可变

  - final 赋值后不可修改，支持类型推断或显式类型, `运行时确定值`（StatelessWidget/StatefulWidget 的成员参数,可赋值动态数据，如用户 ID、接口返回的固定值、设备信息）

  - const 赋值后不可修改，支持类型推断或显式类型,`编译时确定值`（只能赋值「字面量」，如数字、字符串、const构造的对象）

  - 总结

    - 可变性选择：能不用可变变量（var/显式类型）就不用，优先用 final（运行时）/ const（编译时），符合 Flutter Widget 的不可变设计，还能优化性能；
    
    - 空安全选择：可空变量加?，延迟初始化用late，非空断言!尽量少用（优先用??判空）；
    
    - Flutter 实战原则：
    
      - StatelessWidget（无状态） 的参数必须用final；
      
      - 静态 Widget（如固定文本、边距）用const修饰，减少重建
      
      - StatefulWidget 中延迟初始化的非空变量用late

### Flutter 与 Vue、React 的区别[https://www.doubao.com/chat/31624762199670018]

- Flutter 推荐用 ListView.builder（懒加载，性能优）替代前端的map循环；需显式指定itemCount和itemBuilder，无 “v-for” 指令

- https://www.doubao.com/chat/31624762199670018

- 基础组件（如 Text / Container / Row / Column）

- Widget 生命周期：StatelessWidget（无状态）和 StatefulWidget（有状态）的区别

  - 如果一个 Widget 会变化（例如由于用户交互），它是有状态的。然而，如果一个 Widget 响应变化，它的父 Widget 只要本身不响应变化，就依然是无状态的

- 布局系统：基于Widget嵌套的布局（如Stack/Expanded/MediaQuery）和传统前端的 CSS 布局逻辑不同，需要适应 “约束向下传递，尺寸向上反馈” 的机制；

- 状态管理：简单场景用setState即可，但复杂应用需要学习Provider/Bloc/GetX等方案，理解 “状态分离” 的思想需要时间

- Flutter 用 Row / Column（对应 Flex）、Stack（对应绝对定位）、Expanded（对应 flex:1）等 Widget 实现布局

- 通过 Padding / SizedBox 控制间距、MediaQuery 获取屏幕尺寸

- 强制空安全：

  - String? a = null;（加?表示可空）

  - String b = a!;（!断言非空，类似 TS 的!）

- Dart 默认开启空安全（Null Safety），变量默认不可为空

- Dart 的箭头函数（=>）只能是单行表达式（无{}）

- Dart 区分命名参数（调用时需写参数名：fn(a:10, b:20)）和位置参数

- Flutter 无 “模板语法”，所有 UI 由 Widget 对象嵌套实现

- Flutter 无 “通用容器” `<div>`，需用 Container（带样式的容器）、SizedBox（占位）、Padding（内边距）等专用 Widget 替代

- Flutter 的交互 Widget（如ElevatedButton）需通过 onPressed 等属性绑定事件，而非 HTML 的 onClick

- Flutter 无 CSS 的 “盒模型属性”，需用 EdgeInsets、double.infinity 等 Dart 对象/常量替代；布局逻辑由 Row/Column/Stack 等 Widget 实现

- Flutter 用 Expanded Widget 实现 “flex:1” 效果，需包裹子 Widget

- Flutter 用 Stack（相对定位容器）+ Positioned（绝对定位子 Widget）替代 CSS 的 position:relative/absolute

- Flutter 无 “模板指令”，直接用 Dart 的三元运算符或专用 Widget（Visibility/If）实现条件渲染；前端支持&&短路渲染，Flutter 需用三元或if块（集合内）

- Flutter 推荐用 ListView.builder（懒加载，性能优化）替代前端的map循环；需显式指定itemCount和itemBuilder，无 “v-for” 指令

- Flutter 的组件内状态必须放在State类中，通过setState触发重建

- Flutter 的状态管理依赖ChangeNotifier/Provider（或 Bloc/GetX），需手动调用notifyListeners

- Dart 的 Future对应 JS 的 Promise，用法几乎一致；Dart 的 Stream 原生支持流式数据（无需第三方库），async\*/yield替代 RxJS 的 Observable/next

- Flutter 无 CSS 文件，样式通过 TextStyle/BoxDecoration 等对象定义；全局样式依赖 ThemeData，而非 CSS 全局类或变量；尺寸无单位（基于逻辑像素）

- Flutter 通过类成员变量接收参数，需在构造函数中声明；

- Flutter 无 “插槽” 概念，通过 List<Widget> children 或命名参数（如title）实现插槽效果

- @override：标注方法重写父类，核心作用是编译器校验 + 代码可读性，是 Flutter 生命周期方法的必备注解；

- _：将标识符私有化，核心作用是封装内部实现 + 符合 Flutter 规范，State 类必须私有化；

- 每个 stateful widget 都有一个 initState() 方法，它会在 widget 创建并添加到 widget 树时调用。你可以重写这个方法并在其中进行初始化，但这个方法的第一行 必须 是 super.initState()

- 许多内置的 Widget 都是无状态的，比如 Padding、Text 和 Icon, 当你构建自定义 Widget 时，优先采用 无状态 (Stateless) Widget

- 如果一个 Widget 的某些特性需要随用户交互或其他因素而改变，则这个 Widget 是有状态的, StatefulWidget 没有 build 方法，它们的用户界面是通过关联其 State 对象来构建的

- Flutter 没有 “给 Text 加点击事件” 的写法，而是用 GestureDetector 包裹 Text

```dart
GestureDetector(
  onTap: () => print("文字被点击"),
  child: const Text("可点击的文字"),
);
```
- Container 不是万能的：新手容易所有场景都用 Container，其实简单的边距用Padding、固定大小用SizedBox，性能更好

### 部件

- Center、Container、Padding 拥有 child 属性

- Row、Column、ListView、Stack 拥有 children 属性

- Row 中 通过 mainAxisAlignment 和控制行或列如何对齐其子节点， crossAxisAlignment 属性。 对于一行，主轴水平且 横轴是垂直的。对于一列， 主轴线 垂直方向，横轴方向

- ListView 是一个列状小部件，当内容长度超过渲染框时，会自动提供滚动功能。

  - 当列表项目数量未知或非常多（甚至无限多）时，最好使用 ListView.builder 构造器，用于懒惰渲染列表中的项目 

- 通过 Expanded 扩展控件， 小部件可以调整大小以适应行或列，还可以决定小部件相对于其他小部件应占用多少空间（使用 flex属性 ）

- LayoutBuilder 制作自适应布局

- Container：向 widget 增加 padding、margins、borders、background color 或者其他的“装饰”

- GridView 将 widget 展示为一个可滚动的网格

- Scaffold 提供结构化的布局框架，为常用的 Material Design 应用元素提供插槽。

- AppBar 创建一个显示在屏幕顶部的横条。

- Card 将相关信息整理到一个有圆角和阴影的盒子中,

  - 通常和 ListTile 一起使用
  
  - Card 只有一个子项，这个子项可以是列、行、列表、网格或者其他支持多个子项的 widget

  - Card 默认情况下，Card 的内容区域会填充整个 Card默认情况下，Card 的大小是 0x0 像素。你可以使用 SizedBox 控制 card 的大小

- ListTile 将最多三行的文本、可选的导语以及后面的图标组织在一行中。

###  建造模式

- ListView.builder 用于懒惰渲染列表中的项目

- GridView.builder

- Builder 构建器小部件则用于访问深度控件代码中的 BuildContext

- LayoutBuilder 用于根据视口大小创建响应式布局

- FutureBuilder

### 按钮

- 由三部分组成：样式、回调及其子节点

  - 回调：按钮的回调函数 onPressed 决定点击按钮时发生什么，如果回调为空 ，按钮将被禁用，用户按下按钮时不会有任何反应
  
  - 子节点: 按钮的子节点显示在按钮内容区域内，通常是表示按钮用途的文本或图标

  - 样式: 控制其外观：颜色、边框等
  
```dart
int count = 0;

@override
Widget build(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    ),
    onPressed: () {
      setState(() {
        count += 1;
      });
    },
    child: const Text('Enabled'),
  );
}
```

### 常见错误

- 在构建 Flutter 应用时，最常见的错误可能是错误使用布局控件，这被称为“无界约束”错误。

### 样式

- 默认情况下，widget 相对于其父元素定位，指定一个 widget 的绝对位置，可以把它放在一个 Positioned widget 中，而 Positioned 则需被放在一个 Stack widget 中

- 使用 Text widget 的 maxLines 属性来指定包含在摘要中的行数，以及 overflow 属性来处理溢出文本

### flutter、uniapp、react native  三者对比[https://www.doubao.com/chat/31624762199670018]

| 维度       | Flutter                | React Native          | uni-app                          |
| ---------- | ---------------------- | --------------------- | -------------------------------- |
| 渲染方式   | 自绘（Skia 引擎）      | 桥接原生组件          | 多渲染模式（WebView / 原生 / 小程序） |
| 性能       | 接近原生               | 桥接开销略高          | 小程序端优，App 端略弱           |
| 开发语言   | Dart                   | JavaScript/TypeScript | Vue/JS                           |
| 热重载     | 秒级                   | 较快                  | 支持                             |
| 跨平台范围 | 多端（含桌面 / Web）   | 主要移动端            | 全端（小程序为主）               |

### @override 注解的作用

- @override 是 Dart 的注解（Annotation），专门用于标注 “当前方法 / 属性重写了父类（超类）的同名方法 / 属性

  - 编译器校验：确保父类确实存在这个方法，避免拼写错误（比如把initState写成inittState，编译器会直接报错）；
  
  - 代码可读性：明确告诉开发者 “这个方法不是自定义的，而是覆盖了父类的默认实现”，尤其是 Flutter 生命周期方法（initState/build/dispose等），一眼就能识别；
  
  - 功能合法性：Flutter 的核心生命周期方法（如createState/build）必须通过@override重写才能生效，这是框架的强制规范

- _（下划线）的作用

  - Dart 中，标识符（类、方法、变量名）以_开头，表示 “库私有（private）”

  - 这个类 / 方法 / 变量只能在当前.dart文件中访问；

  - 外部文件即使import了当前文件，也无法访问这个标识符

  - 所有 StatefulWidget 对应的 State 类都推荐用_私有化（因为 State 的逻辑只服务于对应的 Widget，无需暴露）

  - State 必须由 Widget 的createState创建，不能手动实例化

### Widget 分类

| 分类 | 核心作用 | 高频 Widget（必掌握） | 适用场景 |
|------|----------|---------------------|----------|
| 布局类 | 控制组件的位置 / 大小 | Row/Column、Stack、ListView | 横向 / 纵向排列、层叠布局、滚动列表 |
| 容器类 | 包装组件，加样式 / 约束 | Container、Padding、SizedBox | 加边距、背景、固定大小 |
| 基础 UI 类 | 展示内容 / 基础交互 | Text、Image、ElevatedButton | 文字、图片、按钮 |
| 交互类 | 响应用户操作 | GestureDetector、TextField | 点击 / 滑动、输入框 |
| 状态类 | 控制组件刷新 | StatefulWidget、Consumer | 可变状态、跨组件传值 |

### flutter 与 React、Vue 的异同 

| 模块 | 核心知识点 | 前端经验复用 | 学习资源 |
|------|------------|--------------|----------|
| 高频 Widget | 布局类（Stack/Flex/Expanded/ListView）、交互类（GestureDetector/TextField）、容器类（Padding/SizedBox/Card） | 类比 Vue 的 v-if/v-for、React 的 JSX 条件渲染 / 列表渲染 | 官方 Widget 目录：https://docs.flutter.dev/ui/widgets |
| 路由管理 | 原生路由（Navigator.push/pop）、命名路由、路由传参（构造函数 /arguments） | 类比 Vue Router、React Router | 官方路由文档：https://docs.flutter.dev/cookbook/navigation/navigation-basics |
| 网络与 JSON | Dio 库使用、GET/POST 请求、拦截器（请求 / 响应拦截）、JSON 序列化（json_serializable） | 类比 Axios、JS 的 JSON.parse/stringify | Dio 文档：https://pub.dev/packages/dio |
| 本地存储 | SharedPreferences（键值对存储） | 类比 localStorage | 官方文档：https://docs.flutter.dev/cookbook/persistence/key-value |

### flutter 状态管理与前端状态管理的区别

| 模块 | 核心知识点 | 前端经验复用 | 学习资源 |
|------|------------|--------------|----------|
| 状态管理 | Provider（InheritedWidget 封装）、GetX（路由 + 状态 + 依赖注入） | 对比 Vuex/Pinia、React Redux/Context | Provider 文档：https://pub.dev/packages/provider；GetX 文档：https://pub.dev/packages/get |
| 复杂 UI 组件 | 轮播图（carousel_slider）、表单（TextField 校验、Form 组件）、日历（table_calendar） | 类比 Vue 的 v-form、React 的 Formik | 组件库示例：https://pub.dev/packages/carousel_slider |
| 动画基础 | 隐式动画（AnimatedContainer）、显式动画（AnimationController/Tween） | 类比 CSS 动画、React Spring | 官方动画文档：https://docs.flutter.dev/ui/animations |
| MD3 规范适配 | ThemeData 配置（色彩系统、排版、形状）、深色模式切换 | 类比前端主题切换（CSS 变量、ThemeProvider） | MD3 官方文档：https://m3.material.io/ |