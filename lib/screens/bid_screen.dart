import 'package:flutter/material.dart';
import 'package:p0kemon/widgets/base_layout.dart';
import 'package:p0kemon/services/bid_service.dart';
import 'package:p0kemon/models/bid_model.dart';

// Main Bid Screen displaying the list of bids
class BidScreen extends StatefulWidget {
  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  final BidService _bidService = BidService();
  late Future<List<BidModel>> _bidsFuture;

  @override
  void initState() {
    super.initState();
    _bidsFuture = _bidService.fetchBids();
  }

  Future<void> _deleteBid(BuildContext context, int id) async {
    try {
      await _bidService.deleteBid(id);
      setState(() {
        _bidsFuture = _bidService.fetchBids();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bid ID $id deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete bid: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      selectedIndex: 1,
      bodyContent: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateBidScreen()),
              ).then((_) {
                setState(() {
                  _bidsFuture = _bidService.fetchBids();
                });
              });
            },
            child: Text('Create New Bid'),
          ),
          Expanded(
            child: FutureBuilder<List<BidModel>>(
              future: _bidsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  List<BidModel> bids = snapshot.data!;
                  return ListView.builder(
                    itemCount: bids.length,
                    itemBuilder: (context, index) {
                      BidModel bid = bids[index];
                      return ListTile(
                        title: Text('Bid ID: ${bid.id}'),
                        subtitle: Text(
                            'Card: ${bid.cardName}\nBid Price: \$${bid.bidPrice}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(bid.status),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateBidScreen(bid: bid),
                                  ),
                                ).then((_) {
                                  setState(() {
                                    _bidsFuture = _bidService.fetchBids();
                                  });
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirm Deletion'),
                                      content: Text(
                                          'Are you sure you want to delete this bid?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _deleteBid(context, bid.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text('No bids available'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Status Information:\n- Open: Initial status.\n- Next Bid: Waiting for next bid.\n- Buy It Now: Direct purchase available.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// CreateBidScreen allows the user to create a new bid
class CreateBidScreen extends StatefulWidget {
  @override
  _CreateBidScreenState createState() => _CreateBidScreenState();
}

class _CreateBidScreenState extends State<CreateBidScreen> {
  final _formKey = GlobalKey<FormState>();
  final BidService _bidService = BidService();
  String _cardName = '';
  double _bidPrice = 0.0;
  String _status = 'open';

  Future<void> _createBid() async {
    if (_formKey.currentState!.validate()) {
      try {
        final bidData = {
          'card_name': _cardName,
          'bid_price': _bidPrice,
          'status': _status,
        };
        await _bidService.createBid(bidData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bid created successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create bid: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      selectedIndex: 1,
      bodyContent: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Card Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _cardName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bid Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bid price';
                  }
                  return null;
                },
                onChanged: (value) {
                  _bidPrice = double.tryParse(value) ?? 0.0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status'),
                initialValue: 'open',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
                onChanged: (value) {
                  _status = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createBid,
                child: Text('Create Bid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// UpdateBidScreen allows the user to edit a bid
class UpdateBidScreen extends StatefulWidget {
  final BidModel bid;

  UpdateBidScreen({required this.bid});

  @override
  _UpdateBidScreenState createState() => _UpdateBidScreenState();
}

class _UpdateBidScreenState extends State<UpdateBidScreen> {
  final _formKey = GlobalKey<FormState>();
  final BidService _bidService = BidService();
  late double _updatedBidPrice;
  late String _updatedStatus;

  @override
  void initState() {
    super.initState();
    _updatedBidPrice = widget.bid.bidPrice;
    _updatedStatus = widget.bid.status;
  }

  Future<void> _updateBid() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedBidData = {
          'bid_price': _updatedBidPrice,
          'status': _updatedStatus,
        };
        await _bidService.updateBid(widget.bid.id, updatedBidData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bid updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update bid: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      selectedIndex: 1,
      bodyContent: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: widget.bid.bidPrice.toString(),
                decoration: InputDecoration(labelText: 'Bid Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bid price';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedBidPrice = double.tryParse(value) ?? 0.0;
                },
              ),
              TextFormField(
                initialValue: widget.bid.status,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedStatus = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateBid,
                child: Text('Update Bid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
