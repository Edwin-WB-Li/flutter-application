import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/demo/colors_demo.dart';
import 'pages/demo/cards_demo.dart';
import 'pages/demo/grid_list_demo.dart';
import 'pages/demo/bottom_navigation_demo.dart';
import 'pages/demo/nav_demo.dart';
import 'pages/demo/todo_demo.dart';
import 'pages/demo/home_screen_demo.dart';
import 'pages/demo/home_demo.dart';
import 'pages/demo/intl_phone_field.dart';
import 'pages/demo/dio.demo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider：状态管理容器,把 MyAppState（全局状态）提供给整个 App，让所有子组件都能访问 / 修改这个状态
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), // 创建全局状态
      // MaterialApp：Flutter 的 Material Design 风格的应用壳，封装了路由、主题、标题等全局配置（对应前端的<RouterView>+ 全局样式）
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(), // 设置主页
        builder: EasyLoading.init(),
      ),
    );
  }
}

// 全局状态：MyAppState（对应前端的 Store / 全局状态）
class MyAppState extends ChangeNotifier {
  var current = WordPair.random(); // 当前显示的单词对（对应Vue的data/React的state）
  var favorites = <WordPair>[]; // 收藏的单词对（全局数据）
  // 生成新单词对（对应Vue的method/React的事件处理函数）
  void getNext() {
    current = WordPair.random();
    notifyListeners(); // 通知所有监听者更新UI（对应Vue的$emit/React的setState）
  }

  // 收藏/取消收藏（修改全局状态）
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; // 导航选中的索引（组件内部状态）

  @override
  Widget build(BuildContext context) {
    // 根据选中的索引切换页面
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = ColorsDemo();
        break;
      case 3:
        page = CardsDemo();
        break;
      case 4:
        page = GridListDemo(type: GridListDemoType.footer);
        break;
      case 5:
        page = BottomNavigationDemo(
          type: BottomNavigationDemoType.withLabels,
          restorationId: 'bottom_navigation_labels_demo',
        );
        break;

      case 6:
        page = NavDemo();
        break;
      case 7:
        page = TodosScreen(
            todos: List.generate(
          20,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ));
        break;
      case 8:
        page = HomeScreen();
        break;
      case 9:
        page = HomeDemo();
        break;
      case 10:
        page = IntlPhoneFieldApp();
        break;
      case 11:
        page = DioDemo();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        // 横向布局
        body: Row(
          children: [
            // 侧边导航栏（NavigationRail）
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.color_lens),
                    label: Text('Colors'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.card_giftcard),
                    label: Text('Cards'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.grid_view),
                    label: Text('Gird'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list_alt),
                    label: Text('GirdList'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.format_list_bulleted_outlined),
                    label: Text('Nav'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.format_list_bulleted_outlined),
                    label: Text('ToDO'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('HomeScreen'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('HomeDemo'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('IntlPhoneFieldApp'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.network_check),
                    label: Text('Dio'),
                  ),
                ],
                selectedIndex: selectedIndex, // 当前选中项
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // 主内容区（占满剩余宽度）
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取全局状态（对应 Vue 的 useStore、React的 useContext）
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    // 判断是否收藏，切换图标
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // 调用全局方法
                  appState.getNext();
                },
                child: Text('Next'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  EasyLoading.show(status: 'loading...');
                },
                child: Text('Loading'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
