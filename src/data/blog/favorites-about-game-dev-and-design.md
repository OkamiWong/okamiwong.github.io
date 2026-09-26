---
pubDatetime: 2020-09-09T00:00:00Z
title: '游戏制作收藏夹'
featured: false
draft: false
tags:
  - 游戏制作
  - 集合
description: '记点游戏制作相关的有意思的东西，有开发也有设计。'
---

记点游戏制作相关的有意思的东西，有开发也有设计。

---

### [Scene Fusion](https://www.kinematicsoup.com/scene-fusion/pricing)

- Unity / Unreal 多人实时同步场景编辑（用 Google Doc 的协作方式编辑场景）。
- 两人免费。

### [积极玩法与消极玩法](https://indienova.com/indie-game-development/positive-and-negative-gameplay/)

- 文章首先对电子游戏中的玩法做了分类：

> - 积极玩法：当玩家做好一个动作时，会带来可感知的正结果；玩家做得不好或未做任何期望的动作时，带来可感知的较差的正结果、零结果或负结果。
>   - 积极玩法的关键词是“达成”。给与玩家选项去达成游戏内目标。比如动作游戏中的攻击，跳台的跳跃平台等。
> - 消极玩法：当玩家做好一个动作时，会带来可感知的零结果；玩家做得不好或未做任何期望的动作时，带来可感知的负结果。
>   - 消极玩法的关键词是“避免”。给与玩家选项来避免远离游戏内目标。比如动作游戏中的防御、滚动，弹幕游戏里的子弹等。
> - 除了积极玩法和消极玩法以外，还有一种情况就是如上文所说的玩家行为会带来感知上的模糊结果或者说混淆的结果，比较常见在古典游戏、桌游和策略游戏中。

- 然后分析了积极玩法和消极玩法的特点：
  - 积极玩法
    - 易学习
    - 新手友好
  - 消极玩法与积极玩法相反

- 最后指出了如何应用这两种玩法：
  - 消极玩法可以通过加入正反馈让游戏更亲民。
    - 弹反 vs. 格挡
  - 要考虑消极玩法的上手难度。
  - 还有一点我不是很赞同。
    - “允许玩家能够提升积极玩法的水平，暂时忽略消极玩法的部分来进行游戏。”
    - 还是要具体游戏具体讨论吧。

### [如何设计您的游戏UI](https://docs.godotengine.org/zh_CN/latest/getting_started/step_by_step/ui_main_menu.html)

- 要设计一个好的UI，您首先要提出一个粗略的模型：一个纯绘制版本，重点放在UI组件的位置、它们的大小、和用户交互上。您只需要纸和笔。在此阶段，您不应该使用精美的图形和最终图形。然后，您只需要简单的占位符精灵，就可以进入Godot。您要确保玩家可以使用这些占位符在界面周围找到自己的路。

![](@/assets/images/ui_design_rough.png)

- 占位符不一定意味着难看，但是您应该保持图形简单和干净。在让玩家对UI进行游戏测试之前，请避免使用特殊效果、动画、和详细的插图。 否则：
  1.  不好的图形可能会误导玩家对游戏的看法，您将会错过宝贵的反馈意见。
  2.  如果用户体验不好，你还得重新设计一些角色。

> 总是首先尝试让界面使用简单的文本和框。以后替换纹理很容易。专业的UX设计师通常使用灰色的简单轮廓和框。当您去掉颜色和精美的视觉效果时，正确地设置和放置UI元素要容易得多。它可以帮助您完善将要建立的设计基础。

- 在Godot中有两种方法来设计UI。 您可以：
  1.  先将UI全部放在一个场景中，最后再提取出一些具有共性的组件保存为可重用场景。
  2.  从可复用组件构建模板场景，并创建从基本场景继承的特定组件。

- 分解UI模型
  - 这是我找到合适容器的三个经验法则：
    1. 将UI分解为嵌套的盒式结构。从包含所有内容的最大盒子，到包含一个像带有标签的进度条、面板或按钮这样的小部件的小盒子。所有一切都是盒子。
    2. 如果一个区域周围有一些填充，使用 MarginContainer。
    3. 如果元素是按行或列组织的，请使用 HBoxContainer 或 `VBoxContainer`组件。
  - 这些规则足以使我们入门，并且对于简单的界面也能很好地工作。
  - 对于主菜单，最大的框是整个游戏窗口。窗口的边缘和第一个组件之间有填充：这儿应该使用一个 MarginContainer。然后，将屏幕分为两列，因此我们将使用一个 HBoxContainer。在左栏中，我们将使用一个 VBoxContainer 来管理行。在右列中，我们将使用一个 CenterContainer 将插图居中。

![](@/assets/images/ui_mockup_break_down.png)

### [Unity 2D AI自动寻路功能 astar pathfinding](https://www.bilibili.com/video/av55205727)

- 3d也可以用，而且可以与物理系统交互

### [毕设分享：用 Unity 探究 2D 游戏的打击感](https://indienova.com/indie-game-development/2d-strike-feeling-in-unity/)

1. 帧冻结（顿帧）
2. 击退距离
3. 特效
   - 打击火花（HitFire）
   - 精灵（Sprite）抖动
   - 屏幕震动
   - 颜色变化

### [Visionaire Studio 点击冒险游戏引擎](https://indienova.com/indie-game-development/visionaire-studio-for-beginner-1/)

![](@/assets/images/visionaire.webp)

### 文字游戏引擎*ink*

- [文字游戏引擎 ink 初探（上）：初步了解](https://indienova.com/indie-game-development/sneak-peak-of-ink-markup-language-1/)
- [文字游戏引擎 ink 初探（下）：Unity 整合](https://indienova.com/indie-game-development/sneak-peak-of-ink-markup-language-2/)
- [高阶 Inky 残卷](https://indienova.com/u/blindvolf/blogread/23257)
- [用 Inky 编写基于 Web 的互动小说](https://indienova.com/u/blindvolf/blogread/23249)

### [【风农翻译】像素宝典 #1](https://indienova.com/indie-game-development/saint11-pixel-art-tutorial-1/)

- 是个系列。

### [Riot Games 出了一套游戏美术教程 #1：核心原则 _So you wanna make games??_](https://indienova.com/indie-game-development/riot-so-you-wanna-make-games-1/#iah-2)

- 是个系列。

### [一种 Roguelike 地牢生成算法](https://indienova.com/indie-game-development/roguelike-dungeon-building-algorithm/)
