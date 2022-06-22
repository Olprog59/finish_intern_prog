import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:finish_intern_prog/constants.dart';

class ServiceAppwrite {
  Client client = Client();
  late Database database;

  ServiceAppwrite() {
    database = Database(client);
    client.setEndpoint('$URL/v1').setProject(PROJECT_ID);
  }

  Future<DocumentList> documentList() async {
    DocumentList response = await database.listDocuments(
      collectionId: DATABASE,
    );
    return response;
  }

  Future<Document> documentGetOne(String documentId) async {
    Document doc = await database.getDocument(
      collectionId: COLLECTION_ID,
      documentId: documentId,
    );
    return doc;
  }

  Future<Document> documentCreate(String documentId, Map<dynamic, dynamic> data) async {
    Document doc = await database.createDocument(
      collectionId: COLLECTION_ID,
      documentId: documentId,
      data: data,
    );
    return doc;
  }

  Future<Document> documentUpdate(String documentId, Map<dynamic, dynamic> data) async {
    Document doc = await database.updateDocument(
      collectionId: COLLECTION_ID,
      documentId: documentId,
      data: data,
    );
    return doc;
  }

  Future<Document> documentDelete(String documentId) async {
    Document doc = await database.deleteDocument(
      collectionId: COLLECTION_ID,
      documentId: documentId,
    );
    return doc;
  }
}
