pragma solidity 0.8.0;
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
//address nft1_address,nft2_address,nft3_address;

contract newNFT is NFTokenMetadata, Ownable{
    mapping (uint256 => address) public nft;
    address[] acc;
    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner{
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
        nft[_tokenId] = _to;
        acc.push(_to);
    }
    function transferF(address _to, uint256 tokenId) public{
        super._transfer(_to, tokenId);
        address from = nft[tokenId];
        nft[tokenId] = _to;
        uint i;
        for(i=0;acc[i]!=from;i++)
            continue;
        acc[i] = _to;
    }
    function accReturn(address wallet_address) view public returns(uint){
        for(uint i=0;i<acc.length;i++){
            if(acc[i]==wallet_address)
                return 1;
        }
        return 0;
    }

}
