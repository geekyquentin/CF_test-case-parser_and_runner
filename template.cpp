#pragma GCC optimize("Ofast")
#pragma GCC target("sse,sse2,sse3,ssse3,sse4,popcnt,abm,mmx,avx,avx2,fma")
#pragma GCC optimize("unroll-loops")

#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

typedef vector<int> v32;

#define MOD 1000000007
#define MOD2 998244353

#define all(x) (x).begin(), (x).end()
#define sz(x) ((ll)(x).size())
#define pb push_back
#define fi first
#define se second

#define fast_cin()                    \
    ios_base::sync_with_stdio(false); \
    cin.tie(NULL);                    \
    cout.tie(NULL);

#define ln "\n"
#define dbg(x) cout << #x << " = " << x << ln

void solve() {
}

int main() {
    fast_cin();
    ll t;
    cin >> t;
    for (ll it = 1; it <= t; it++)
        solve();

    return 0;
}