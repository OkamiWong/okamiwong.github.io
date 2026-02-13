---
pubDatetime: 2020-01-04T00:00:00Z
title: 'Unity 笔记本'
featured: false
draft: false
tags:
  - 游戏制作
  - Unity
  - 集合
description: '由于Okami很懒，他只记不太好搜的。'
---

由于Okami很懒，他只记不太好搜的。

内容按添加时间的倒序排列。

---

## Unity 2D下固定Camera显示的场景宽度

见链接中2017.03.28的回答
[Fixed width, relative height, on different aspect ratio screen?](https://answers.unity.com/questions/778670/fixed-width-relative-height-on-different-aspect-ra.html)

直接将以下脚本拖到Camera上

```csharp
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    //Set a fixed horizontal FOV
    public float horizontalFOV = 120f;
    //somewhere in update if screen is resizable
    Camera cam;

    void Awake()
    {
        cam = GetComponent<Camera>();
    }

    void FixedUpdate()
    {
        cam.fieldOfView = calcVertivalFOV(horizontalFOV, Camera.main.aspect);
    }

    private float calcVertivalFOV(float hFOVInDeg, float aspectRatio)
    {
        float hFOVInRads = hFOVInDeg * Mathf.Deg2Rad;
        float vFOVInRads = 2 * Mathf.Atan(Mathf.Tan(hFOVInRads / 2) / aspectRatio);
        float vFOV = vFOVInRads * Mathf.Rad2Deg;
        return vFOV;
    }
}
```

## 在Unity中在不改变音高的前提下改变音频片段的播放速度

见链接中2018年10月的回答
[How I can change the speed of a song or sound?](https://answers.unity.com/questions/25139/how-i-can-change-the-speed-of-a-song-or-sound.html)

- 目前不适用于WebGL，因Audio Mixer不被支持。

1. 将Audio Source的outputAudioMixerGroup设为刚添加的Audio Mixer Group
2. 添加一个Audio Mixer Group
3. 在这个Audio Mixer Group中加入Pitch Shifter效果
4. 将Pitch Shifter的Pitch参数暴露到脚本中
5. 若使播放速度变为原来的x倍
   1. 将Audio Source的pitch参数乘x
   2. 将Pitch Shifter的pitch参数除x

## 在Unity C# Scripts中使用event系统

1. [【Unity3D技巧】在Unity中使用事件/委托机制（event/delegate）进行GameObject之间的通信](https://www.cnblogs.com/neverdie/p/Unity3D_event_delegate_1.html)
2. [【Unity3D技巧】在Unity中使用事件/委托机制（event/delegate）进行GameObject之间的通信 (二) : 引入中间层NotificationCenter](https://www.cnblogs.com/neverdie/p/3790879.html)

## 在Unity C# Scripts中StartCoroutine/yield return这个模式到底是怎么应用的？其中的原理是什么

1. [Coroutine，你究竟干了什么](https://blog.csdn.net/tkokof1/article/details/11842673)
2. [Coroutine，你究竟干了什么？（小续）](https://blog.csdn.net/tkokof1/article/details/12834939)

## C#中单问号'?'的一种神奇但少见介绍的用法

```csharp
Object something = null;
something.DoSomething();
//An error will be thrown.
```

```csharp
//However, if you use '?'
Object something = null;
something?.DoSomething();
//Nothing will happen.
//But when something is declared as an instance that really can "DoSomething()", it will actually do it.
```
