# [Riot 搜索引擎](https://github.com/yanjingang/riot)

<!--<img align="right" src="https://raw.githubusercontent.com/yanjingang/ego/master/logo.jpg">-->
<!--<a href="https://circleci.com/gh/yanjingang/ego/tree/dev"><img src="https://img.shields.io/circleci/project/yanjingang/ego/dev.svg" alt="Build Status"></a>-->
[![CircleCI Status](https://circleci.com/gh/yanjingang/riot.svg?style=shield)](https://circleci.com/gh/yanjingang/riot)
![Appveyor](https://ci.appveyor.com/api/projects/status/github/yanjingang/riot?branch=master&svg=true)
[![codecov](https://codecov.io/gh/yanjingang/riot/branch/master/graph/badge.svg)](https://codecov.io/gh/yanjingang/riot)
[![Build Status](https://travis-ci.org/yanjingang/riot.svg)](https://travis-ci.org/yanjingang/riot)
[![Go Report Card](https://goreportcard.com/badge/github.com/yanjingang/riot)](https://goreportcard.com/report/github.com/yanjingang/riot)
[![GoDoc](https://godoc.org/github.com/yanjingang/riot?status.svg)](https://godoc.org/github.com/yanjingang/riot)
[![GitHub release](https://img.shields.io/github/release/yanjingang/riot.svg)](https://github.com/yanjingang/riot/releases/latest)
[![Join the chat at https://gitter.im/yanjingang/ego](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/yanjingang/ego?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
<!--<a href="https://github.com/yanjingang/ego/releases"><img src="https://img.shields.io/badge/%20version%20-%206.0.0%20-blue.svg?style=flat-square" alt="Releases"></a>-->


Go Open Source, Distributed, Simple and efficient full text search engine.

# Features

* [高效索引和搜索](/docs/zh/benchmarking.md)（1M 条微博 500M 数据28秒索引完，1.65毫秒搜索响应时间，19K 搜索 QPS）
* 支持中文分词（使用 [gse 分词包](https://github.com/go-ego/gse)并发分词，速度 27MB/秒）
* 支持[逻辑搜索](https://github.com/yanjingang/riot/blob/master/docs/zh/logic.md)
* 支持中文转拼音搜索(使用 [gpy](https://github.com/go-ego/gpy) 中文转拼音)
* 支持计算关键词在文本中的[紧邻距离](/docs/zh/token_proximity.md)（token proximity）
* 支持计算[BM25相关度](/docs/zh/bm25.md)
* 支持[自定义评分字段和评分规则](/docs/zh/custom_scoring_criteria.md)
* 支持[在线添加、删除索引](/docs/zh/realtime_indexing.md)
* 支持多种[持久存储](/docs/zh/persistent_storage.md)
* 支持 heartbeat
* 支持[分布式索引和搜索](https://github.com/yanjingang/riot/tree/master/data)
* 可实现[分布式索引和搜索](/docs/zh/distributed_indexing_and_search.md)
* 采用对商业应用友好的[Apache License v2](/LICENSE)发布

* [查看分词规则](https://github.com/yanjingang/riot/blob/master/docs/zh/segmenter.md)
<!-- 
Riot v0.10.0 was released in Nov 2017, check the [Changelog](https://github.com/yanjingang/riot/blob/master/docs/CHANGELOG.md) for the full details. -->

QQ 群: 120563750

## 安装/更新

```
#0.配置GOPROXY
 vim ~/.bashrc
  #go
  export GO111MODULE=on
  export GOPROXY=https://goproxy.io

source ~/.bashrc

#1.直接安装
go get -u github.com/yanjingang/riot

#或 本地编译
git clone https://github.com/yanjingang/riot.git
cd riot
go build

#测试
go run examples/simple/zh/main.go 
```

## Requirements

需要 Go 版本至少 1.8

### Dependencies

Riot 使用 go module 或 dep 管理依赖. 


## 使用

先看一个例子（来自 [simplest_example.go](/examples/simple/zh/main.go)）
```go
package main

import (
	"log"

	"github.com/yanjingang/riot"
	"github.com/yanjingang/riot/types"
)

var (
	// searcher 是协程安全的
	searcher = riot.Engine{}
)

func main() {
	// 初始化
	searcher.Init(types.EngineOpts{
		Using:             3,
		GseDict: "zh",
		// GseDict: "your gopath"+"/src/github.com/yanjingang/riot/data/dict/dictionary.txt",
	})
	defer searcher.Close()

	text := "《复仇者联盟3：无限战争》是全片使用IMAX摄影机拍摄"
	text1 := "在IMAX影院放映时"
	text2 := "全片以上下扩展至IMAX 1.9：1的宽高比来呈现"
	
	// 将文档加入索引，docId 从1开始
	searcher.Index("1", types.DocData{Content: text})
	searcher.Index("2", types.DocData{Content: text1}, false)
	searcher.Index("3", types.DocData{Content: text2}, true)

	// 等待索引刷新完毕
	searcher.Flush()
	// engine.FlushIndex()

	// 搜索输出格式见 types.SearchResp 结构体
	log.Print(searcher.Search(types.SearchReq{Text:"复仇者"}))
}
```

是不是很简单！

然后看看一个[入门教程](/docs/zh/codelab.md)，教你用不到200行 Go 代码实现一个微博搜索网站。

### 使用默认引擎:

```Go
package main

import (
	"log"

	"github.com/yanjingang/riot"
	"github.com/yanjingang/riot/types"
)

var (
	searcher = riot.New("zh")
)

func main() {
	data := types.DocData{Content: `I wonder how, I wonder why
		, I wonder where they are`}
	data1 := types.DocData{Content: "所以, 你好, 再见"}
	data2 := types.DocData{Content: "没有理由"}

	searcher.Index("1", data)
	searcher.Index("2", data1)
	searcher.IndexDoc("3", data2)
	searcher.Flush()

	req := types.SearchReq{Text: "你好"}
	search := searcher.Search(req)
	log.Println("search...", search)
}
```

#### [查看更多例子](https://github.com/yanjingang/riot/tree/master/examples)

#### [持久化的例子](https://github.com/yanjingang/riot/blob/master/examples/store/main.go)
#### [逻辑搜索的例子](https://github.com/yanjingang/riot/blob/master/examples/logic/main.go)

#### [拼音搜索的例子](https://github.com/yanjingang/riot/blob/master/examples/pinyin/main.go)

#### [不同字典和语言例子](https://github.com/yanjingang/riot/blob/master/examples/dict/main.go)

#### [benchmark](https://github.com/yanjingang/riot/blob/master/examples/benchmark/benchmark.go)

#### [Riot 搜索模板, 客户端和字典](https://github.com/yanjingang/riot/tree/master/data)


## [Build-tools](https://github.com/yanjingang/re)
```
go get -u github.com/yanjingang/re 
```
### re riot
创建 riot 项目

```
$ re riot my-riotapp
```

### re run

运行我们创建的 riot 项目, 你可以导航到应用程序文件夹并执行:
```
$ cd my-riotapp && re run
```

## 主要改进:

- 增加逻辑搜索 
- 增加拼音搜索 
- 增加分布式 
- 分词等改进 
- 增加更多 api
- 支持 heartbeat
- 修复 bug
- 删除依赖 cgo 的存储引擎, 增加 badger和 leveldb 持久化引擎

## Authors
* [The author is vz](https://github.com/vcaesar)
* [Maintainers](https://github.com/orgs/yanjingang/people)
* [Contributors](https://github.com/yanjingang/riot/graphs/contributors)

## Donate

支持 riot, [buy me a coffee](https://github.com/go-vgo/buy-me-a-coffee).

#### Paypal

Donate money by [paypal](https://www.paypal.me/veni0/25) to my account [vzvway@gmail.com](vzvway@gmail.com)

## 其它

* [为什么要有 riot 引擎](/docs/zh/why_riot.md)
* [联系方式](/docs/zh/feedback.md)

## License

Riot is primarily distributed under the terms of the Apache License (Version 2.0), base on [wukong](https://github.com/huichen/wukong).
