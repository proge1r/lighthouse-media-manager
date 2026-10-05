// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MediaManager {
    struct Media {
        uint256 id;
        address owner;
        string cid;
        string title;
        bool isDeleted;
    }

    Media[] public mediaItems;

    event MediaAdded(uint256 indexed id, address indexed owner, string cid, string title);
    event MediaDeleted(uint256 indexed id, address indexed owner);

    function addMedia(string memory _cid, string memory _title) public {
        uint256 newId = mediaItems.length;
        mediaItems.push(Media({
            id: newId,
            owner: msg.sender,
            cid: _cid,
            title: _title,
            isDeleted: false
        }));
        emit MediaAdded(newId, msg.sender, _cid, _title);
    }

    function deleteMedia(uint256 _id) public {
        require(_id < mediaItems.length, "Media does not exist");
        require(mediaItems[_id].owner == msg.sender, "Not owner");
        require(!mediaItems[_id].isDeleted, "Already deleted");

        mediaItems[_id].isDeleted = true;
        emit MediaDeleted(_id, msg.sender);
    }

    function getAllMedia() public view returns (Media[] memory) {
        return mediaItems;
    }
}