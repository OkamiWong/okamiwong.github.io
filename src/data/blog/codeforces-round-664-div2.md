---
pubDatetime: 2020-08-13T00:00:00Z
title: 'Codeforces Round 664 (Div. 2) 题解'
featured: false
draft: false
tags:
  - 题解
  - Codeforces
description: ''
---

# A

- 略

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int inf = 0x3f3f3f3f;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int T;
    cin >> T;
    while (T--) {
        int r, g, b, w;
        cin >> r >> g >> b >> w;

        int odd_count = 0;
        odd_count = (r&1) + (g&1) + (b&1) +(w&1);
        if(odd_count == 0 || odd_count == 1) {
            cout<<"Yes"<<endl;
            continue;
        }
        r--;
        g--;
        b--;
        w += 3;
        if(r < 0 || g < 0 || b < 0) {
            cout<<"No"<<endl;
            continue;
        }
        odd_count = (r & 1) + (g & 1) + (b & 1) + (w & 1);
        if (odd_count == 0 || odd_count == 1) {
            cout << "Yes" << endl;
            continue;
        }

        int delta = min(r, (min(g, b)));
        r -= delta;
        g -= delta;
        b -= delta;
        w += 3*delta;
        if (r < 0 || g < 0 || b < 0) {
            cout << "No" << endl;
            continue;
        }
        odd_count = (r & 1) + (g & 1) + (b & 1) + (w & 1);
        if (odd_count == 0 || odd_count == 1) {
            cout << "Yes" << endl;
            continue;
        }
        cout<<"No"<<endl;
    }
}
```

# B

- 构造答案

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int inf = 0x3f3f3f3f;

int n, m;
void print(int r, int c) { cout << r + 1 << " " << c + 1 << endl; }
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int sr, sc;

    cin >> n >> m >> sr >> sc;
    sr--;
    sc--;

    for (int i = 0; i < n; i++) {
        print(sr, sc);
        for (int j = 0; j < m - 1; j++) {
            sc = (sc + 1) % m;
            print(sr, sc);
        }
        sr = (sr + 1) % n;
    }
    return 0;
}

```

# C

- 才开始想[[二分答案]]，后来发现不满足单调性
- 但是直接[[枚举答案]]的复杂度也可以接受（$10^7$），就直接枚举验证就行

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int inf = 0x3f3f3f3f;
const int maxn = 200 + 5;

int n, m;
int a[maxn], b[maxn];

bool check(int ans) {
    //cout << ans << endl;
    for (int i = 0; i < n; ++i) {
        bool found = false;
        for (int j = 0; j < m; ++j) {
            if (((a[i] & b[j]) | ans) == ans) {
                found = true;
                //cout<<"a:"<<i<<" b:"<<j<<endl;
                break;
            }
        }
        if (!found)
            return false;
    }
    return true;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> n >> m;
    for (int i = 0; i < n; ++i)
        cin >> a[i];
    for (int i = 0; i < m; ++i)
        cin >> b[i];

    for (int i = 0; i < 512; i++)
        if (check(i)) {
            cout << i << endl;
            return 0;
        }
}
```

# D

- [[贪心]]
- 将a值分到会禁言的和不会禁言的大根堆
- 把时间按（d+1）天为一组
- 在最后剩的一个小于等于d+1天的组里
  - 最后一天说会禁言的最大的
  - 剩下的说不会禁言的最大的
- 在之前等于d+1天的组里
  - 如果 没说的会禁言的最大的 大于等于 不会禁言的最大的d+1个的和 就说会禁言的
  - 否则说不会禁言的

## WA原因

- $n \% (d+1) = 0$时忘了把最后一组拿出来特殊处理

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int inf = 0x3f3f3f3f;
const int maxn = 100000 + 5;
int d, n, m, lengthOfNotMuzzle;
priority_queue<ll> willMuzzle, notMuzzleQ;
ll notMuzzle[maxn];
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cin >> n >> d >> m;
    ll a;
    lengthOfNotMuzzle = 0;
    while(!willMuzzle.empty()) willMuzzle.pop();
    while(!notMuzzleQ.empty()) notMuzzleQ.pop();
    for (int i = 0; i < n; i++) {
        cin >> a;
        if (a > m)
            willMuzzle.push(a);
        else
            notMuzzle[lengthOfNotMuzzle++] = a;
    }

    sort(notMuzzle, notMuzzle + lengthOfNotMuzzle);

    ll ans = 0;
    ll groupNumber, remainder;
    groupNumber = n / (d + 1);
    remainder = n % (d + 1);
    if(remainder == 0){
        remainder = d + 1;
        groupNumber--;
    }
    for (int i = 0; i < remainder; i++) {
        if (i == remainder - 1 && !willMuzzle.empty()) {
            ans += willMuzzle.top();
            willMuzzle.pop();
            continue;
        }

        if (lengthOfNotMuzzle > 0) {
            ans += notMuzzle[--lengthOfNotMuzzle];
        }
    }

    while(lengthOfNotMuzzle) {
        ll tmp = 0;
        for(int i = 1; i <= d + 1 && lengthOfNotMuzzle; ++i) {
            tmp += notMuzzle[--lengthOfNotMuzzle];
        }
        notMuzzleQ.push(tmp);
    }

    for (int i = 0; i < groupNumber; i++) {
        ll muzzleIncome = 0;
        if (!willMuzzle.empty())
            muzzleIncome = willMuzzle.top();
        ll notMuzzleIncome = 0;
        if (!notMuzzleQ.empty())
            notMuzzleIncome = notMuzzleQ.top();
        if (muzzleIncome >= notMuzzleIncome) {
            ans += muzzleIncome;
            willMuzzle.pop();
        } else {
            ans += notMuzzleIncome;
            notMuzzleQ.pop();
        }
    }
    cout << ans << endl;
    return 0;
}
```

