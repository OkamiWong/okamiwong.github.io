---
pubDatetime: 2020-08-29T00:00:00Z
title: 'Educational Codeforces Round 94 题解'
featured: false
draft: false
tags:
  - 题解
  - Codeforces
description: ''
---

# [A. String Similarity](https://codeforces.com/contest/1400/problem/A)

- 构造答案即可。
  - 让第 $i$ 位的字符满足和从左往右第 $i$ 个字符串相似。
  - 即 $ans_i = s_{i + i}$

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
    int t, n;
    string s;
    cin >> t;
    while(t--){
        cin >> n;
        cin >> s;
        string ans = s.substr(0, n);
        for(int i = 1; i < n; ++i)
            ans[i] = s[i<<1];
        cout<<ans<<endl;
    }
    return 0;
}
```

# [B. RPG Protagonist](https://codeforces.com/contest/1400/problem/B)

- 比赛时想复杂了，以为要[[动态规划]]或者奇怪的计算。
- 结果题解是枚举Player带多少Sword即可，因为数据范围保证一组测试数据中Sword的个数的总和不超过$2\times10^5$。

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
    int t;
    cin >> t;
    while (t--) {
        int p, f, cnt_s, cnt_w, s, w;
        cin >> p >> f >> cnt_s >> cnt_w >> s >> w;

        // Guarantee that s <= w
        if (s > w) {
            swap(s, w);
            swap(cnt_s, cnt_w);
        }

        // Guarantee that p <= f
        if (p > f)
            swap(p, f);

        int ans = 0, p_s, p_w, f_s, f_w;
        for (int i = 0; i <= cnt_s; ++i) {
            if (i * s > p)
                break;
            p_s = i;
            p_w = min(cnt_w, (p - p_s * s) / w);
            f_s = min(cnt_s - p_s, f / s);
            f_w = min(cnt_w - p_w, (f - f_s * s) / w);
            ans = max(ans, p_s + p_w + f_s + f_w);
        }
        cout << ans << endl;
    }
    return 0;
}
```

# [C. Binary String Reconstruction](https://codeforces.com/contest/1400/problem/C)

- `s[i]`为0当且仅当`w[i-x] = 0`且`w[i+x] = 0`
- 所以遍历一次 $\{s\}$，把 $\{w\}$ 里的 $0$ 都标出来。
- 上一步之后 $\{w\}$ 里没有标记是 $0$ 的元素既可以是 $0$ 也可以是 $1$。
- 再遍历一次 $\{s\}$，找到所有 $s[i] = 1$，标出 $\{w\}$ 里应该是 $1$ 的。
  - 如果根据已经标出来的 $\{w\}$ 里的元素发现 $s[i] = 0$，就出现了矛盾，无解。
