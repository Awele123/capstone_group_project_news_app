import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
           decoration: 
            BoxDecoration(
              image:
               DecorationImage(image: AssetImage(HomeImages.background),
              fit:BoxFit.cover,
               )
            ),
          ),
          Column(
            children: [
              SizedBox(height: 160,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(HomeImages.bolaAhmed),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: 'Chidimma Awele',
                          textSize: 22,
                          fontWeight: FontWeight.bold,
                          ),
                         
                          SizedBox(width: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Edit', style: TextStyle(color: Colors.blue),),
                               IconButton(icon:Icon(Icons.edit, color: Colors.blue,), onPressed: () {},)
                            ],
                          
                          ),
                         
                      ],
                    ),
                    SizedBox(height: 10.0,),
                     AppText(
                    text: 'Female',
                     textSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                  ],
                ),
              ),
               
              SizedBox(height: 20,),
              Container(
                
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
                ),
                child:
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    IconButton(icon:Icon(Icons.favorite), onPressed: () {},),
                     AppText(
                      text:'Favourite',
                       textSize: 20,
                      fontWeight: FontWeight.bold,
                                     ),
                                     //GestureDetector()
                   ],
                   
                 ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.lock), onPressed: () {},),
                    AppText(
                      text:'Change Password',
                       textSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration:BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
                ),
                 child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.logout_outlined), onPressed: () {},),
                    AppText(
                      text:'Log Out',
                   textSize: 20,
                  fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      //profile information
      //favorite 
      //log out 
      //change password

    );
  }
}