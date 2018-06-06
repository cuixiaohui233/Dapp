# Dapp

### 准备工作

>#### 安装 Node 

自行下载安装

>#### 安装以太坊节点

由于整个合约代码的执行需要一个虚拟的环境，所以需要安装一个是新以太坊虚拟机的节点，教程选择 TestRPC，现在已经改名字叫 ganache-cli:

`sudo npm install ganache-cli`

老版: `sudo npm install ethereumjs-testrpc truffle`

>#### 创建项目

创建空文件夹：

`truffle unbox react-box`

静等5分钟...

>#### 项目结构

`contracts`:编写智能合约的文件夹，所有智能合约都放置这这个里面

`migration`:部署合约配置的文件夹

`src`:React 的前端调用代码

`test`:只能合约测试用例文件夹

>#### 编写智能合约

在`contract`文件夹下常见 Voting.sol 文件，拷贝以下代码：

    pragma solidity ^0.4.4;

    contract Voting {

      // liyuechun -> 10
      // xietingfeng -> 5
      // liudehua -> 20
      mapping (bytes32 => uint8) public votesReceived;

      // 存储候选人名字的数组
      bytes32[] public candidateList;

      // 构造函数 初始化候选人名单
      function Voting(bytes32[] candidateNames) {

        candidateList = candidateNames;
      }

      // 查询某个候选人的总票数
      function totalVotesFor(bytes32 candidate)  constant returns (uint8) {
        require(validCandidate(candidate) == true);
        // 或者
        // assert(validCandidate(candidate) == true);
        return votesReceived[candidate];
      }

      // 为某个候选人投票
      function voteForCandidate(bytes32 candidate) {
        assert(validCandidate(candidate) == true);
        votesReceived[candidate] += 1;
      }

      // 检索投票的姓名是不是候选人的名字
      function validCandidate(bytes32 candidate) constant returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
          if (candidateList[i] == candidate) {
            return true;
          }
        }
        return false;
      }
    }

>#### 通过remix + metamask 部署到Kovan Test Net

在Google浏览器中安装 `MetaMask`插件

打开 [remix-IDE](http://remix.ethereum.org/)将合约拷贝带里面

>##### 注意

        1.MetaMask钱包一定是等于状态（？）,并且一定要有一定的以太币支付给旷工
        
        2.确保Environment是Injected Web3，如果切换不过来，关掉浏览器重新启动
        
        3.在create函数中输入一个数组，数组里面的内容为候选人名单
        
        4.点击create按钮，会弹出MetaMask界面让你确认，确认提交，过一会儿，合约就部署成功
      
        5.可以测试给某个候选人投票，查询某个候选人的票数
        
由于我的以太币还没有搞下来，so...以上

如何搞到testnet以太币，[查看链接](https://blog.csdn.net/fidelhl/article/details/52573274)
