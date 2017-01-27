使ったライブラリ  
https://github.com/noppoMan/Prorsum  
A Go like concurrent system + networking/http library for Swift that works on Linux and Mac  

Prorsumの作者のnoppoManさんにProrsumのインストールの仕方を教えてもらってサンプルを作ったので共有します。

ベンチマーク結果は以下  
![benchmark](https://cloud.githubusercontent.com/assets/1066618/22382780/8c544480-e50a-11e6-816a-0d79c771dcdf.png)

Terminal.appを開いて
以下のコマンドを打つ

```
$ mkdir ProrsumSample
$ cd ProrsumSample
$ swift package init
$ vim Package.swift
```

Package.swiftを以下のように編集

```
import PackageDescription

let package = Package(
    name: "ProrsumSample",
    dependencies: [
        .Package(url: "https://github.com/noppoMan/Prorsum.git", majorVersion: 0, minor: 1),
    ]
)
```

ESC押して、:wqのvimコマンドで、Package.swiftを保存して閉じる

```
$ swift build
$ vim Sources/main.swift
```
Sources/main.swiftを以下のように編集する

``` swift
import Prorsum
import Foundation

let server = try! HTTPServer { (request, writer) in
    do {
        let response = Response(
            headers: ["Server": "Prorsum Micro HTTP Server"],
            body: .buffer("hello Server Side Swift".data)
        )

        try writer.serialize(response)

        writer.close()
    } catch {
        fatalError("\(error)")
    }
}

try! server.bind(host: "0.0.0.0", port: 3000)
print("Server listening at 0.0.0.0:3000")
try! server.listen()

RunLoop.main.run()
```

ESC押して、:wqのvimコマンドで、Sources/main.swiftを保存して閉じる

Terminal.appを開いて
以下のコマンドを打つ

```
$ swift build
$ .build/debug/ProrsumSample
```

最後の.build/debug/ProrsumSampleは、プロジェクト名に合わせて変えてく:wqださいとのこと

Terminal.appで、サーバー立ち上げたまま、Command+Tでタブを開き、

```
ab -n 10000 -c 100 -g out.data http://127.0.0.1:3000/
```

ベンチマークを計測したら、Control+Cで、サーバーを終了して、gnuplotをインストールする

```
$ brew install gnuplot
$ vim apache-benchmark.p
```

apache-benchmark.p

```
# output as png image
set terminal png

# save file to "benchmark.png"
set output "benchmark.png"

# graph title
set title "Server Side Swift for Prorsum\nab -n 10000 -c 100 -g out.data http://127.0.0.1:3000/"

#nicer aspect ratio for image size
set size 1,0.7

# y-axis grid
set grid y

#x-axis label
set xlabel "request"

#y-axis label
set ylabel "response time (ms)"

#plot data from "out.data" using column 9 with smooth sbezier lines
plot "out.data" using 9 smooth sbezier with lines title "something"
```

ESC押して、:wqのvimコマンドで、apache-benchmark.pを保存して閉じる

```
$ gnuplot apache-benchmark.p
$ open benchmark.png
```

ベンチマーク結果は以下  
![benchmark](https://cloud.githubusercontent.com/assets/1066618/22382780/8c544480-e50a-11e6-816a-0d79c771dcdf.png)

計測したマシンとスペック  
<img width="255" alt="2017-01-28 3 58 48" src="https://cloud.githubusercontent.com/assets/1066618/22383694/24baeb5e-e50e-11e6-853b-784fdf109b47.png">

