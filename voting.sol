// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BareMinimumVoting {
    uint public immutable numberOfCandidates;
    mapping(uint => uint) public voteCounts;
    mapping(address => bool) public hasVoted;

    constructor(uint _numberOfCandidates) {
        require(_numberOfCandidates > 0, "Voting requires at least one candidate/option");
        numberOfCandidates = _numberOfCandidates;
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "Voter has already voted");
        require(_candidateId > 0 && _candidateId <= numberOfCandidates, "Invalid candidate ID");
        hasVoted[msg.sender] = true;
        voteCounts[_candidateId]++;
    }

    function getWinningCandidate() public view returns (uint winningCandidateId, uint winningVoteCounts) {
        uint maxVotes = 0;
        uint winnerId = 0;

        for (uint i = 1; i <= numberOfCandidates; i++) {
            if (voteCounts[i] > maxVotes) {
                maxVotes = voteCounts[i];
                winnerId = i;
            }
        }
        return (winnerId, maxVotes);
    }
}
