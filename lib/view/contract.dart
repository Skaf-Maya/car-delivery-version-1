import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_receipt_controller.dart';
import 'package:vip_delivery_version_1/controller/contract_controller.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/model/contract_image.dart';
import 'package:vip_delivery_version_1/model/history.dart';

class Contract extends StatefulWidget {
  History history;
  List<ContractImage> contract_image;
  Contract(this.history,this.contract_image);

  @override
  State<Contract> createState() => _ContractState(this.history,this.contract_image);
}

class _ContractState extends State<Contract>{
  History history;
  List<ContractImage> contract_image;
  ContractController contractController = Get.put(ContractController());
  CartReceiptController cartReceiptController = Get.find();
  HistoryController historyController = Get.find();

  _ContractState(this.history,this.contract_image) {
    for(int i=0;i<contract_image.length;i++){
      if(contract_image[i].status == 1){
        contractController.deliver_image.add(contract_image[i]);
      }else {
        contractController.receipt_image.add(contract_image[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context)
              ],
            ),
          ),
        ),
      )
    );
  }

  _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage("assets/home/history.png"),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                ),
                Text(
                  App_Localization.of(context)!.translate("contract"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                  ),
                ),
                historyController.introController.temp.length != 0 || historyController.search.text.isNotEmpty ?
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: history.status == "Received" ?
                          AppColors.green : AppColors.yellow
                  ),
                ) :
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: historyController.select_history.value == 0 ?
                      AppColors.green : historyController.select_history.value ==1 ?
                      AppColors.yellow : AppColors.red
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        _plate(context),
        SizedBox(height: 15,),
        _contract_number(context),
        SizedBox(height: 15,),
        _client_name(context),
        SizedBox(height: 15,),
        _client_phone(context),
        SizedBox(height: 15,),
        _driver_name(context),
        SizedBox(height: 10,),
        contractController.deliver_image.length > 0 ?
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  Text(
                    App_Localization.of(context)!.translate("car_delivery_Ph_Vi"),
                    style: TextStyle(
                        color: AppColors.main3,
                        fontSize: 18
                    ),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            _deliver_images()
          ],
        ) : Center(),
        historyController.introController.temp.length != 0 || historyController.search.text.isNotEmpty ?
        Column(
          children: [
            history.status == "Received" ?
            Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Text(
                        App_Localization.of(context)!.translate("car_receipt_Ph_Vi"),
                        style: TextStyle(
                            color: AppColors.main3,
                            fontSize: 18
                        ),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                _receiper_images(),
              ],
            ) : Center(),
          ],
        ) :
        Column(
          children: [
            contractController.receipt_image.length > 0 &&
                historyController.select_history.value == 0 ?
            Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Text(
                        App_Localization.of(context)!.translate("car_receipt_Ph_Vi"),
                        style: TextStyle(
                            color: AppColors.main3,
                            fontSize: 18
                        ),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                _receiper_images(),
              ],
            ) : Center(),
          ],
        ),
        SizedBox(height: 30,),
      ],
    );
  }
  // _code_emirate_plate(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(5),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             height: 40,
  //             width: MediaQuery.of(context).size.width * 0.28,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 border: Border.all(
  //                     color: Colors.black87
  //                 )
  //             ),
  //             child: Center(
  //                 child:
  //                 Text(
  //                   history.carPlate.substring(0,1),
  //                   //history.status,
  //                   style: TextStyle(
  //                       fontSize: 20
  //                   ),)),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.25,
  //             child: Center(
  //                 child: Text(
  //               history.carPlate.substring(1,history.carPlate.length),
  //               //     history.carPlate,
  //               style: TextStyle(fontSize: 20),
  //             )),
  //           ),
  //           Container(
  //               height: 40,
  //               width: MediaQuery.of(context).size.width * 0.28,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(5),
  //                   border: Border.all(
  //                       color: Colors.black87
  //                   )
  //               ),
  //               child: Center(
  //                   child:
  //                   Text(
  //                     history.contractNumber,
  //                     style: TextStyle(
  //                         fontSize: 20
  //                     ),))
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  _plate(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("code_emirate_plate"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                    history.carPlate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _driver_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("driver's_name"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                    history.delivered,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _client_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("client_name"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                   history.clientName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _client_phone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("client_phone"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text( history.clientPhone,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _contract_number(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("contract_number"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(history.contractNumber,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _deliver_images() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView.builder(
            itemCount: contractController.deliver_image.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    if(contractController.deliver_image[index].mediaUrl!.endsWith(".mp4")){
                      contractController.videoPlayerController =
                      VideoPlayerController.network(
                          contractController.media_url + contractController.deliver_image[index].mediaUrl.toString())
                        ..initialize().then((_) {
                          contractController.videoPlayerController!.play();
                          Get.back();
                          _show_video(context);
                        });
                      _laoding_video(context);
                    }else {
                      _show_image(context, contractController.deliver_image[index].mediaUrl.toString());
                    }
                  },
                  child: contractController.deliver_image[index].mediaUrl!.endsWith(".mp4") ?
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color: AppColors.main3),
                        borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Icon(
                          Icons.video_call_outlined,
                          color: Colors.white,size: 50,)),
                  ) :
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color: AppColors.main3),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  contractController.media_url+contractController.deliver_image[index].mediaUrl.toString()
                              ),
                              fit: BoxFit.cover
                          )
                      )
                  ),
                ),
              );
            })
    );
  }
  _receiper_images() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width*0.9,
        child: ListView.builder(
            itemCount: contractController.receipt_image.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    if(contractController.receipt_image[index].mediaUrl!.endsWith(".mp4")){
                      contractController.videoPlayerController =
                      VideoPlayerController.network(
                          contractController.media_url + contractController.receipt_image[index].mediaUrl.toString())
                        ..initialize().then((_) {
                          contractController.videoPlayerController!.play();
                          Get.back();
                          _show_video(context);
                        });
                      _laoding_video(context);
                    }else {
                      _show_image(context, contractController.receipt_image[index].mediaUrl.toString());
                    }
                  },
                  child: contractController.receipt_image[index].mediaUrl!.endsWith(".mp4") ?
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2,color: AppColors.main3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Icon(
                          Icons.video_call_outlined,
                          color: Colors.white,size: 50,)),
                  ) :
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color: AppColors.main3),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                contractController.media_url+contractController.receipt_image[index].mediaUrl.toString()                            ),
                            fit: BoxFit.cover
                        )
                    )
                  ),
                ),
              );
            })
    );
  }
  _show_image(BuildContext context,String path) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Stack(
              children: [
                Container(
                  color: AppColors.main.withOpacity(0.95),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.network(contractController.media_url+path,fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColors.main,
                      size: 25,
                    ),
                  ),
                ),
              ],
            )
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  _show_video(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Stack(
              children: [
                Container(
                  color: AppColors.main.withOpacity(0.95),
                  child:  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width,
                            child: VideoPlayer(contractController.videoPlayerController!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => GestureDetector(
                                  onTap: () {
                                    contractController.is_play.value = !contractController.is_play.value;
                                    if(contractController.videoPlayerController!.value.isPlaying || contractController.is_play.value){
                                      contractController.videoPlayerController!.pause();
                                    }
                                    else {
                                      contractController.videoPlayerController!.play();
                                    }
                                  },
                                  child: !contractController.is_play.value ?
                                  Icon(Icons.pause,color: Colors.white, size: 30,):
                                  Icon(Icons.play_arrow,color: Colors.white, size: 30),
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColors.main,
                      size: 25,
                    ),
                  ),
                )
              ],
            )

        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  _laoding_video(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Container(
          color: AppColors.main.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator(color: AppColors.main3,)),
              )
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