- 复杂度 $O( n)$。

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
    int t;
    cin >> t;
    while (t--) {
        string s;
        int x;
        cin >> s >> x;
        string ans = "";
        for (int i = 0; i < s.length(); i++)
            ans.push_back('?');
        for (int i = 0; i < s.length(); i++)
            if (s[i] == '0') {
                if (i - x >= 0)
                    ans[i - x] = '0';
                if (i + x < s.length())
                    ans[i + x] = '0';
            }

        bool possible = true;
        for (int i = 0; i < s.length(); i++) {
            if (s[i] == '1') {
                bool ok = false;
                if (i - x >= 0) {
                    if (ans[i - x] == '1')
                        ok = true;
                    if (ans[i - x] == '?') {
                        ans[i - x] = '1';
                        ok = true;
                    }
                }
                if (!ok && i + x < s.length()) {
                    if (ans[i + x] == '1')
                        ok = true;
                    if (ans[i + x] == '?') {
                        ans[i + x] = '1';
                        ok = true;
                    }
                }
                if (!ok) {
                    possible = false;
                    break;
                }
            }
        }
        if(!possible)
            cout<<"-1"<<endl;
        else{
            replace(ans.begin(), ans.end(), '?', '1');
            cout<<ans<<endl;
        }
    }
    return 0;
}
```

# [D. Zigzags](https://codeforces.com/contest/1400/problem/D)

- 如果把所有相等的元素组合当作一个区间，那么这个问题就问有多少相交部分长度大于等于2且互不包含的区间对。
- 首先找出所有的区间：
  - 像桶排序一样，对每一个值用一个桶存下它所有出现的位置。
  - 每个桶里任意两个元素组成一个区间。
- 设两个区间是 $[l, r]$ 和 $[x, y]$，如果同时满足 $l<x$, $x<r$, $r<y$，则这两个区间符合题意，为答案贡献 $1$。
- 为了保证计数不重复，我们维护两个集合，一个是检查过的区间，一个是没检查过的区间。我们每次从没检查过的区间里取一个，去和所有检查过的区间做比较，满足条件就答案加一。
- 这样时间复杂度是 $O(n^4)$，因为可能有 $O(n^2)$ 个区间，显然过不了。
- 考虑优化检查这一步：
  - 如果我们按 **区间左端点由小到大** 的顺序来把区间添加到检查过的集合里，那么 $l<x$ 条件就天然满足。
  - 这样就是问检查过的区间集合里有多少右端点满足 $x<r$ 和 $r<y$。
  - 这不就区间和嘛，设个数组 ${c}$ 初始化全都是0。
  - 我们每次检查完毕一个区间 $[x, y]$ 时，就把 $c_y$ 加一。
  - 那么满足 $x<r$ 和 $r<y$ 的区间右端点数目就是 $sum(x+1, y-1)$。
  - 用线段树/树状数组维护即可。
- 时间复杂度 $O( n \log n)$。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

const int MAXN = 3000 + 5;
ll a[MAXN];
vector<ll> buckets[MAXN];
ll bucket_heads[MAXN];
#define lowbit(_a) (_a & -_a)
ll c[MAXN << 2], n;
ll sum(ll x) {
    ll ret = 0;
    while (x) {
        ret += c[x];
        x -= lowbit(x);
    }
    return ret;
}
void add(ll x, ll d) {
    while (x <= n) {
        c[x] += d;
        x += lowbit(x);
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    ll t;
    cin >> t;
    while (t--) {
        cin >> n;
        for (ll i = 0; i < n; ++i) {
            cin >> a[i];
            buckets[i].clear();
            bucket_heads[i] = 0;
        }
        memset(c, 0, sizeof(c));
        for (ll i = 0; i < n; ++i) {
            buckets[a[i]].push_back(i);
        }
        ll ans = 0;
        for (ll i = 0; i < n; ++i) {
            ll x = i, y;
            bucket_heads[a[i]]++;
            for (ll j = bucket_heads[a[i]]; j < buckets[a[i]].size(); ++j) {
                y = buckets[a[i]][j];
                if (x + 1 <= y - 1)
                    ans += sum(y - 1) - sum(x);
            }
            for (ll j = bucket_heads[a[i]]; j < buckets[a[i]].size(); ++j)
                add(buckets[a[i]][j], 1);
        }
        cout << ans << endl;
    }
    return 0;
}
```

# [E. Clear the Multiset](https://codeforces.com/contest/1400/problem/E)

## 赛场错解

- 把每个连续的高度相同的区域合成一块。
- 每次取出高度最高的一块，把它削成相邻的高度高度最高的一块。
- 时间复杂度 $O(n\log n)$。

## 正解

- 设 $a_m$ 为 $\{a\}$ 里最小的元素
- 考虑如何把 $a_m$ 删掉
  - 如果 $a_m$ 是被 _操作2_ 删掉的，那么最优解里之后不会再有 _操作1_。原因如下：
    - 如果最优解里有 _操作1_，那么肯定用 _操作1_ 时就狂用 _操作1_ 直到一个 _操作1_ 区间里一个数变成0。
    - 若 _操作2_ 删掉后还要用 _操作1_，那么这一系列的 _操作1_ 肯定把比 $a_m$ 小的数变成了0，但是如果之前不直接用 _操作2_ 删掉 $a_m$，这一系列 _操作1_ 肯定也能顺带删掉 $a_m$，所以肯定不是最优解。
- 所以枚举 $a_m$ 的两种删法
  1.  _操作2_ 删掉 $a_m$，则其他数也都是 _操作2_ 删掉的，答案是 $n$
  2.  _操作1_ 删掉 $a_m$，则 $a_m$ 隔出来的左右两区间都有使用 _操作1_ 和 _操作2_ 的可能，递归解决即可。
- 时间复杂度 $O(n^2)$。如果应用 $RMQ$ 算法或者数据结构解决区间最值，则可以优化到 $O( n \log n)$ 或者 $O( n)$。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

const int MAXN = 5000 + 5;

int a[MAXN];

