# blockChainWords

### 示例

[http://words.ldsun.com/](http://words.ldsun.com/)

### 说明

基于以太坊区块链上的永存的留言DAPP

* 使用solidity开发
* 基于truffle框架
* 使用 `truffle unbox react` 脚手架
* 部署在以太坊测试网络 `Ropoetn Test Network` 上（没有部署在主网，不是我看不起诸位，是我没币部署😭 ）

### 使用

1. 浏览安装 matemask 钱包的扩展程序，创建钱包
2. 切换至 `Ropoetn Test Network` 测试网络，没有币的[点这里申请eth](https://faucet.metamask.io/)
3. 账户中有代币后，输入留言，点击确认后等待写入即可。

### 本地安装使用

环境： nodejs、[truffle](https://www.ldsun.com/2018/02/07/solidityhan-shu-lei-xing-ji-truffleshi-yong/)

1. 下载至本地
2. 执行 `npm i` 安装依赖
3. 部署合约，不部署也可以使用（使用我已经部署的合约），不部署合约直接跳至第5步。
3. 终端当前目录下，`truffle compile`编译合约，接着部署合约，自行选择部署方式，[参考](https://www.ldsun.com/2018/02/22/ji-yu-react-trufflede-wan-zheng-zhi-neng-he-yue-gou-jian/)
4. 合约部署完成后，得到合约地址，修改`src/App.js`中的合约地址`contractAddress`
5. 终端当前目录下`npm start`启动前端
6. 浏览器`localhost:3000`端口即可查看

### 可能存在的问题

在`linux`下运行项目，如果报错`react-magic`及`aphrodite`未找到，安装即可：

`npm i react-magic aphrodite`

### 其他

欢迎学习solidity智能合约的朋友加入q交流群 236380268 。
