import 'dart:io';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'CustomShape/wave_shaper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'api/users.dart';
import 'api/auths.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool toggleEdit = false;
  bool changed = false;
  Map<String,dynamic> userData;
  final _formKey = GlobalKey<FormBuilderState>();
  var gender;
  Image profileImage;

  reloadUser(){
    imageCache.clear();
    userData = new Map<String,dynamic>.from(globVar.user.toJsonDisplay());
    userData.update("Tanggal_Lahir", (value) => DateFormat("dd-MMM-yyyy").parse(value));
    gender = userData["Gender"];
    if(globVar.user.CUST_PROFILE_IMAGE!=null)profileImage = Image.memory(globVar.user.CUST_PROFILE_IMAGE);
    // profileImage = Image.network(globVar.hostRest+"/binary/${globVar.user.CUST_DISPLAY_PICTURE}",headers: {"Authorization":"bearer ${globVar.tokenRest.token}"});
  }

  @override
  void initState() {
    reloadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: WavePainter(),
              ),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 1,child: SizedBox()),
                      Expanded(
                        flex: 7,
                        child:
                        InkWell(
                          onTap: ()async{
                            // ImagePicker.platform.pickImage(source: ImageSource.gallery,maxWidth: 700, imageQuality: 50);
                            File image;
                            await showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height*0.5,
                                  minWidth: MediaQuery.of(context).size.width,
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap:()async{
                                          PickedFile temp = await ImagePicker().getImage(source: ImageSource.gallery);
                                          if(temp != null){
                                            image = new File(temp.path);
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(FontAwesomeIcons.images),
                                              SizedBox(width: 25,),
                                              Text("Ubah foto dari gallery"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      InkWell(
                                        onTap: ()async{
                                          PickedFile temp = await ImagePicker().getImage(source: ImageSource.camera);
                                          if(temp != null){
                                            image = new File(temp.path);
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top:10,right: 10,left: 10,bottom: 20),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(FontAwesomeIcons.camera),
                                              SizedBox(width: 25,),
                                              Text("Tangkap foto profile baru"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Divider(),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top:10,right: 10,left: 10,bottom: 20),
                                      //   child: Row(
                                      //     crossAxisAlignment: CrossAxisAlignment.center,
                                      //     children: [
                                      //       Icon(FontAwesomeIcons.solidWindowRestore),
                                      //       SizedBox(width: 25,),
                                      //       Text("Lihat foto profile layar penuh"),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            }).whenComplete(()async{
                              if(image!=null){
                                image = await ImageCropper.cropImage(cropStyle: CropStyle.circle,sourcePath: image.path,maxWidth: 700,compressQuality: 70);
                                Future future = Users().updateDP(image);
                                var res = await utils.showLoadingFuture(context,future);
                                if(res["STATUS"]){
                                  Navigator.pushReplacementNamed(context, "/profile");
                                }
                                utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 93,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 90,
                              backgroundImage: (globVar.user!=null &&globVar.user.CUST_PROFILE_IMAGE==null)?null:profileImage.image,
                              child: (globVar.user!=null &&globVar.user.CUST_PROFILE_IMAGE==null)?Icon(Icons.person,color: Colors.white,size: 150,):null,
                            ),
                          ),
                        ),
                        // Stack(
                        //   children: [
                        //     Container(
                        //       height: 180,
                        //       width: 180,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color: Colors.grey,
                        //       ),
                        //       child: Image(
                        //         fit: BoxFit.fill,
                        //         height: 180,
                        //         width: 180,
                        //         errorBuilder: (context,err,stackTrace)=>Icon(Icons.person,color: Colors.white,size: 160,),
                        //         image: NetworkImage(globVar.hostRest+"/binary/${globVar.user.CUST_DISPLAY_PICTURE}",headers: {"Authorization":"bearer ${globVar.tokenRest.token}"}),
                        //       )
                        //     ),
                        //     Container(
                        //       width: 180,
                        //       height: 180,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         border: Border.all(color: Colors.white,width: 3)
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(globVar.user!=null?globVar.user.NAME:"#NAME#",style: TextStyle(color: Colors.white,fontSize: 16,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700),),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              onPressed: ()async{
                                if(changed){
                                  if(toggleEdit){
                                    _formKey.currentState.save();
                                    if (_formKey.currentState.validate()) {
                                      // print(_formKey.currentState.value);
                                      final Map<String, dynamic> mapUser = new Map<String, dynamic>.from(_formKey.currentState.value);
                                      for(var i=0;i<mapUser.keys.length;i++){
                                        mapUser.update(mapUser.keys.toList()[i], (value) => (value is String)?value.trim():value);
                                      }
                                      mapUser["cust_id"] = globVar.user.CUST_ID;
                                      mapUser["corp"] = globVar.auth.corp;
                                      mapUser.update("Tanggal_Lahir", (value) => DateFormat("dd-MMM-yyyy").format(value));
                                      Future future = Users().update(mapUser);
                                      var res = await utils.showLoadingFuture(context,future);
                                      utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                                      if(res["STATUS"]) {
                                        changed = false;
                                        reloadUser();
                                        setState(() {
                                          toggleEdit = !toggleEdit;
                                        });
                                      }
                                    }
                                    else {
                                      utils.toast("Data belum lengkap. Silakan cek kembali",type:"ERROR");
                                    }
                                  }
                                }
                                else{
                                  setState(() {
                                    toggleEdit = !toggleEdit;
                                  });
                                }

                              },
                              minWidth: 180,
                              padding: EdgeInsets.all(12),
                              color: toggleEdit?Colors.green:Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: toggleEdit
                                  ?Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.check,color: Colors.white,size: 18,),
                                      Text(" Save Profil",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w700),),
                                    ],
                                  )
                                  :Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.pencilAlt,color: Colors.white,size: 18,),
                                        Text(" Edit Profil",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w700),),
                                      ],
                                    ),
                            ),
                            FlatButton(
                              onPressed: ()async {
                                var logout = await showDialog(
                                    context: context,
                                    builder: (context)=>SimpleDialog(
                                      children: [
                                        Icon(FontAwesomeIcons.signOutAlt,size: 85,),
                                        Center(child: Text("Logout dari akun ini?",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 16,fontWeight: FontWeight.w400),)),
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
                                                onPressed: (){
                                                  globVar.user = null;
                                                  prefs.remove("user");
                                                  Navigator.pop(context,true);
                                                },
                                                child: Text("Logout",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
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
                                if(logout??false){
                                  utils.removeBackupGlobVar();
                                  globVar.clear();
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                              minWidth: 180,
                              padding: EdgeInsets.all(10),
                              color: Color.fromRGBO(255, 84, 84, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.signOutAlt,color: Colors.white,size: 20,),
                                  Text("  Logout",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w700),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:10,left: 10,right: 10),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: ()async{
                      Map<String,dynamic> passMap;
                      final _formPassKey = GlobalKey<FormBuilderState>();
                      bool obscure1 = true,obscure2 = true,obscure3 = true;
                      await showDialog(
                          context: context,
                          builder: (context)=>StatefulBuilder(
                              builder: (context,setState)=>SimpleDialog(
                                children: [
                                  FormBuilder(
                                      key: _formPassKey,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FormBuilderTextField(
                                                name:"old",
                                                obscureText: obscure1??true,
                                                validator: (value)=>
                                                value == null || value.isEmpty ? "Masukkan password lama":null,
                                              decoration: InputDecoration(
                                                  suffixIcon: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          obscure1 = !obscure1;
                                                        });
                                                      },
                                                      child: Icon((obscure1)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye)),
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
                                                  hintText: "Password lama"
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FormBuilderTextField(
                                              name:"pass",
                                              obscureText: obscure2??true,
                                              validator: (value)=>
                                              value == null || value.isEmpty ? "Masukkan password baru":null,
                                              decoration: InputDecoration(
                                                  suffixIcon: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          obscure2 = !obscure2;
                                                        });
                                                      },
                                                      child: Icon((obscure2)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye)),
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
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FormBuilderTextField(
                                              name:"confirm",
                                              obscureText: obscure3??true,
                                              decoration: InputDecoration(
                                                  suffixIcon: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          obscure3 = !obscure3;
                                                        });
                                                      },
                                                      child: Icon((obscure3)?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye)),
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
                                                  hintText: "Konfirmasi password"
                                              ),
                                              validator: (value)=>
                                              value == null || value.isEmpty ? "Masukkan password baru":null,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
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
                                          color: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          padding: EdgeInsets.all(10),
                                          onPressed: ()async {
                                            _formPassKey.currentState.save();
                                            if (_formPassKey.currentState.validate()) {
                                                if(_formPassKey.currentState.value["pass"].trim() == _formPassKey.currentState.value["confirm"].trim()){
                                                  passMap = Map<String,dynamic>.from(_formPassKey.currentState.value);
                                                  passMap.remove("confirm");
                                                  for(var i=0;i<passMap.keys.length;i++){
                                                    passMap.update(passMap.keys.toList()[i], (value) => value.trim());
                                                  }
                                                  passMap["login_id"]= globVar.auth.login_id;
                                                    Future future = Auths().changePass(passMap);
                                                    var res = await utils.showLoadingFuture(context,future);
                                                    utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                                                    if(res["STATUS"]) {
                                                      Navigator.pop(context);
                                                    }
                                                }
                                                else{
                                                  utils.toast("Password baru tidak sama",type: "ERROR");
                                                }
                                            }
                                          },
                                          child: Text("Change",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
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
                          )
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FontAwesomeIcons.key,size: 15 ,),
                          SizedBox(width: 10,),
                          Text("Baru",style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FormBuilder(
                    key: _formKey,
                    enabled: toggleEdit,
                    onChanged: (){
                      changed = true;
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: userData,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 25,right: 25,bottom: 25,top: 10),
                      itemCount: globVar.user != null ?globVar.user.toJsonDisplay().keys.length:0,
                        itemBuilder: (context,idx)
                            {
                              var arr = globVar.user.toJsonDisplay().keys.toList();
                              var key = arr[idx];
                              var val = globVar.user.toJsonDisplay()[arr[idx]].toString();
                              Widget formWidget;
                              if(key == 'Tanggal_Lahir'){
                                formWidget = FormBuilderDateTimePicker(
                                  name: key,
                                  validator: (value) =>
                                  value == null ? '$key tidak boleh kosong' : null,
                                  decoration: InputDecoration(
                                    suffixIcon: (toggleEdit)?Icon(FontAwesomeIcons.calendarAlt,color: Color.fromRGBO(35, 35, 222, 1),):Text(''),
                                    border: (toggleEdit)?null:InputBorder.none,
                                    hintText: val==""||val==null?"-":"",
                                  ),
                                  style: TextStyle(fontSize: (val.length>=20)?12:15,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.6)),
                                  format: DateFormat("dd-MMM-yyyy"),
                                  inputType: InputType.date,
                                );
                              }
                              else if(key == "Gender" && toggleEdit){
                                formWidget = FormBuilderChoiceChip(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceEvenly,
                                  name: key,
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
                                        value: 'Male', child: Container(padding: EdgeInsets.all(8.0),child:
                                        Icon(FontAwesomeIcons.male,color: (gender=="Male")?Colors.white:Colors.black,),
                                        )),
                                    FormBuilderFieldOption(
                                        value: 'Female', child: Container(padding:EdgeInsets.all(8.0),child:
                                        Icon(FontAwesomeIcons.female,color: (gender=="Female")?Colors.white:Colors.black,),
                                        )),
                                  ],
                                );
                              }
                              else{
                                formWidget = FormBuilderTextField(
                                  name: key,
                                  validator: (value) =>
                                  ((key.contains("Nama")||key.contains("Phone")||key.contains("Email"))&&(value == null || value.isEmpty)) ? '$key tidak boleh kosong' : null,
                                  decoration: InputDecoration(
                                    border: (toggleEdit)?null:InputBorder.none,
                                    hintText: val==""||val==null?"-":"",
                                  ),
                                  style: TextStyle(fontSize: (val.length>=20)?12:15,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.6)),
                                );
                              }
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(flex:1,child: Text(key.replaceAll("_", " "),style: TextStyle(fontSize: 14,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,color: Color.fromRGBO(146, 146, 146, 1)),)),
                                        Flexible(flex:1,child: Align(alignment: Alignment.centerRight,
                                            child:formWidget
                                            // Text(val,textAlign: TextAlign.right,style: TextStyle(fontSize: (val.length>=20)?12:15,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.6)))
                                        )),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                                );
                            }),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}