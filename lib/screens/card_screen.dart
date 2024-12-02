import 'package:flutter/material.dart';
import 'package:p0kemon/services/card_service.dart';
import 'package:p0kemon/models/card_model.dart';
import 'package:p0kemon/screens/home_screen.dart'; // Import the HomeScreen

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CardService _cardService = CardService();
  List<CardModel> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final cards = await _cardService.fetchCards();
      setState(() {
        _cards = cards;
      });
    } catch (e) {
      _showSnackBar('Failed to load cards: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createCard(Map<String, dynamic> cardData) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _cardService.createCard(cardData);
      _showSnackBar('Card created successfully');
      _loadCards();
    } catch (e) {
      _showSnackBar('Failed to create card: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteCard(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _cardService.deleteCard(id);
      _showSnackBar('Card deleted successfully');
      _loadCards();
    } catch (e) {
      _showSnackBar('Failed to delete card: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateCard(int id, Map<String, dynamic> updatedData) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _cardService.updateCard(id, updatedData);
      _showSnackBar('Card updated successfully');
      _loadCards();
    } catch (e) {
      _showSnackBar('Failed to update card: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCreateDialog() {
    final _nameController = TextEditingController();
    final _typeController = TextEditingController();
    final _rarityController = TextEditingController();
    final _priceController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: _rarityController,
                decoration: InputDecoration(labelText: 'Rarity'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _createCard({
                'name': _nameController.text,
                'type': _typeController.text,
                'rarity': _rarityController.text,
                'price': double.tryParse(_priceController.text) ?? 0.0,
                'description': _descriptionController.text,
              });
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(CardModel card) {
    final _nameController = TextEditingController(text: card.name);
    final _typeController = TextEditingController(text: card.type);
    final _rarityController = TextEditingController(text: card.rarity);
    final _priceController = TextEditingController(text: card.price.toString());
    final _descriptionController =
        TextEditingController(text: card.description ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Card'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: _rarityController,
                decoration: InputDecoration(labelText: 'Rarity'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updateCard(card.id, {
                'name': _nameController.text,
                'type': _typeController.text,
                'rarity': _rarityController.text,
                'price': double.tryParse(_priceController.text) ?? 0.0,
                'description': _descriptionController.text,
              });
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Cards'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => HomeScreen()), // Navigate to HomeScreen
            );
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cards.isEmpty
              ? Center(child: Text('No cards available'))
              : ListView.builder(
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    return ListTile(
                      title: Text(card.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type: ${card.type}'),
                          Text('Rarity: ${card.rarity}'),
                          Text('Price: \$${card.price.toStringAsFixed(2)}'),
                          Text(
                              'Description: ${card.description ?? "No description"}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showUpdateDialog(card)),
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCard(card.id)),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Card',
      ),
    );
  }
}
