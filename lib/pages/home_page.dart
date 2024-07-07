import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  const HomePage({Key? key, required this.supabaseClient}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  List<dynamic> _movies = [];

  Future<void> _addMovie() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final releaseDate = _releaseDateController.text;

    if (title.isNotEmpty && description.isNotEmpty && releaseDate.isNotEmpty) {
      try {
        await widget.supabaseClient.from('movies').insert({
          'title': title,
          'description': description,
          'release_date': releaseDate,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Movie added successfully')),
        );
        _titleController.clear();
        _descriptionController.clear();
        _releaseDateController.clear();
        _fetchMovies(); // Refresh the list of movies
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add movie: $error')),
        );
      }
    }
  }

  Future<void> _fetchMovies() async {
    try {
      final data = await widget.supabaseClient.from('movies').select();

      setState(() {
        _movies = data;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch movies: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _releaseDateController,
              decoration: const InputDecoration(labelText: 'Release Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMovie,
              child: const Text('Add Movie'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ListTile(
                    title: Text(movie['title']),
                    subtitle: Text(movie['description']),
                    trailing: Text(movie['release_date']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
