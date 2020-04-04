import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FAQ'),
      leading: MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
            
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) => EntryItem(
              data[index],
            ),
      ),
    );
  }
}
 

class Entry {
  final String title;
  final List<Entry>
      children; 
  Entry(this.title, [this.children = const <Entry>[]]);
}
 

final List<Entry> data = <Entry>[
  Entry(
    'How do I change my profile information? ',
    <Entry>[
      Entry(
        '   After logging in or signing up, you will see three bars indicating the menu on the upper left corner on the screen, once that is clicked tap on profile then on the pencil icon to change your information or the camera icon to change your photo. ',
        // <Entry>[
        //   Entry('Item A0.1'),
        //   Entry('Item A0.2'),
        //   Entry('Item A0.3'),
        // ],
      ),
      //Entry('Section A1'),
      //Entry('Section A2'),
    ],
  ),
  // Second Row
  Entry(
    'How do I add food items to donate',
    <Entry>[
      Entry(
        '   After logging in or signing up the option to add items will be displayed on the upper half of the screen once that is tapped use the “select a picture button” to add a photo, then on the text field below it add the name of the food you are donating under that choose the date and time using the clock and calendar and clicking “ok” then click on post new food.',
         ),
    ],
  ),
  Entry(
    'How do I see food I want to potentially pick up?',
    <Entry>[
      Entry(
        'After logging in or signing up the option to add items will be displayed on the lower half of the screen once that is clicked you will see images of food that are available for pick up in your area. Swipe right to show interest or swipe left when you don’t want it. ',
      ),
    ],
  ),
 Entry(
    'How do I confirm reservation?',
    <Entry>[
      Entry(
        '   Open a chat with the person who is donating it. Both parties will get an accept button to accept the reservation and open the maps that will take you there.',
         ),
    ],
  ),
  Entry(
    'How do I access previous conversations with other people?',
    <Entry>[
      Entry(
        'After login in or signing up, you will see three bars indicating the menu on the upper left corner on the screen, once that is clicked tap on chat.',
      ),
    ],
  ),
];
 
// Create the Widget for the row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;
 
  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}