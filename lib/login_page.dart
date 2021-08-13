
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'main.dart';
import "api/auths.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ui.Image assetImage;
  @override
  void initState() {
    // imageHandler.load('images/d.jpg').then((i){
    //   setState(() {
    //     assetImage = i;
    //   });
    // });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: ()async{
          var exit = await showDialog(
              context: context,
              builder: (context)=>SimpleDialog(
                children: [
                  Icon(Icons.meeting_room,size: 85,),
                  Center(child: Text("Sudah ingin keluar ?",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,fontWeight: FontWeight.w300),)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          minWidth: 120,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color.fromRGBO(64, 64, 222, 1))
                          ),
                          padding: EdgeInsets.all(10),
                          onPressed: (){
                            Navigator.pop(context,false);
                          },
                          child: Text("Tutup",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
                      ),
                      SizedBox(width: 15),
                      FlatButton(
                          minWidth: 120,
                          color: Color.fromRGBO(254, 83, 83, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          padding: EdgeInsets.all(10),
                          onPressed: ()async {
                            try{
                              await utils.backupGlobVar();
                            }
                            catch(e){
                              utils.toast(e);
                            }
                            Navigator.pop(context,true);
                          },
                          child: Text("Keluar",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
                      ),
                    ],
                  ),
                ],
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.transparent)
                ),
                contentPadding: EdgeInsets.all(20),
              )
          );
          if(exit??false){
              SystemNavigator.pop();
          }
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image:DecorationImage(
                        image: AssetImage("images/splash.jpg"),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*0.44,
                  ),
                  Expanded(
                   child: Padding(
                     padding: EdgeInsets.only(bottom: 115),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Container(
                           width: 286,
                           child:Container(
                             height: 80,
                           ),
                         ),
                         Container(
                           padding: const EdgeInsets.only(top: 15),
                           width: 286,
                           child:
                           TextButton(
                             onPressed: (){
                               final _formKey = GlobalKey<FormBuilderState>();
                               bool obscure = true;
                               bool checked = prefs.getBool("saveUsername")??false;
                               final userText = TextEditingController();
                               userText.text = prefs.getString("username")??"";
                               showModalBottomSheet(
                                   isScrollControlled: true,
                                   context: context,
                                   builder: (context) => StatefulBuilder(
                                     builder: (context,setState)
                                     {
                                       return Container(
                                         // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                         height: MediaQuery.of(context).size.height*0.6+MediaQuery.of(context).viewInsets.bottom,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                                         ),
                                         child: SingleChildScrollView(
                                           scrollDirection: Axis.vertical,
                                           child: FormBuilder(
                                             key: _formKey,
                                             autovalidateMode: AutovalidateMode.disabled,
                                             child: Column(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:53,right: 53),
                                                   child: Column(
                                                     children: [
                                                       Padding(
                                                           padding: const EdgeInsets.only(top: 30,),
                                                           child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top: 30),
                                                         child: FormBuilderTextField(
                                                           validator: (value) =>
                                                           value == null || value.isEmpty ? 'Data tidak boleh kosong' : null,
                                                           name: "user",
                                                           controller: userText,
                                                           onChanged: (value){
                                                             if(checked)prefs.setString("username",value);
                                                             else prefs.remove("username");
                                                           },
                                                           decoration: InputDecoration(
                                                               focusedBorder: new OutlineInputBorder(
                                                                 borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                 borderRadius: const BorderRadius.all(
                                                                   const Radius.circular(15.0),
                                                                 ),
                                                               ),
                                                               border: new OutlineInputBorder(
                                                                 borderRadius: const BorderRadius.all(
                                                                   const Radius.circular(15.0),
                                                                 ),
                                                               ),
                                                               contentPadding: EdgeInsets.all(23),
                                                               hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,fontStyle: FontStyle.normal),
                                                               hintText: "Email atau Handphone"
                                                           ),
                                                         ),
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top: 20,),
                                                         child: FormBuilderTextField(
                                                           validator: (value) =>
                                                           value == null || value.isEmpty ? 'Password tidak boleh kosong' : null,
                                                           name: "password",
                                                           obscureText: obscure,
                                                           decoration: InputDecoration(
                                                               suffixIcon: InkWell(
                                                                   onTap: (){
                                                                     setState(() {
                                                                       obscure = !obscure;
                                                                     });
                                                                   },
                                                                   child: Icon((obscure)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye)),
                                                               focusedBorder: new OutlineInputBorder(
                                                                 borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                 borderRadius: const BorderRadius.all(
                                                                   const Radius.circular(15.0),
                                                                 ),
                                                               ),
                                                               border: new OutlineInputBorder(
                                                                 borderRadius: const BorderRadius.all(
                                                                   const Radius.circular(15.0),
                                                                 ),
                                                               ),
                                                               contentPadding: EdgeInsets.all(23),
                                                               hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,fontStyle: FontStyle.normal),
                                                               hintText: "Password"
                                                           ),
                                                         ),
                                                       ),
                                                       Container(
                                                         alignment: Alignment.centerLeft,
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.start,
                                                           mainAxisSize: MainAxisSize.min,
                                                           children: [
                                                             Checkbox(
                                                               value: checked,
                                                               onChanged: (value){
                                                                 setState((){
                                                                   checked = value;
                                                                 });
                                                                 prefs.setBool("saveUsername", value);
                                                                 _formKey.currentState.save();
                                                                 if(value)prefs.setString("username",_formKey.currentState.value['user']);
                                                                 else prefs.remove("username");
                                                               },
                                                             ),
                                                             Text("Save Username",style: TextStyle(fontSize: 16,color: Colors.black54),),
                                                           ],
                                                         ),
                                                       ),
                                                       Container(
                                                           alignment: Alignment.centerRight,
                                                           child:TextButton(
                                                             onPressed: ()async{
                                                               final emailText  = TextEditingController();
                                                               var user_id;
                                                               var token = await showModalBottomSheet(
                                                                   isScrollControlled: true,
                                                                   context: context,
                                                                   builder: (context) => StatefulBuilder(
                                                                     builder: (context,setState) =>Container(
                                                                       height: MediaQuery.of(context).size.height*0.50,
                                                                       decoration: BoxDecoration(
                                                                         color: Colors.white,
                                                                         borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                                                       ),
                                                                       child: SingleChildScrollView(
                                                                         scrollDirection: Axis.vertical,
                                                                         child: Column(
                                                                           mainAxisSize: MainAxisSize.min,
                                                                           children: [
                                                                             Padding(
                                                                               padding: const EdgeInsets.only(left:53,right: 53),
                                                                               child: Column(
                                                                                 children: [
                                                                                   Padding(
                                                                                     padding: const EdgeInsets.only(top:25.0),
                                                                                     child: Column(
                                                                                       children: [
                                                                                         Padding(
                                                                                             padding: const EdgeInsets.only(top: 10,),
                                                                                             child: Text("Lupa Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                                                                                         ),
                                                                                         Padding(
                                                                                             padding: const EdgeInsets.only(top: 30,),
                                                                                             child: Text("Masukan Email Anda Agar Mendapat Kode Untuk me-Reset Password", textAlign: TextAlign.center, style: TextStyle( fontSize: 15),)
                                                                                         ),
                                                                                         Padding(
                                                                                           padding: const EdgeInsets.only(top: 15,),
                                                                                           child: FormBuilderTextField(
                                                                                             controller: emailText,
                                                                                             validator: (value) =>
                                                                                             value == null || value.isEmpty ? 'Email tidak boleh kosong' : null,
                                                                                             name: "email",
                                                                                             decoration: InputDecoration(
                                                                                                 focusedBorder: new OutlineInputBorder(
                                                                                                   borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                                                   borderRadius: const BorderRadius.all(
                                                                                                     const Radius.circular(15.0),
                                                                                                   ),
                                                                                                 ),
                                                                                                 border: new OutlineInputBorder(
                                                                                                   borderRadius: const BorderRadius.all(
                                                                                                     const Radius.circular(15.0),
                                                                                                   ),
                                                                                                 ),
                                                                                                 contentPadding: EdgeInsets.all(23),
                                                                                                 hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                                                 hintText: "Email"
                                                                                             ),
                                                                                           ),
                                                                                         ),
                                                                                       ],
                                                                                     ),
                                                                                   ),
                                                                                   Container(
                                                                                     padding: EdgeInsets.only(top: 25),
                                                                                     width: 286,
                                                                                     child: FlatButton(
                                                                                         color: Color.fromRGBO(	0, 0, 52, 1),
                                                                                         shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                                                         padding: EdgeInsets.all(12),
                                                                                         onPressed: ()async {
                                                                                           Future future = Auths().getResetToken({"email":emailText.text});
                                                                                           var res = await utils.showLoadingFuture(context,future);
                                                                                           if(res["STATUS"]){
                                                                                             user_id = res["DATA"][0]["user_id"];
                                                                                            Navigator.pop(context,res["DATA"][0]["token"]);
                                                                                           }
                                                                                           else{
                                                                                             utils.toast(res["DATA"],type: "ERROR");
                                                                                           }
                                                                                         },
                                                                                         child: Text("Submit",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),)),
                                                                                   ),
                                                                                   InkWell(
                                                                                     onTap: (){
                                                                                       Navigator.pop(context);
                                                                                     },
                                                                                     child: Padding(
                                                                                         padding: const EdgeInsets.only(top: 30,),
                                                                                         child: Text("Kembali ke Halaman Login", textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline,fontSize: 15),)
                                                                                     ),
                                                                                   ),
                                                                                 ],
                                                                               ),
                                                                             ),

                                                                           ],
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   )
                                                               );
                                                               if(token!=null){
                                                                 final codeText  = TextEditingController();
                                                                 var isValid = await showModalBottomSheet(
                                                                     isScrollControlled: true,
                                                                     context: context,
                                                                     builder: (context) => StatefulBuilder(
                                                                       builder: (context,setState) =>Container(
                                                                         height: MediaQuery.of(context).size.height*0.50,
                                                                         decoration: BoxDecoration(
                                                                           color: Colors.white,
                                                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                                                         ),
                                                                         child: SingleChildScrollView(
                                                                           scrollDirection: Axis.vertical,
                                                                           child: Column(
                                                                             mainAxisSize: MainAxisSize.min,
                                                                             children: [
                                                                               Padding(
                                                                                 padding: const EdgeInsets.only(left:53,right: 53),
                                                                                 child: Column(
                                                                                   children: [
                                                                                     Padding(
                                                                                       padding: const EdgeInsets.only(top:25.0),
                                                                                       child: Column(
                                                                                         children: [
                                                                                           Padding(
                                                                                               padding: const EdgeInsets.only(top: 10,),
                                                                                               child: Text("Lupa Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                                                                                           ),
                                                                                           Padding(
                                                                                               padding: const EdgeInsets.only(top: 30,),
                                                                                               child: Text("Masukan Kode yang Telah Dikirim ke Email Untuk me-Reset Password", textAlign: TextAlign.center, style: TextStyle( fontSize: 15),)
                                                                                           ),
                                                                                           Padding(
                                                                                             padding: const EdgeInsets.only(top: 15,),
                                                                                             child: FormBuilderTextField(
                                                                                               controller: codeText,
                                                                                               validator: (value) =>
                                                                                               value == null || value.isEmpty ? 'Kode tidak boleh kosong' : null,
                                                                                               name: "Kode Validasi",
                                                                                               decoration: InputDecoration(
                                                                                                   focusedBorder: new OutlineInputBorder(
                                                                                                     borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                                                     borderRadius: const BorderRadius.all(
                                                                                                       const Radius.circular(15.0),
                                                                                                     ),
                                                                                                   ),
                                                                                                   border: new OutlineInputBorder(
                                                                                                     borderRadius: const BorderRadius.all(
                                                                                                       const Radius.circular(15.0),
                                                                                                     ),
                                                                                                   ),
                                                                                                   contentPadding: EdgeInsets.all(23),
                                                                                                   hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                                                   hintText: "Kode Validasi"
                                                                                               ),
                                                                                             ),
                                                                                           ),
                                                                                         ],
                                                                                       ),
                                                                                     ),
                                                                                     Container(
                                                                                       padding: EdgeInsets.only(top: 25),
                                                                                       width: 286,
                                                                                       child: FlatButton(
                                                                                           color: Color.fromRGBO(	0, 0, 52, 1),
                                                                                           shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                                                           padding: EdgeInsets.all(12),
                                                                                           onPressed: ()async {
                                                                                             Future future = Auths().validateToken({"token":token,"code":codeText.text});
                                                                                             var res = await utils.showLoadingFuture(context,future);
                                                                                             if(res["STATUS"]){
                                                                                               Navigator.pop(context,true);
                                                                                             }
                                                                                             else{
                                                                                               utils.toast(res["DATA"],type: "ERROR");
                                                                                             }
                                                                                           },
                                                                                           child: Text("Submit",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),)),
                                                                                     ),
                                                                                     InkWell(
                                                                                       onTap: (){
                                                                                         Navigator.pop(context);
                                                                                       },
                                                                                       child: Padding(
                                                                                           padding: const EdgeInsets.only(top: 30,),
                                                                                           child: Text("Kembali ke Halaman Login", textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline,fontSize: 15),)
                                                                                       ),
                                                                                     ),
                                                                                   ],
                                                                                 ),
                                                                               ),

                                                                             ],
                                                                           ),
                                                                         ),
                                                                       ),
                                                                     )
                                                                 );
                                                                 if(isValid??false){
                                                                   final passwordText  = TextEditingController();
                                                                   bool obscure = true;
                                                                   await showModalBottomSheet(
                                                                       isScrollControlled: true,
                                                                       context: context,
                                                                       builder: (context) => StatefulBuilder(
                                                                         builder: (context,setState) =>Container(
                                                                           height: MediaQuery.of(context).size.height*0.50,
                                                                           decoration: BoxDecoration(
                                                                             color: Colors.white,
                                                                             borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                                                           ),
                                                                           child: SingleChildScrollView(
                                                                             scrollDirection: Axis.vertical,
                                                                             child: Column(
                                                                               mainAxisSize: MainAxisSize.min,
                                                                               children: [
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.only(left:53,right: 53),
                                                                                   child: Column(
                                                                                     children: [
                                                                                       Padding(
                                                                                         padding: const EdgeInsets.only(top:25.0),
                                                                                         child: Column(
                                                                                           children: [
                                                                                             Padding(
                                                                                                 padding: const EdgeInsets.only(top: 10,),
                                                                                                 child: Text("Lupa Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                                                                                             ),
                                                                                             Padding(
                                                                                                 padding: const EdgeInsets.only(top: 30,),
                                                                                                 child: Text("Masukan Kode yang Telah Dikirim ke Email Untuk me-Reset Password", textAlign: TextAlign.center, style: TextStyle( fontSize: 15),)
                                                                                             ),
                                                                                             Padding(
                                                                                               padding: const EdgeInsets.only(top: 15,),
                                                                                               child: FormBuilderTextField(
                                                                                                 obscureText: obscure,
                                                                                                 controller: passwordText,
                                                                                                 validator: (value) =>
                                                                                                 value == null || value.isEmpty ? 'Password baru tidak boleh kosong' : null,
                                                                                                 name: "Password",
                                                                                                 decoration: InputDecoration(
                                                                                                     suffixIcon: InkWell(
                                                                                                         onTap: (){
                                                                                                           setState(() {
                                                                                                             obscure = !obscure;
                                                                                                           });
                                                                                                         },
                                                                                                         child: Icon((obscure)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye)),
                                                                                                     focusedBorder: new OutlineInputBorder(
                                                                                                       borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                                                       borderRadius: const BorderRadius.all(
                                                                                                         const Radius.circular(15.0),
                                                                                                       ),
                                                                                                     ),
                                                                                                     border: new OutlineInputBorder(
                                                                                                       borderRadius: const BorderRadius.all(
                                                                                                         const Radius.circular(15.0),
                                                                                                       ),
                                                                                                     ),
                                                                                                     contentPadding: EdgeInsets.all(23),
                                                                                                     hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                                                     hintText: "Password baru"
                                                                                                 ),
                                                                                               ),
                                                                                             ),
                                                                                           ],
                                                                                         ),
                                                                                       ),
                                                                                       Container(
                                                                                         padding: EdgeInsets.only(top: 25),
                                                                                         width: 286,
                                                                                         child: FlatButton(
                                                                                             color: Color.fromRGBO(	0, 0, 52, 1),
                                                                                             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                                                             padding: EdgeInsets.all(12),
                                                                                             onPressed: ()async {
                                                                                               Future future = Auths().changePass({"login_id":user_id,"pass":passwordText.text,"check_old":"FALSE"});
                                                                                               var res = await utils.showLoadingFuture(context,future);
                                                                                               utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                                                                                               if(res["STATUS"]) {
                                                                                                 Navigator.pop(context);
                                                                                               }
                                                                                             },
                                                                                             child: Text("Submit",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),)),
                                                                                       ),
                                                                                       InkWell(
                                                                                         onTap: (){
                                                                                           Navigator.pop(context);
                                                                                         },
                                                                                         child: Padding(
                                                                                             padding: const EdgeInsets.only(top: 30,),
                                                                                             child: Text("Kembali ke Halaman Login", textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline,fontSize: 15),)
                                                                                         ),
                                                                                       ),
                                                                                     ],
                                                                                   ),
                                                                                 ),

                                                                               ],
                                                                             ),
                                                                           ),
                                                                         ),
                                                                       )
                                                                   );
                                                                 }
                                                               }
                                                             },
                                                             child: Text("Lupa Password",style: TextStyle(fontWeight: FontWeight.w200,decoration: TextDecoration.underline,color: Color.fromRGBO(5,0,255,1),fontSize: 16,fontStyle: FontStyle.normal,),),
                                                           )
                                                       ),
                                                       Container(
                                                         padding: EdgeInsets.only(top: 25,bottom: 15),
                                                         width: 286,
                                                         child: FlatButton(
                                                             color: Color.fromRGBO(	0, 0, 52, 1),
                                                             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                             padding: EdgeInsets.all(12),
                                                             onPressed: ()async {
                                                               _formKey.currentState.save();
                                                               if (_formKey.currentState.validate()) {
                                                                 Future future = Auths().login(_formKey.currentState.value['user'].trim(), _formKey.currentState.value['password'].trim());
                                                                 var res = await utils.showLoadingFuture(context,future);
                                                                 if(res["STATUS"]){
                                                                   Navigator.pushReplacementNamed(context, "/home");
                                                                 }
                                                                 else{
                                                                   utils.toast(res["DATA"],type: "ERROR");
                                                                 }
                                                               }
                                                               else {
                                                                 utils.toast("Data belum lengkap. Silakan cek kembali",type:"ERROR");
                                                               }
                                                             },
                                                             child: Text("Login",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),)),
                                                       ),
                                                     ],
                                                   ),
                                                 ),

                                               ],
                                             ),
                                           ),
                                         ),
                                       );
                                     },
                                   )
                               );
                             },
                             child: Text("Login",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),),
                           ),
                         ),
                         Container(
                            padding: const EdgeInsets.only(top: 15),
                            width: 286,
                            child:TextButton(
                              onPressed: (){
                                final _formKey = GlobalKey<FormBuilderState>();
                                var gender;
                                final passText  = TextEditingController();
                                final confirmPassText  = TextEditingController();
                                bool obscurePass = true;
                                bool obscureConfirm = true;

                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context,setState) =>Container(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        height: MediaQuery.of(context).size.height*0.85,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:53,right: 53),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:25.0),
                                                      child: FormBuilder(
                                                        key: _formKey,
                                                        autovalidateMode: AutovalidateMode.disabled,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderTextField(
                                                                validator: (value) =>
                                                                value == null || value.isEmpty ? 'Name tidak boleh kosong' : null,
                                                                name: "nama",
                                                                decoration: InputDecoration(
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "Nama"
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderDateTimePicker(
                                                                inputType: InputType.date,
                                                                name: "tgl_lahir",
                                                                validator: (value) =>
                                                                value == null ? 'Tanggal lahir tidak boleh kosong' : null,
                                                                format: DateFormat("dd    /    MMM   /    yyyy"),
                                                                decoration: InputDecoration(
                                                                    suffixIcon: Icon(FontAwesomeIcons.solidCalendarAlt,color: Color.fromRGBO(35, 35, 222, 1),),
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "Tgl    /    Bln   /    Tahun"
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderChoiceChip(
                                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                                alignment: WrapAlignment.spaceEvenly,
                                                                name: "gender",
                                                                validator : (value) =>
                                                                value == null ? 'Gender tidak boleh kosong' : null,
                                                                selectedColor: Color.fromRGBO(35, 35, 222, 1),
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                ),
                                                                onChanged: (value){
                                                                  setState(() {
                                                                    gender = value;
                                                                  });
                                                                },
                                                                options: [
                                                                  FormBuilderFieldOption(
                                                                      value: 'Male', child: Container(padding: EdgeInsets.all((gender == "Male")?15.0:8.0),width: (MediaQuery.of(context).size.width-180)/2,child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Icon(FontAwesomeIcons.male,color: (gender=="Male")?Colors.white:Colors.black,),
                                                                      Text('Pria',style: (gender == "Male")?TextStyle(color: Colors.white):TextStyle(),),
                                                                    ],
                                                                  ))),
                                                                  FormBuilderFieldOption(
                                                                      value: 'Female', child: Container(padding:EdgeInsets.all((gender == "Female")?15.0:8.0),width: (MediaQuery.of(context).size.width-180)/2,child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Icon(FontAwesomeIcons.female,color: (gender=="Female")?Colors.white:Colors.black,),
                                                                      Text('Wanita',style: (gender == "Female")?TextStyle(color: Colors.white):TextStyle(),),
                                                                    ],
                                                                  ))),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderTextField(
                                                                name: "phone",
                                                                validator : (value) =>
                                                                value == null || value.isEmpty ? 'No Handphone tidak boleh kosong' : null,
                                                                decoration: InputDecoration(
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "No Handphone"
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderTextField(
                                                                name:"email",
                                                                validator : (value) =>
                                                                value == null || value.isEmpty ? 'Email tidak boleh kosong' : null,
                                                                decoration: InputDecoration(
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "Alamat Email"
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: FormBuilderTextField(
                                                                controller: passText,
                                                                obscureText: obscurePass,
                                                                name: "pass",
                                                                validator : (value) =>
                                                                value == null || value.isEmpty ? 'Password tidak boleh kosong' : null,
                                                                decoration: InputDecoration(
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    suffixIcon: InkWell(
                                                                      onTap: (){
                                                                        setState((){
                                                                          obscurePass = !obscurePass;
                                                                        });
                                                                      },
                                                                      child: Icon((obscurePass)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "Password"
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 15,),
                                                              child: TextFormField(
                                                                obscureText: obscureConfirm,
                                                                controller: confirmPassText,
                                                                validator : (value) =>
                                                                value == null || value.isEmpty ? 'Password tidak boleh kosong' : null,
                                                                decoration: InputDecoration(
                                                                    focusedBorder: new OutlineInputBorder(
                                                                      borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    suffixIcon: InkWell(
                                                                      onTap: (){
                                                                        setState((){
                                                                          obscureConfirm = !obscureConfirm;
                                                                        });
                                                                      },
                                                                      child: Icon((obscurePass)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye),
                                                                    ),
                                                                    border: new OutlineInputBorder(
                                                                      borderRadius: const BorderRadius.all(
                                                                        const Radius.circular(15.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(23),
                                                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.normal),
                                                                    hintText: "Ulangi Password"
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(top: 25),
                                                      width: 286,
                                                      child: FlatButton(
                                                          color: Color.fromRGBO(64, 64, 222, 1),
                                                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                          padding: EdgeInsets.all(12),
                                                          onPressed: ()async {
                                                            if(passText.text.trim()==confirmPassText.text.trim()){
                                                              _formKey.currentState.save();
                                                              if (_formKey.currentState.validate()) {
                                                                // print(_formKey.currentState.value);
                                                                final Map<String, dynamic> mapUser = new Map<String, dynamic>.from(_formKey.currentState.value);
                                                                for(var i=0;i<mapUser.keys.length;i++){
                                                                  mapUser.update(mapUser.keys.toList()[i], (value) => (value is String)?value.trim():value);
                                                                }
                                                                mapUser.update("tgl_lahir", (value) => DateFormat("dd-MMM-yyyy").format(value));
                                                                mapUser["corp"] = "TBG";
                                                                Future future = Auths().register(mapUser);
                                                                var res = await utils.showLoadingFuture(context,future);
                                                                utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                                                                if(res["STATUS"]) {
                                                                  // print([mapUser["email"], mapUser["pass"]]);
                                                                  Future future = Auths().login(mapUser["email"], mapUser["pass"]);
                                                                  var res = await utils.showLoadingFuture(context,future);
                                                                  Navigator.pop(context);
                                                                  if(res["STATUS"]){
                                                                    Navigator.pushReplacementNamed(context, "/home");
                                                                  }
                                                                }
                                                              } else {
                                                                utils.toast("Data belum lengkap. Silakan cek kembali",type:"ERROR");
                                                              }
                                                            }
                                                            else{
                                                              utils.toast("Password tidak sama. Silakan cek kembali",type:"ERROR");
                                                            }
                                                          },
                                                          child: Text("Daftar",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,fontSize: 24,color: Colors.white),)),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                );
                              },
                              child: Text("Register",style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 16,color: Colors.white),),
                            )
                         ),
                       ],
                     ),
                   ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}