int solve(int l, int r) {
    if (l > r)
        return 0;

    int m = min_element(a + l, a + r + 1) - a;
    int a_m = a[m];
    for (int i = l; i <= r; ++i)
        a[i] -= a_m;

    return min(r - l + 1, solve(l, m - 1) + solve(m + 1, r) + a_m);
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    cin >> n;
    for (int i = 0; i < n; ++i)
        cin >> a[i];
    cout << solve(0, n - 1) << endl;

    return 0;
}
```

# [F. x-prime Substrings](https://codeforces.com/contest/1400/problem/F)

- 给定一个只有数字1-9的字符串 $s$（$|s| \leq 1000$），和整数 $1\leq x \leq 20$，对于这个字符串任意一个连续子串 $sub$，如果 $sub$ 同时满足：
  1.  $sub$ 里每一位数字的合等于 $x$
  2.  $sub$ 不存在一个连续子串，使得这个子串的合能整除 $x$
- 就把 $sub$ 叫做 _x-prime_ 字符串。
- 问：最少从 $s$ 中去掉几个字符，使得 $s$ 不存在 _x-prime_ 子串？

## 正解

- 首先注意到 $x$ 很小，小于等于20，所以对于一个给定 $x$ 的所有 _x-prime_ 子串的总长应该不大，可以暴力枚举出来。（据官方题解说最坏情况总长为 $5000$，我个人推测这个数是靠比赛现场暴力跑出来的，而不是直接推出来的。）
- 有了所有 _x-prime_ 子串，问题转化为：给定一堆总长不超过 $5000$ 的模板串，最少在给定的长度不超过 $1000$ 的主字符串里删掉几个字符，使得主字符串里没有模板串？
- 这个问题具有典型的 [[动态规划]] 特征。设 $dp[x][y]$ 的意义是：在前 $x$ 个字符串中，最少删掉 $dp[x][y]$ 个字符，到达一个合法状态。而 $y$ 应该记录当前状态字符串后缀的性质，因为如果要继续推 $dp[x+1][?]$，我们需要根据当前状态字符串的后缀再加上最后一个字符，判断是不是只能删掉最后一个字符才能转移。
- 让 $y$ 表示当前状态字符串中最长的和某个模板串前缀重合的后缀，这样就可以知道再加一个字符是否依然合法。
- 这个定义其实就和 [[AC自动机]] 的节点定义是一样的。
- 直接暴力处理出所有 _x-prime_ 子串，然后构建AC自动机，之后再DP即可，此时 $y$ 代表AC自动机中节点的编号。

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
const int INF = 0x3f3f3f3f;
const int MOD = 1e9 + 7;

const int CHARACTER_COUNT = 9;

struct AC_auto_mata {
    struct AC_auto_mata_node {
        int next[CHARACTER_COUNT]; // Transition in Trie
        int pre, pre_ch; // The previous node and the character to current node
        bool is_word;

        // When the next transition fails, go back to fail_link and try again
        int fail_link;

        // Cache of where to go from the current node
        int go[CHARACTER_COUNT];

        AC_auto_mata_node() {
            memset(next, -1, sizeof(next));
            memset(go, -1, sizeof(next));
            fail_link = pre = -1;
            is_word = false;
        }
    };

    vector<AC_auto_mata_node> trie;

    AC_auto_mata() { trie.push_back(AC_auto_mata_node()); }

    void insert(string s) {
        int u = 0;
        for (auto ch : s) {
            int c = ch - '1';
            if (trie[u].next[c] == -1) {
                trie.push_back(AC_auto_mata_node());
                trie[trie.size() - 1].pre = u;
                trie[trie.size() - 1].pre_ch = c;
                trie[u].next[c] = trie.size() - 1;
            }
            u = trie[u].next[c];
        }
        trie[u].is_word = true;
    }

    int get_link(int u) {
        if (trie[u].fail_link == -1) {
            if (u == 0 || trie[u].pre == 0)
                trie[u].fail_link = 0;
            else
                trie[u].fail_link = go(get_link(trie[u].pre), trie[u].pre_ch);
        }
        return trie[u].fail_link;
    }

    int go(int u, int c) {
        if (trie[u].go[c] == -1) {
            if (trie[u].next[c] != -1)
                trie[u].go[c] = trie[u].next[c];
            else
                trie[u].go[c] = (u == 0 ? 0 : go(get_link(u), c));
        }
        return trie[u].go[c];
    }
} ac;

string s, t;
int x;

void brute(int sum) {
    if (sum == x) {
        bool is_x_prime = true;
        for (int l = 0; l < t.length(); ++l) {
            int current_sum = 0;
            for (int r = l; r < t.length(); ++r) {
                current_sum += t[r] - '0';
                if (x % current_sum == 0 && current_sum != x)
                    is_x_prime = false;
            }
        }
        if (is_x_prime)
            ac.insert(t);
        return;
    }
    for (int i = 1; i <= min(x - sum, 9); ++i) {
        t += '0' + i;
        brute(sum + i);
        t.pop_back();
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> s >> x;
    brute(0);

    vector<vector<int>> dp(s.size() + 1, vector<int>(ac.trie.size(), INF));
    dp[0][0] = 0;
    for (int i = 0; i < s.size(); ++i)
        for (int j = 0; j < ac.trie.size(); ++j)
            if (dp[i][j] != INF) {
                // Simply delete the next character
                dp[i + 1][j] = min(dp[i + 1][j], dp[i][j] + 1);

                int next = ac.go(j, s[i] - '1');
                if (!ac.trie[next].is_word)
                    // Keep the next character
                    dp[i + 1][next] = min(dp[i + 1][next], dp[i][j]);
            }

    cout << *min_element(dp[s.length()].begin(), dp[s.length()].end()) << endl;
    return 0;
}
```

# G

- [[组合数学]]
- 弃疗。
