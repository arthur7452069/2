pragma solidity ^0.8.0;

contract VotingContract {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;

    event VoteCasted(address voter, uint candidateId);

    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }

    function addCandidate(string memory name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function vote(uint candidateId) public {
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate ID.");
        require(!voters[msg.sender], "You have already voted.");

        candidates[candidateId].voteCount++;
        voters[msg.sender] = true;

        emit VoteCasted(msg.sender, candidateId);
    }

    function getCandidateVoteCount(uint candidateId) public view returns (uint) {
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate ID.");
        return candidates[candidateId].voteCount;
    }
}
