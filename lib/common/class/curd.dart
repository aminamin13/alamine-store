import 'dart:convert';
import 'dart:io';

import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/common/functions/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      try {
        var response = await http.post(Uri.parse(linkurl), body: data);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Handle concatenated JSON objects
        String cleanedBody = response.body.trim();
        List<String> jsonObjects = cleanedBody.split('}{');
        List<Map> parsedResponses = [];

        // Parse each JSON object
        for (int i = 0; i < jsonObjects.length; i++) {
          String json = jsonObjects[i];
          if (i > 0) {
            json = '{$json'; // Add opening brace for subsequent objects
          }
          if (i < jsonObjects.length - 1) {
            json = '$json}'; // Add closing brace for previous objects
          }
          parsedResponses.add(jsonDecode(json));
        }

        // Return the last parsed response (or handle all responses if needed)
        return Right(parsedResponses.last);
      } catch (e) {
        print("Error during response parsing: $e");
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithImageOne(
      url, data, File? image,
      [String? namerequest]) async {
    namerequest ??= "files";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest, stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithMultipleImages(
      String url, Map<String, String> data, List<XFile>? images,
      [String? namerequest]) async {
    namerequest ??= "files";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        var image = images[i];
        var length = await image.length();
        var stream = http.ByteStream(image.openRead());
        stream.cast();
        var multipartFile = http.MultipartFile(
          '$namerequest[$i]',
          stream,
          length,
          filename: basename(image.path),
        );
        request.files.add(multipartFile);
      }
    }

    // Add data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    // Send request
    var myrequest = await request.send();

    // Get response body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
