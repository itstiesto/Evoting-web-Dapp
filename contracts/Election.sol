//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Election {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    uint256 public candidatecount;
    mapping(address => bool) public voter;

    event eventVote(uint256 indexed _candidateid);

    constructor() {
        addCandidate("Alice");
        addCandidate("Bob");
    }

    function addCandidate(string memory _name) private {
        candidatecount++;
        candidates[candidatecount] = Candidate(candidatecount, _name, 0);
    }

    function vote(uint256 _candidateid) public {
        require(!voter[msg.sender]);
        require(_candidateid > 0 && _candidateid <= candidatecount);

        voter[msg.sender] = true;
        candidates[_candidateid].voteCount++;

        emit eventVote(_candidateid);
    }
}
