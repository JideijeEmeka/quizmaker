import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile({@required this.option, @required this.description, @required this.correctAnswer, @required this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5,),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: widget.description == widget.optionSelected ?
              widget.optionSelected == widget.correctAnswer
                  ? Colors.blue.withOpacity(0.7)
                  : Colors.blue.withOpacity(0.7) : Colors.grey, width: 1.4,),
                  borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text("${widget.option}", style: TextStyle(
                color: widget.optionSelected == widget.description ?
            widget.correctAnswer == widget.optionSelected
                ? Colors.blue.withOpacity(0.7)
                : Colors.blue : Colors.grey),),
          ),
          SizedBox(width: 8,),
          Text(widget.description, style: TextStyle(fontSize: 16, color: Colors.black54),),
        ],
      ),
    );
  }
}
