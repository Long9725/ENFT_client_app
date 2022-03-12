import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;

// KAS: Klaytn Api Service
class KlaytnApi {
  final basicUri = 'https://node-api.klaytnapi.com/v1';
  final authHttp = http_auth.BasicAuthClient(
      dotenv.env['KAS_ACCESS_KEY_ID'] ?? "",
      dotenv.env['KAS_SECRET_ACCESS_KEY'] ?? "");
  final Map<String, String> headers = <String, String>{
    'Content-type': 'application/json'
  };
  final Map<String, String> xChainIdHeaders = <String, String>{
    'x-chain-id': '1001',
    'Content-type': 'application/json'
  };
  // Get user wallet balance
  // input: userAddress
  // response: {"jsonrpc": "2.0", "id":1, "result": Balance string, peb}
  Future<String> getBalance(String userAddress) async {
    Uri uri = Uri.parse(basicUri + '/klaytn');
    String body = jsonEncode(<String, dynamic>{
      'jsonrpc': '2.0',
      'method': 'klay_getBalance',
      'params': [userAddress, "latest"],
      'id': 1
    });
    final http.Response response =
        await authHttp.post(uri, body: body, headers: xChainIdHeaders);
    final responseBody = Map<String, dynamic>.from(json.decode(response.body));
    return responseBody['result'];
  }

  // Look up user NFTs
  // input: NFT contract address and NFT ID
  // response: {"uri": NFT json, "owner": owner address}
  void LookUpNFT(String address, String id) async {
    Uri uri = Uri.parse(basicUri + '/metadata/nft/$address/$id');
    final http.Response response = await http.get(uri, headers: headers);
  }

  // Look up user NFTs from ENFT server
  // http://server/caver/myNFT?address
  void LookUpNFTFromENFT(String address, String id) async {
    Uri uri = Uri.parse('http://server_ip/caver/myNFT?$address');
    final http.Response response = await http.get(uri, headers: headers);
  }

}
