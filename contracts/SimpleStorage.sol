pragma solidity ^0.4.19;

contract SimpleStorage {

    struct Message {
        string word; // 留言
        address from; // 留言者地址
        string timestamp ; // 留言unix时间戳
    }

    Message[] private wordArr;

    function setWord(string s, string t) public {
        wordArr.push(Message({
            word: s,
            from: msg.sender,
            timestamp: t
        }));
    }

    function getRandomWord(uint random) public view returns (uint, string, address, string) {
        if(wordArr.length==0){
            return (0, "", msg.sender, "");
        }else{
            Message storage result = wordArr[random];
            return (wordArr.length, result.word, result.from, result.timestamp);
        }
        
    }

}