# E

- 看起来与[[强连通分量]]、环之类的有关系

## 官方题解

- 题意：给定有 $n$ 个顶点 $m$ 条边的有向图，每个顶点的最大出度为 $k$，每个边都有一个独特的权值。若告诉小B一个 Tuple $(c_1, c_2, ... , c_k) | 1 \leq c_i \leq i$，小B就会在出度为 $d$ 的定点上走权值为第 $c_d$ 小的边到达下一个顶点。问：有多少个这样的 Tuple，使得无论小B从哪个顶点开始走经过有限步会回到起点。
- 注意到 $1 \leq k \leq 9$ 很小，而所有可能的 Tuples 有 $k!$ 个，可以直接枚举所有 Tuples 看是否满足题意。问题转化为如何验证一个 Tuple 是否满足条件。
- 如果一个 Tuple 满足条件，那么按照规则在图上挑出来会走的n条边会组成若干个不相交的环。这就是说，如果从每个顶点按一个 Tuple 走到的点的集合，恰好是 $\{1, 2, ..., n \}$，则这个 Tuple 是合法的。
- 我们可以把顶点按出度分类，然后预处理出度为 $d$ 的顶点在 $c_d = i$ 时走到的点的集合。设它为 $s_{d,i}$ 。
- 这样给定 Tuple $T$，如果 $s_{1, T_1} \cup s_{2, T_2} \cup ... \cup s_{k, T_k} = \{1, 2, ..., n \}$ （$s$ 中元素可重复），$T$ 就合法。
- 因为我们只需要支持**可重复集合取并集**和**比较集合是否相等**两个操作，并不在意集合的内容。我们可以将每个集合 [[Hash]] 成一个整数：每个顶点对应一个随机数，集合取并集就把两个集合加起来取模（常用模数 $10^9 + 7$）。这样就可以加速验证 Tuple 的过程。
- 最终复杂度：$O(mlog(m) + k!)$ （排序+验证）

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int inf = 0x3f3f3f3f;
const int MOD = 1e9 + 7;
const int maxn = 200000 + 5;
const int maxk = 9 + 1;
int n, m, k, ans, final_set;
vector<pair<int, int>> edges[maxn];
int hashed_set[maxk][maxk] = {};
int randomized_node_index[maxn] = {};
void insert(int &target_set, int node_index) {
    if (randomized_node_index[node_index] == 0)
        randomized_node_index[node_index] = rand() % MOD + 1;

    target_set = (target_set + randomized_node_index[node_index]) % MOD;
}

int s[maxk] = {};
void cal_ans(int i, int current_t_i) {
    s[i] = (s[i-1] + hashed_set[i][current_t_i]) % MOD;
    if(i == k){
        if(s[i] == final_set)
            ++ans;
        return;
    }
    for(int j = 1; j <= i + 1; ++j)
        cal_ans(i + 1, j);
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    srand(time(0));
    cin >> n >> m >> k;

    int u, v, w;
    for (int i = 1; i <= m; ++i) {
        cin >> u >> v >> w;
        edges[u].push_back(pair<int, int>(w, v));
    }

    for (int i = 1; i <= n; ++i)
        sort(edges[i].begin(), edges[i].end());

    for (int i = 1; i <= n; ++i)
        for (int j = 1; j <= edges[i].size(); ++j)
            insert(hashed_set[edges[i].size()][j], edges[i][j-1].second);

    final_set = 0;
    for(int i = 1; i <= n; ++i)
        insert(final_set, i);
    ans = 0;
    cal_ans(1, 1);

    cout << ans << endl;
    return 0;
    cout<<"fuck";
}
```

# F

- 看起来像[[二分答案]]
- 啊，看了题解也不会，遂弃疗。
