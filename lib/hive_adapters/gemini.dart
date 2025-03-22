Future<String> generateContent(String prompt) async {
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  final url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": prompt,
              }
            ]
          }
        ],
        "generationConfig": {
          "enforce_json": true
        }
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      // Ensure the response has the correct structure.
      if (decodedResponse['candidates'] != null &&
          decodedResponse['candidates'].isNotEmpty &&
          decodedResponse['candidates'][0]['content'] != null &&
          decodedResponse['candidates'][0]['content']['parts'] != null &&
          decodedResponse['candidates'][0]['content']['parts'].isNotEmpty) {
        return decodedResponse['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return 'Invalid response structure.';
      }

    } else {
      return 'Error: ${response.statusCode}, ${response.body}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}

// Example usage:
Future<void> main() async {
    await dotenv.load(fileName: ".env");
  final result = await generateContent('give me a json object containing a name and an age');
  print(result);
}
