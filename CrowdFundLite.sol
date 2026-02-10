// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFundLite{
    enum CampaignState {
        Active,
        Successful,
        Failed
    }
    
    address public owner;
    uint public goalAmount;
    uint public deadline;
    uint public totalRaised;
    CampaignState public state;
    bool public fundsWithdrawn;

    mapping(address => uint) public contributions;
    address[] public contributors;

    constructor(uint _goalAmount, uint _durationInSeconds){
        owner = msg.sender;
        goalAmount = _goalAmount*10**18;
        deadline = block.timestamp + _durationInSeconds;
        state = CampaignState.Active;
    }

    function contribute() payable public
    {
        checkCampaignStatus();
        require(state == CampaignState.Active,"Campaign State not Active");
        require(msg.value>0, "Message value is not more than 0");
        if(contributions[msg.sender] == 0) contributors.push(msg.sender);
        totalRaised += msg.value;
        contributions[msg.sender] += msg.value;
    }

    function checkCampaignStatus() private {
        if(block.timestamp>=deadline){
            if(totalRaised>=goalAmount){
                state = CampaignState.Successful;
            }
            else state = CampaignState.Failed;
        }
    }

    function withdrawFunds() public{
        checkCampaignStatus();
        require(msg.sender == owner);
        require(state == CampaignState.Successful);
        require(fundsWithdrawn == false);
        payable(owner).transfer(address(this).balance);
        fundsWithdrawn = true;
    }

    function refund() public{
        checkCampaignStatus();
        require(state == CampaignState.Failed);
        require(contributions[msg.sender]>0);
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributions[msg.sender]);
    }


}
