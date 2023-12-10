import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Add_Person extends StatefulWidget {
  const Add_Person({super.key});

  @override
  State<Add_Person> createState() => _Add_PersonState();
}

class _Add_PersonState extends State<Add_Person> {

  TextEditingController controller=TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isbool=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 246, 246, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset("asset/search.svg"),
                    SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "enter",
                          border: InputBorder.none,
                        ),
                        onSubmitted: (string){
                          setState(() {
                            isbool=true;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset("asset/cross.svg"),
                    )
                  ],
                ),
              ),

              search_result()
            ],
          ),
        ),
      ),
    );
  }

  search_result()
  {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: isbool ? FutureBuilder(
            future: FirebaseFirestore.instance.collection("user").where('username',isEqualTo: controller.text).get(),
            builder: (context,snap)
            {
              if(snap.connectionState==ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator());
                }
              else
                {
                  return ListView.builder(
                    itemCount: (snap.data! as dynamic).docs.length,
                    itemBuilder: (context,index)
                    {
                      var snaps=(snap.data! as dynamic).docs[index];
                      return Text(snaps["email"]);
                    },
                  );
                }
            }
        ) : SizedBox(),
      ),
    );
  }

}
