---
pubDatetime: 2020-09-10T00:00:00Z
title: 'Codeforces Round 668 (Div. 2) 题解'
featured: false
draft: false
tags:
  - 题解
  - Codeforces
description: ''
---

# [A. Ahahahahahahahaha](https://codeforces.com/contest/1407/problem/A)

- 略

# [B. Big Vova](https://codeforces.com/contest/1407/problem/B)

- 注意到一组数据中 $\text{sum}(n) < 10^3$, $n^2$ [[贪心]]即可。

# [C. Chocolate Bunny](https://codeforces.com/contest/1407/problem/C)

- [[交互题]]
- 因为数组中两个数一定互不相同，所以对于任意两个数一定有绝对大于或者绝对小于的关系。
- 任取两个未知的数 $a$ 和 $b$，计算 $a \% b$ 和 $b \% a$的结果，较大的那个结果一定是小数模大数的结果，所以就知道了两个数中较小的那一个。
- 重复以上过程直到剩一个数，则这个数就是最大的，也就是 $n$。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int n;
    cin >> n;
    vector<int> ans(n, 0);
    for (int i = 0; i < n; ++i) {
        int last_j = 0;
        while (ans[i] == 0) {
            // cout<<i<<" "<<last_j<<endl;
            int j = i + 1;
            if (last_j != 0)
                j = last_j + 1;
            while (j < n && ans[j] != 0) {
                ++j;
            }
            if (j >= n) {
                ans[i] = n;
                cout << "!";
                for (auto x : ans)
                    cout << ' ' << x;
                cout << endl;
                return 0;
            }
            last_j = j;
            int q_i_mod_j, q_j_mod_i;
            cout << "? " << i + 1 << " " << j + 1 << endl;
            cout.flush();
            cin >> q_i_mod_j;
            cout << "? " << j + 1 << " " << i + 1 << endl;
            cout.flush();
            cin >> q_j_mod_i;
            if (q_i_mod_j > q_j_mod_i)
                ans[i] = q_i_mod_j;
            else
                ans[j] = q_j_mod_i;
        }
    }
}
```

# [D. Discrete Centrifugal Jumps](https://codeforces.com/contest/1407/problem/D)

## 官方题解

- 先考虑从左往右跳（即从 $1$ 到 $n$），中间的楼全都小于两端，设左右端点分别为 $x$ 和 $y$
- 则以下两个性质至少有一个满足，并且满足这两个性质其中一个就可以反推两个端点可以互跳
  1.  $h(y) >= h(x)$ 且 $h(y)$ 是 $x$ 右侧第一个大于等于 $h(x)$ 的
  2.  $h(y) <= h(x)$ 且 $h(x)$ 是 $y$ 左侧第一个大于等于 $h(y)$ 的
- 那我们从左往右扫一遍，然后维护一个单调递减的[[单调栈]]，就可以找到每个点左侧第一个比它高的点了。
- 从右往左 / 中间的楼全都大于两端的情况类比即可。
- 官方题解估计可以互调的点对是 $O(n)$ 级别的，不知道如何证。
- 官方题解直接从左往右[[DP]]，不知道如何证单调性，但是不利用单调性也可以[[BFS]]找最短路。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    cin >> n;

    vector<int> h(n);
    for (int i = 0; i < n; ++i)
        cin >> h[i];

    stack<pair<int, int>> s;
    vector<vector<int>> jump(n);

    // The nearest greater from left
    for (int i = 0; i < n; ++i) {
        while (!s.empty() && s.top().first < h[i])
            s.pop();
        if (!s.empty())
            jump[s.top().second].push_back(i);
        s.push({h[i], i});
    }
    while (!s.empty())
        s.pop();

    // The nearest less from left
    for (int i = 0; i < n; ++i) {
        while (!s.empty() && s.top().first > h[i])
            s.pop();
        if (!s.empty())
            jump[s.top().second].push_back(i);
        s.push({h[i], i});
    }
    while (!s.empty())
        s.pop();

    // The nearest greater from right
    for (int i = n - 1; i >= 0; --i) {
        while (!s.empty() && s.top().first < h[i])
            s.pop();
        if (!s.empty())
            jump[i].push_back(s.top().second);
        s.push({h[i], i});
    }
    while (!s.empty())
        s.pop();

    // The nearest greater from right
    for (int i = n - 1; i >= 0; --i) {
        while (!s.empty() && s.top().first > h[i])
            s.pop();
        if (!s.empty())
            jump[i].push_back(s.top().second);
        s.push({h[i], i});
    }
    while (!s.empty())
        s.pop();

    vector<int> dp(n, INF);
    dp[0] = 0;
    for (int i = 0; i < n; ++i)
        for (auto j : jump[i])
            dp[j] = min(dp[j], dp[i] + 1);
    cout << dp[n - 1] << endl;
    return 0;
}
```

# [E. Egor in the Republic of Dagestan](https://codeforces.com/contest/1407/problem/E)

- [[图论]]
- 题意：
  - 有 $10^5$ 级别的的点和有向边。每个边都是黑色或者白色。初始每个点没有颜色，你要为每个点涂色，从一个点出发只能走相同颜色的边。
  - 问：如何涂色才能使得从 $1$ 号顶点到 $n$ 号顶点的路径不存在，或者最短路最长。输出路径长度和一个可能的涂色方案。

## 官方题解

- 把每个边反向，然后就是求如何涂色才能使得从 $n$ 号顶点到 $1$ 的最短路最长。
- 设 $b[u]$ 和 $w[u]$ 分别代表当 $u$ 是黑色或白色时从 $n$ 号顶点到它的最短路的最大值，$dp[u] = max(b[u], w[u])$
- 初始化 $b[n] = w[n] = dp[n] = 0$，其他为 $+\infty$。
- 从$n$ 开始 [[BFS]] 即可。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n, m;
    cin >> n >> m;
    vector<vector<pair<int, int>>> edges(n);
    for (int i = 0; i < m; ++i) {
        int u, v, t;
        cin >> u >> v >> t;
        edges[v - 1].push_back({u - 1, t});
    }

    vector<int> b(n, INF), w(n, INF), dp(n, INF);
    queue<int> q;
    vector<bool> vis(n, false);
    b[n - 1] = w[n - 1] = dp[n - 1] = 0;
    q.push(n - 1);
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (auto edge : edges[u]) {
            const int &v = edge.first, &type = edge.second;
            if (type == 1)
                w[v] = min(w[v], dp[u] + 1);
            else
                b[v] = min(b[v], dp[u] + 1);
            dp[v] = max(b[v], w[v]);
            if (dp[v] < INF && !vis[v]) {
                vis[v] = true;
                q.push(v);
            }
        }
    }

    cout << (dp[0] < INF ? dp[0] : -1) << endl;
    for (int i = 0; i < n; ++i)
        cout << (dp[i] == w[i] ? 1 : 0);
    cout << endl;
    return 0;
}
```
