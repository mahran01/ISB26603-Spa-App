import 'package:flutter/material.dart';
import 'package:spa_app/components/facial_decoration.dart';
import 'package:spa_app/data_repository/assigned_value.dart';
import 'package:spa_app/models/treatment.dart';
import 'package:spa_app/components/anonymous/al_to_login.dart';
import 'package:spa_app/components/user/mbs_treatment_detail.dart';

class DefaultHomePage extends StatelessWidget {
  const DefaultHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Treatment> treat = AssignedValue.treatment;

    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Facial Treatment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  facial_Decoration(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ToLoginDialog();
                        },
                      );
                    },
                    text1: "Facial Treatment",
                    text2: "Book an appointment",
                    icon: Icons.add,
                    color_shceme: Theme.of(context).primaryColor,
                    color_icon: Colors.white,
                    color_text: Colors.white,
                    color_text1: Colors.white54,
                    width: maxWidth / 2 - 15,
                  ),
                  SizedBox(
                    width: maxWidth / 2 - 15,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "What are your preferred treatment?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: AssignedValue.treatment.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      spaceModalBottomSheet(context, treat[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                            image: AssetImage(treat[index].imageUrl),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Text(
                              treat[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
